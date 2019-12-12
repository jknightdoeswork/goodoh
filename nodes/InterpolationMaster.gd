extends Node

var last_physics_update_timestamps := []
var current_timestamp_index := 0
var interpolation_factor := 0.0

var physics_time := 0.0
var update_time := 0.0

func _ready() -> void:
	last_physics_update_timestamps.resize(2)

func _physics_process(delta: float) -> void:
	physics_time += delta
	current_timestamp_index = old_time_index()
	last_physics_update_timestamps[current_timestamp_index] = physics_time


func _process(delta: float) -> void:
	update_time += delta
	
	var newer_time = last_physics_update_timestamps[current_timestamp_index]
	var older_time = last_physics_update_timestamps[old_time_index()]
	
	if newer_time != older_time:
		interpolation_factor = (update_time - newer_time) / (newer_time - older_time)
	
func old_time_index() -> int:
	if current_timestamp_index == 0:
		return 1
	return 0
