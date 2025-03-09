extends Node

## 配置管理器

# 信号
## 配置加载
signal config_loaded
## 配置保存
signal config_saved
## 配置重置
signal config_reset

const SETTING_CONFIG_PATH: String = "godot_core_system/config_system/config_path"
const SETTING_AUTO_SAVE: String = "godot_core_system/config_system/auto_save"

const DefaultConfig = preload("res://addons/godot_core_system/source/serialization/config_system/default_config.gd")

## 配置文件路径
@export var config_path: String:
	get:
		return ProjectSettings.get_setting(SETTING_CONFIG_PATH, "user://config.cfg")
	set(_value):
		CoreSystem.logger.error("read-only")

## 是否自动保存
@export var auto_save: bool:
	get:
		return ProjectSettings.get_setting(SETTING_AUTO_SAVE, true)
	set(_value):
		CoreSystem.logger.error("read-only")

## 当前配置
var _config: Dictionary = {}
## 异步IO管理器
var _io_manager: CoreSystem.AsyncIOManager = CoreSystem.io_manager
## 是否已修改
var _modified: bool = false


func _init(_data: Dictionary = {}):
	_config = DefaultConfig.get_default_config()


func _exit() -> void:
	if auto_save and _modified:
		save_config()

## 加载配置
## [param callback] 回调函数
func load_config(callback: Callable = Callable()) -> void:
	_io_manager.read_file_async(
		config_path,
		true,
		"",
		func(success: bool, result: Variant):
			if success:
				# 合并加载的配置和默认配置
				var default_config = DefaultConfig.get_default_config()
				_merge_config(default_config, result)
				_config = default_config
			else:
				# 使用默认配置
				_config = DefaultConfig.get_default_config()
			_modified = false
			config_loaded.emit()
			if callback.is_valid():
				callback.call(success)
	)

## 保存配置
## [param callback] 回调函数
func save_config(callback: Callable = Callable()) -> void:
	_io_manager.write_file_async(
		config_path,
		_config,
		true,
		"",
		func(success: bool, _result: Variant):
			if success:
				_modified = false
				config_saved.emit()
			if callback.is_valid():
				callback.call(success)
	)

## 重置配置
## [param callback] 回调函数
func reset_config(callback: Callable = Callable()) -> void:
	_config = DefaultConfig.get_default_config()
	_modified = true
	config_reset.emit()

	if auto_save:
		save_config(callback)
	else:
		if callback.is_valid():
			callback.call(true)

## 设置配置值
## [param section] 配置段
## [param key] 键
## [param value] 值
func set_value(section: String, key: String, value: Variant) -> void:
	if not _config.has(section):
		_config[section] = {}
	_config[section][key] = value
	_modified = true

	if auto_save:
		save_config()

## 获取配置值
## [param section] 配置段
## [param key] 键
## [param default_value] 默认值
## [return] 值
func get_value(section: String, key: String, default_value: Variant = null) -> Variant:
	var value = default_value
	
	if _config.has(section) and _config[section].has(key):
		value = _config[section][key]
	else:
		# 从默认配置获取
		var default_config = DefaultConfig.get_default_config()
		if default_config.has(section) and default_config[section].has(key):
			value = default_config[section][key]
	
	# 处理特殊类型转换
	if value is String:
		# 尝试将字符串转换为Vector2
		if value.begins_with("(") and value.ends_with(")"):
			var components = value.trim_prefix("(").trim_suffix(")").split(",")
			if components.size() == 2:
				var x = components[0].to_float()
				var y = components[1].to_float()
				return Vector2(x, y)
	
	return value

## 删除配置值
## [param section] 配置段
## [param key] 键
func erase_value(section: String, key: String) -> void:
	if _config.has(section):
		_config[section].erase(key)
		_modified = true

		if auto_save:
			save_config()

## 获取配置段
## [param section] 配置段
## [return] 配置段
func get_section(section: String) -> Dictionary:
	return _config.get(section, {}).duplicate()

## 合并配置
## [param target] 目标配置
## [param source] 源配置
func _merge_config(target: Dictionary, source: Dictionary) -> void:
	for key in source:
		if target.has(key):
			if source[key] is Dictionary and target[key] is Dictionary:
				_merge_config(target[key], source[key])
			else:
				target[key] = source[key]
