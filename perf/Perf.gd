extends Node

var sample_stack := []
var sample_dict := {}

func begin_sample():
	sample_stack.push_front(OS.get_ticks_usec())
		
func end_sample(s:String):
	var now := OS.get_ticks_usec()
	var then:int = sample_stack.pop_front()
	var delta = (now - then) / 1000.0
	sample_dict[s] = sample_dict.get(s, 0.0) + delta
	

func print_samples():
	print("[Perf]")
	for sample_name in sample_dict:
		var sample_delta = sample_dict[sample_name]
		print ("[Perf]\t%s\t\t%s" % [sample_name, sample_delta])
	sample_dict.clear()
