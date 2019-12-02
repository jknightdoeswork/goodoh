extends CheckButton

class_name SavedCheckButton

export(String) var setting_key
export(bool) var default_value

func _ready() -> void:
	# Set initial option using setting_key
	var initial_value = SavedSettings.set_default_value(setting_key, default_value)
	if setting_key and setting_key.length() > 0:
		# Parse initial value from settings
		initial_value 	= SavedSettings.get_value(setting_key, default_value)
		
		# Connect signal
		var error = connect("toggled", self, "on_toggle")
		assert(!error)
	else:
		print ("[SavedCheckButton] " + name  + " has no setting key.")

	# Apply initial value
	pressed	= initial_value
		
func on_toggle(item_index):
	# Store value on option changed
	SavedSettings.set_value(setting_key, item_index)
