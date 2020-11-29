extends LineEdit
class_name LineEditNumeric

signal on_number_changed

export var allow_negative := false
export var do_minimum := false
export var minimum := 0
export var do_maximum := false
export var maximum := 0

var number := 0

func _ready():
	process_text(self.text, true)
	connect("text_changed", self, "on_text_changed")
	connect("focus_exited", self, "on_focus_exit")

func on_focus_exit():
	process_text(self.text, true)

func on_text_changed(new_text:String):
	process_text(new_text, false)

func process_text(new_text:String, override_text:bool):
	var valid_text := ""
	var cursor := self.caret_position
	var rejected_digits := 0
	var old_number := self.number
	var iterator := 0
	for c in new_text:
		if allow_negative and iterator == 0 and c == '-':
			valid_text += c
		elif c.is_valid_integer():
			valid_text += c
		else:
			rejected_digits += 1
		
		iterator += 1
	
	
	
	var reset:bool = valid_text.length() == 0
	var new_cursor := 0
	if reset:
		valid_text = str(0)
		new_cursor = valid_text.length()
	if do_minimum and int(valid_text) < minimum:
		valid_text = str(minimum)
		new_cursor = valid_text.length()
	elif do_maximum and int(valid_text) > maximum:
		valid_text = str(maximum)
		new_cursor = valid_text.length()
	elif !reset:
		new_cursor = cursor - rejected_digits
	
	self.number = int(valid_text)
	if override_text:
		self.text = valid_text
		self.caret_position = new_cursor
	
	if self.number != old_number:
		emit_signal("on_number_changed", self.number)
