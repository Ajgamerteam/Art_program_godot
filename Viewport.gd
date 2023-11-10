extends Viewport


func _physics_process(delta):
	get_parent().rect_position.x += delta*100

