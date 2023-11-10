extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var col : Color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _draw():
	var r = Rect2(Vector2(0.0,0.0),Vector2($"..".size))
	draw_rect(r,Color(1, 1, 1))
