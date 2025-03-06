@tool
extends EditorPlugin


const SYSTEM_NAME: String = "System"
const SYSTEM_PATH: String = "res://addons/godot_core_system/system.gd"

const SETTING_SCRIPT: Script = preload("res://addons/godot_core_system/setting.gd")
const SETTING_INFO_DICT: Dictionary[StringName, Dictionary] = SETTING_SCRIPT.SETTING_INFO_DICT


func _enter_tree() -> void:
	_add_project_settings()
	add_autoload_singleton(SYSTEM_NAME, SYSTEM_PATH)
	ProjectSettings.save()


func _exit_tree():
	ProjectSettings.save()
	remove_autoload_singleton(SYSTEM_NAME)
	_remove_project_setting()


func _add_project_settings() -> void:
	for setting_dict in SETTING_INFO_DICT.values():
		_add_setting_dict(setting_dict)


func _remove_project_setting() -> void:
	for setting_dict in SETTING_INFO_DICT.values():
		_remove_setting_dict(setting_dict)


func _add_setting_dict(info_dict: Dictionary) -> void:
	var setting_name: String = info_dict["name"]
	if not ProjectSettings.has_setting(setting_name):
		ProjectSettings.set_setting(setting_name, info_dict["default"])

	ProjectSettings.set_as_basic(setting_name, info_dict["basic"])
	ProjectSettings.set_initial_value(setting_name, info_dict["default"])
	ProjectSettings.add_property_info(info_dict)


func _remove_setting_dict(info_dict: Dictionary) -> void:
	var setting_name: String = info_dict["name"]
	if ProjectSettings.has_setting(setting_name):
		ProjectSettings.set_setting(setting_name, null)
