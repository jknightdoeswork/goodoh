extends OptionButtonOptions

class_name ProjectSettingsOptionButton

export(String) var project_setting_name := ""

func _ready() -> void:
	var initial_setting = ProjectSettings.get_setting(project_setting_name)
	print ("initial setting: " + str(initial_setting))
	select(initial_setting)

func on_option_selected(item_index):
	# Store value on option changed
	print ("[ProjectSettingsOptionButton] setting " + project_setting_name + " to " + str(item_index))
	ProjectSettings.set_setting(project_setting_name, item_index)
	var error = ProjectSettings.save()
	assert(!error)
