extends Label
class_name FPSLabel

func _process(_delta):
	if self.is_visible_in_tree():
		self.text = str(Engine.get_frames_per_second()) + "FPS"
