extends Spatial

onready var gui = $gui
onready var object = $object

func _ready():
	gui.connect("ui_rotate", self, "rotate_object", [])
	gui.connect("ui_load", self, "load_object", [])

func load_object(path):
	var elem = load(path)
	if elem:
		for child in object.get_children():
			child.queue_free()
		var inst = elem.instance()
		yield(get_tree(), "idle_frame") # skiping frame to clearing object banch
		object.add_child(inst, true)
		print("reload object (path: '%s', ps: %s, inst: %s, name: '%s')" % 
								[path, elem, inst, inst.name])

func rotate_object(degrees):
	print("rotate command: XYZ[0°, %s%s°, 0°]" % ['' if degrees < 0 else '+', degrees])
	if object:
		object.rotation_degrees += Vector3(0, degrees, 0)
