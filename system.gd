extends Node


const ModuleBase: Script = preload("res://addons/godot_system/module/module_base.gd")
const ModuleTest: = preload("res://addons/godot_system/module/module_test/test_manager.gd")

const ModuleLog: = preload("res://addons/godot_system/module/module_log/log_manager.gd")
const ModuleAsyncIO: = preload("res://addons/godot_system/module/module_data/module_async_io/async_io_manager.gd")
const ModuleSave: = preload("res://addons/godot_system/module/module_data/module_save/save_manager.gd")
const ModuleConfig: = preload("res://addons/godot_system/module/module_data/module_config/config_manager.gd")

const ModuleTime: = preload("res://addons/godot_system/module/module_time/time_manager.gd")
const ModuleInput: = preload("res://addons/godot_system/module/module_input/input_manager.gd")
const ModuleAudio: = preload("res://addons/godot_system/module/module_audio/audio_manager.gd")

const ModuleFile: = preload("res://addons/godot_system/module/module_data/module_file/file_manager.gd")
const ModuleResource: = preload("res://addons/godot_system/module/module_resource/resource_manager.gd")

const ModuleEntity: = preload("res://addons/godot_system/module/module_entity/entity_manager.gd")
const ModuleNode: = preload("res://addons/godot_system/module/module_node/node_manager.gd")
const ModuleScene: = preload("res://addons/godot_system/module/module_scene/scene_manager.gd")

const ModuleEvent: = preload("res://addons/godot_system/module/module_event/event_manager.gd")
const ModuleState: = preload("res://addons/godot_system/module/module_state/state_manager.gd")
const ModuleTrigger: = preload("res://addons/godot_system/module/module_trigger/trigger_manager.gd")
const ModuleTag: = preload("res://addons/godot_system/module/module_tag/tag_manager.gd")

var test_manager: ModuleTest:
	get: return get_module("test_manager")
	set(value): push_error("test_manager is read-only.")

var log_manager: ModuleLog:
	get: return get_module("log_manager")
	set(value): push_error("log_manager is read-only.")

var io_manager: ModuleAsyncIO:
	get: return get_module("io_manager")
	set(value): push_error("io_manager is read-only.")

var save_manager: ModuleSave:
	get: return get_module("save_manager")
	set(value): push_error("save_manager is read-only.")

var config_manager: ModuleConfig:
	get: return get_module("config_manager")
	set(value): push_error("config_manager is read-only.")

var time_manager: ModuleTime:
	get: return get_module("time_manager")
	set(value): push_error("time_manager is read-only.")

var input_manager: ModuleInput:
	get: return get_module("input_manager")
	set(value): push_error("input_manager is read-only.")

var audio_manager: ModuleAudio:
	get: return get_module("audio_manager")
	set(value): push_error("audio_manager is read-only.")

var file_manager: ModuleTest:
	get: return get_module("file_manager")
	set(value): push_error("file_manager is read-only.")

var resource_manager: ModuleResource:
	get: return get_module("resource_manager")
	set(value): push_error("resource_manager is read-only.")

var entity_manager: ModuleEntity:
	get: return get_module("entity_manager")
	set(value): push_error("entity_manager is read-only.")

var node_manager: ModuleNode:
	get: return get_module("node_manager")
	set(value): push_error("node_manager is read-only.")

var scene_manager: ModuleScene:
	get: return get_module("scene_manager")
	set(value): push_error("scene_manager is read-only.")

var event_manager: ModuleEvent:
	get: return get_module("event_manager")
	set(value): push_error("event_manager is read-only.")

var state_manager: ModuleState:
	get: return get_module("state_manager")
	set(value): push_error("state_manager is read-only.")

var trigger_manager: ModuleTrigger:
	get: return get_module("trigger_manager")
	set(value): push_error("trigger_manager is read-only.")

var tag_manager: ModuleTag:
	get: return get_module("tag_manager")
	set(value): push_error("tag_manager is read-only.")

var _modules: Dictionary[StringName, ModuleBase]
var _module_scripts: Dictionary[StringName, Script] = {
	"test_manager": ModuleTest,
	"log_manager": ModuleLog,
	"io_manager": ModuleAsyncIO,
	"save_manager": ModuleSave,
	"config_manager": ModuleConfig,
	"time_manager": ModuleTime,
	"input_manager": ModuleInput,
	"audio_manager": ModuleAudio,
	"file_manager": ModuleFile,
	"resource_manager": ModuleResource,
	"entity_manager": ModuleEntity,
	"node_manager": ModuleNode,
	"scene_manager": ModuleScene,
	"event_manager": ModuleEvent,
	"state_manager": ModuleState,
	"trigger_manager": ModuleTrigger,
	"tag_manager": ModuleTag,
}


func _input(event: InputEvent) -> void:
	for module in _modules.values() as Array[ModuleBase]:
		module._input(event)


func _process(delta: float) -> void:
	for module in _modules.values() as Array[ModuleBase]:
		module._process(delta)


func _physics_process(delta: float) -> void:
	for module in _modules.values() as Array[ModuleBase]:
		module._physics_process(delta)


## 获取模块
func get_module(module_id: StringName, data: Dictionary = {}) -> ModuleBase:
	if not _modules.has(module_id):
		if is_module_enabled(module_id):
			_modules[module_id] = _create_module(module_id, data)
		else:
			push_error("模块未启用：" + module_id)
			return null
	return _modules[module_id]


## 检查模块是否启用
func is_module_enabled(module_id: StringName) -> bool:
	var setting_name: String = "godot_system/module_enable/" + module_id
	if not ProjectSettings.has_setting(setting_name): return true
	return ProjectSettings.get_setting(setting_name, true)


## 创建模块实例
func _create_module(module_id: StringName, data: Dictionary = {}) -> ModuleBase:
	var script: Script = _module_scripts[module_id]
	if not script:
		push_error("无法加载模块脚本：" + module_id)
		return null

	var module: ModuleBase = script.new(data)
	if not module:
		push_error("无法创建模块实例：" + module_id)
		return null

	_modules[module_id] = module
	module._system = self
	module._ready()
	return module


## 手动卸载指定模快
func _unload_module(module_id: StringName) -> void:
	if not _modules.has(module_id):
		print(module_id, "模块未被实例化")
		return

	var module: ModuleBase = _modules[module_id]
	var instance_id: int = module.get_instance_id()
	module._exit()
	_modules.erase(module_id)
	print("卸载模块实例：%s id%s" % [module_id, instance_id])
