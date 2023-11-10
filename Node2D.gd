extends Node2D

onready var texture = preload("res://brush/circle.png")
export var current_color = Color(1, 1, 1)

onready var p = preload("res://Sprite.tscn")


var index = -1
var spawn = null
var num_textures: int = 1

var cur = Vector2()
var pre = Vector2()

var cura = []
var prea = []


var touch_x = 0
var touch_y = 0
var id = null

func _input(event):
	yield(get_tree(),"idle_frame")
	if event is InputEventScreenTouch :
		var touch = event as InputEventScreenTouch
		if event.pressed == false and index == event.index:
			del()
			index = -1
		if event.pressed == true and index == -1:
			index = event.index
			spawn = first()
			cur = touch.position
			pre = null
			cura.append(cur)
			prea.append(pre)
			#update()
			d()
			pre = cur
			cura = []
			prea = []
		#print("Touch position: ", touch.position , touch.index)
	if event is InputEventScreenDrag and event.index == index:
		var drag = event as InputEventScreenDrag
		#print("Drag position: ", drag.position )
		cur = drag.position
		cura.append(cur)
		prea.append(pre)
		d()
		#update()
		pre = cur
		cura = []
		prea = []



var sc = 0.25
func _ready():
	pass


func _physics_process(delta):
	#var current_position = _input()
	#del()
	if Input.is_action_just_released("ui_up"):
		print(prea)


func first():
	for i in get_children():
		i.queue_free()
	var o = Node2D.new()
	#var o = n.instance()
	add_child(o)
	o.set_owner(self)
	return o

func del():
	#print('delete')
	var viewport_texture = $"..".get_texture()
	var image = viewport_texture.get_data()
	image.convert(Image.FORMAT_RGBA8)
	image.flip_y()
	var e = ImageTexture.new()
	e.create_from_image(image)
	
	
	$"../Sprite".texture = e
	spawn.queue_free()
	var node = Node2D.new()
	add_child(node)
	node.set_owner(self)
	spawn = node
	#for i in self.get_children():
		#i.queue_free()

func d():
	for x in cura.size():
		if typeof(prea[x]) != typeof(null):
			var start_point = prea[x]
			var end_point = cura[x]
			var distance = start_point.distance_to(end_point)
			var angle = start_point.angle_to(end_point)
			var texture_size = texture.get_size()
			var texture_scale = Vector2(distance / texture_size.x, 1)
			var texture_rotation = angle + PI / 2
			var texture_spacing = distance / num_textures
			
			var v = end_point.distance_to(start_point)/num_textures
			if v <= 1:
				#print(v,"   here")
				start_point = cura[x]
				draw_set_transformm(start_point,0.0,Vector2(sc,sc))
				del()
				#draw_texture(texture,Vector2(0,0))
			elif v <= 2:
				
				v = 3
				for i in range(v):
						var sp = float(float(i) / (float(v)))
						var ang = end_point.angle_to_point(start_point)
						var texture_position = start_point.linear_interpolate(end_point,sp)
						draw_set_transformm(texture_position, ang, Vector2(sc,sc))
				#del()
			else :
				#print("hello")
				for i in range(v):
					var sp = float(float(i) / (float(v)))
					#var pre = float(float(i-1) / (float(num_textures) - 1.0))
					var ang = end_point.angle_to_point(start_point)
					var texture_position = start_point.linear_interpolate(end_point,sp)
					#print(float(float(i) / (float(num_textures) - 1.0)))
					#print(sp)
					draw_set_transformm(texture_position, ang, Vector2(sc,sc))
					#draw_texture(texture,Vector2(0,0))
				
		else :
			var start_point = cura[x]
			draw_set_transformm(start_point,0.0,Vector2(sc,sc))
			#draw_texture(texture,Vector2(0,0))



func draw_set_transformm(pos,ang,s):
	#print("hello")
	var x = p.instance()
	spawn.add_child(x)
	x.set_owner(spawn)
	x.modulate = current_color
	x.scale = s
	x.global_position = pos
	x.rotate(ang)
	x.texture = texture


func _on_HSlider_value_changed(value):
	sc = value
	#print(value)
