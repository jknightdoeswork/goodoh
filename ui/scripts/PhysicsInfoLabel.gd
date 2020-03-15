extends Label

func _process(delta: float) -> void:
	self.text = "active_objects: %s\ncollision_pairs: %s\nisland_count: %s" % [
		Physics2DServer.get_process_info(Physics2DServer.INFO_ACTIVE_OBJECTS),
		Physics2DServer.get_process_info(Physics2DServer.INFO_COLLISION_PAIRS),
		Physics2DServer.get_process_info(Physics2DServer.INFO_ISLAND_COUNT)]

