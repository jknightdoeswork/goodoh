extends LineEdit
class_name LineEditNumeric

signal on_numeric_text_changed

var number := 0

func _ready():
	connect("text_changed", self, "on_text_changed")

func on_text_changed(new_text:String):
	var valid_text := ""
	var cursor := self.caret_position
	var rejected_digits := 0
	for c in new_text:
		if c.is_valid_integer():
			valid_text += c
		else:
			rejected_digits += 1
	
	self.number = int(number)
	self.text = valid_text
	self.caret_position = cursor-rejected_digits
	
	if rejected_digits == 0:
		emit_signal("on_numeric_text_changed")
