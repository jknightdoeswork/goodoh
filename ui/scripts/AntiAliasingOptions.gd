extends SavedOptionButton

class_name AntiAliasingOptions

func on_option_selected(item_index):
	print ("[AntiAliasingOptions] selecting " + str(item_index))
	var viewport = get_viewport()
	if item_index == 0:
		viewport.msaa = Viewport.MSAA_DISABLED
	elif item_index == 1:
		viewport.msaa = Viewport.MSAA_2X
	elif item_index == 2:
		viewport.msaa = Viewport.MSAA_4X
	elif item_index == 3:
		viewport.msaa = Viewport.MSAA_8X
	elif item_index == 4:
		viewport.msaa = Viewport.MSAA_16X
	else:
		printerr("[AntiAliasingOptions] on_option_selected unknown option " + str(item_index))

func _ready():
	var current_option := 0
	
	var viewport = get_viewport()
	if viewport.msaa == Viewport.MSAA_DISABLED:
		current_option = 0
	elif viewport.msaa == Viewport.MSAA_2X:
		current_option = 1
	elif viewport.msaa == Viewport.MSAA_4X:
		current_option = 2
	elif viewport.msaa == Viewport.MSAA_8X:
		current_option = 3
	elif viewport.msaa == Viewport.MSAA_16X:
		current_option = 4
	
	select(current_option)
