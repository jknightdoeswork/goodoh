extends CheckButton

class_name SavedCheckButton

export(String) var setting_key
export(bool) var default_value

onready var saved_settings = Engine.get_singleton("SavedSettings")

func _ready() -> void:
	#assert(saved_settings != null)
	
	# Set initial option using setting_key
	if saved_settings != null:
		var initial_value = saved_settings.set_default_value(setting_key, default_value)
		if setting_key and setting_key.length() > 0:
			# Parse initial value from settings
			initial_value 	= saved_settings.get_value(setting_key, default_value)
			
			# Connect signal
			var error = connect("toggled", self, "on_toggle")
			assert(!error)
		else:
			print ("[SavedCheckButton] " + name  + " has no setting key.")

		# Apply initial value
		pressed	= initial_value
		
func on_toggle(item_index):
	# Store value on option changed
	if saved_settings != null:
		saved_settings.set_value(setting_key, item_index)
