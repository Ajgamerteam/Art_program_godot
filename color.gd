extends Node2D

onready var t = preload("res://brush/circle.png")
onready var can = $"../ViewportContainer/Viewport/canvas"
onready var b = preload("res://Button.tscn")
export var colors = [
	Color(1, 0, 0),    # Red
	Color(0, 1, 0),    # Green
	Color(0, 0, 1),    # Blue
	Color(1, 1, 0),    # Yellow
	Color(1, 0, 1),    # Magenta
	Color(0, 1, 1),    # Cyan
	Color(1, 0.5, 0),  # Orange
	Color(0.5, 1, 0),  # Lime
	Color(0, 0.5, 1),  # Sky blue
	Color(0.5, 0, 1),  # Purple
	Color(1, 0, 0.5),  # Pink
	Color(0, 1, 0.5),  # Chartreuse
	Color(0.5, 0, 0),  # Maroon
	Color(0, 0.5, 0),  # Forest green
	Color(0, 0, 0.5),  # Navy
	Color(0.5, 0.5, 0),# Olive
	Color(0.5, 0, 0.5),# Plum
	Color(0, 0.5, 0.5),# Teal
	Color(0.5, 0.5, 0.5),# Gray
	Color(1, 1, 1)     # White
]


export var v = Vector2(65,60)

var tween = Tween.new()
var start_pos = Vector2(0, 0)
var end_pos = Vector2(100, 100)

func create_button(index):
	print()
	var button = b.instance()
	#var texture = load("res://icon.png")
	button.icon = t
	#button.set_normal_texture(texture)
	button.set_modulate(colors[index])
	var x = int(index/10)*v.x + 0#offset
	var y = wrapi(index,0,10)*v.y
	add_child(button)
	set_owner(self)
	button.rect_scale = Vector2(0.8,0.8)
	button.rect_position = Vector2(x,y)
	button.connect("button_down",self,"change",[button.modulate])
func change(c):
	can.current_color = c
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		pass
func _ready():
	for i in colors.size():
		create_button(i)







func _on_ColorPickerButton_color_changed(color):
	can.current_color = color


func _on_ColorPickerButton_pressed():
	can.current_color = $"../ColorPickerButton".color
