extends "res://addons/godot_core_system/modules/module_base.gd"


func get_exe_dir_path() -> String:
	return OS.get_executable_path().get_base_dir()


func get_user_dir_path() -> String:
	return ProjectSettings.globalize_path("user://")
