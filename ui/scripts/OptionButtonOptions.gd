extends OptionButton

class_name OptionButtonOptions

export(Array, String) var options
export(int) var default_value

func _ready() -> void:
	# Set options using options variable
	clear()
	for o in options:
		assert(o is String)
		add_item(o)
	
	# Apply initial value
	select(default_value)
	
	# Connect signal
	var error = connect("item_selected", self, "on_option_selected")
	assert(!error)


func on_option_selected(item_index):
	print ("[OptionButtonOptions] on_option_selected " + str(item_index))
	
