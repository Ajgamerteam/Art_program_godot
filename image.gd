extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func images():
	var view = $Viewport
	var i = Image.new()
	i = view.get_texture().get_data()
	$"../dummy".texture = i

func get_viewport_image(path):
	var texture = $Viewport.get_texture().get_data()
	texture.flip_y()
	#texture.
	texture.save_png(path)
	#return texture

func _on_Down_pressed():
	var path = "res://bn.png"
	get_viewport_image(path)
	download("res://bn.png")

func download(path):
	var f = File.new()
	f.open(path,File.READ)
	var buf = f.get_buffer(f.get_len())
	JavaScript.download_buffer(buf,"image.png")
	f.close()



