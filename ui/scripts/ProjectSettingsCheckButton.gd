extends Node

class_name ProjectSettingsCheckButton

export(bool) var flip_toggle := false
export(String) var project_setting_name := ""

func _ready() -> void:
	var parent = get_parent()
	assert (parent is CheckButton)
	if parent is SavedCheckButton:
		var initial_value = ProjectSettings.get_setting(project_setting_name)
		if flip_toggle:
			initial_value = !initial_value
		parent.default_value = initial_value
	# Connect signal
	var error = parent.connect("toggled", self, "on_toggle")
	assert(!error)

func on_toggle(toggled):
	if flip_toggle:
		toggled = !toggled
	print ("[ProjectSettingsCheckButton] setting " + project_setting_name + " to " + str(toggled))
	ProjectSettings.set_setting(project_setting_name, toggled)
	var error = ProjectSettings.save()
	assert(!error)
