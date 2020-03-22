extends Node

var sample_stack := []

func begin_sample():
	sample_stack.push_front(OS.get_ticks_usec())
func end_sample(s:String):
	var now := OS.get_ticks_usec()
	var then:int = sample_stack.pop_front()
	var delta = (now - then) / 1000.0
	print ("[Perf]\t%s\t\t%s"%[s, delta])
	
