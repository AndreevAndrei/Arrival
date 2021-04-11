extends CanvasLayer

export var sensitivity = 15

onready var load_button = $load
onready var left_button = $left
onready var right_button = $right
onready var file_path = $file_path_dialog

signal ui_load(path)
signal ui_rotate(degrees)

func _ready():
	file_path.connect("file_selected", self, "loader", [])
	load_button.connect("pressed", file_path, "popup", [])
	left_button.connect("pressed", self, "rotate", ["left"])
	right_button.connect("pressed", self, "rotate", ["right"])

func rotate(direction):
	emit_signal("ui_rotate", sensitivity * (-1 if direction=="left" else 1))

func loader(path):
	emit_signal("ui_load", path)
