extends RefCounted


const SETTING_MODULE_ENABLE: String = "godot_core_system/module_enable/"
const SETTING_MODULE_SAVE: String = "godot_core_system/module_save/"
const SETTING_MODULE_CONFIG: String = "godot_core_system/module_config/"

const SETTING_INFO_DICT: Dictionary[StringName, Dictionary] = {
	"module_enable/test_manager":
	{
		"name": SETTING_MODULE_ENABLE + "test_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/log_manager":
	{
		"name": SETTING_MODULE_ENABLE + "log_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/io_manager":
	{
		"name": SETTING_MODULE_ENABLE + "io_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/save_manager":
	{
		"name": SETTING_MODULE_ENABLE + "save_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/config_manager":
	{
		"name": SETTING_MODULE_ENABLE + "config_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/time_manager":
	{
		"name": SETTING_MODULE_ENABLE + "time_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/input_manager":
	{
		"name": SETTING_MODULE_ENABLE + "input_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/audio_manager":
	{
		"name": SETTING_MODULE_ENABLE + "audio_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/file_manager":
	{
		"name": SETTING_MODULE_ENABLE + "file_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/resource_manager":
	{
		"name": SETTING_MODULE_ENABLE + "resource_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/entity_manager":
	{
		"name": SETTING_MODULE_ENABLE + "entity_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/node_manager":
	{
		"name": SETTING_MODULE_ENABLE + "node_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/scene_manager":
	{
		"name": SETTING_MODULE_ENABLE + "scene_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/event_manager":
	{
		"name": SETTING_MODULE_ENABLE + "event_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/state_manager":
	{
		"name": SETTING_MODULE_ENABLE + "state_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/trigger_manager":
	{
		"name": SETTING_MODULE_ENABLE + "trigger_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_enable/tag_manager":
	{
		"name": SETTING_MODULE_ENABLE + "tag_manager",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_save/save_directory":
	{
		"name": SETTING_MODULE_SAVE + "save_directory",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_DIR,
		"hint_string": "存档目录路径",
		"basic": true,
		"default": "user://saves",
	},

	"module_save/save_extension":
	{
		"name": SETTING_MODULE_SAVE + "save_extension",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": "sav",
	},

	"module_save/max_auto_saves":
	{
		"name": SETTING_MODULE_SAVE + "max_auto_saves",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1, 100, 1, or_greater",
		"basic": true,
		"default": 3,
	},

	"module_save/auto_save_interval":
	{
		"name": SETTING_MODULE_SAVE + "auto_save_interval",
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0, 3600, 1, or_greater",
		"basic": true,
		"default": 300.0,
	},

	"module_save/auto_save_enabled":
	{
		"name": SETTING_MODULE_SAVE + "auto_save_enabled",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},

	"module_config/save_path":
	{
		"name": SETTING_MODULE_CONFIG + "save_path",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_FILE,
		"hint_string": "配置文件路径",
		"basic": true,
		"default": "user://config.cfg",
	},

	"module_config/auto_save_enabled":
	{
		"name": SETTING_MODULE_CONFIG + "auto_save_enabled",
		"type": TYPE_BOOL,
		"hint": PROPERTY_HINT_NONE,
		"hint_string": "",
		"basic": true,
		"default": true,
	},
}
