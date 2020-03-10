extends Node

var sample_stack := []

func begin_sample():
	sample_stack.push_front(OS.get_ticks_usec())
func end_sample(s:String):
	var delta = OS.get_ticks_usec() - sample_stack.pop_front()
	print ("[Perf]\t%s\t\t%s"%[s, delta])
	
