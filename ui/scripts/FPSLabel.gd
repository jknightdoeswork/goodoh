extends Label
class_name FPSLabel

func _process(_delta):
	self.text = str(Engine.get_frames_per_second()) + "FPS"
