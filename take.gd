extends Node2D

var colors = {}
var img = Image.new()
var w = 512
var begin = false
var m = 1
var iterat = 0
var rating_ended = false



func _physics_process(delta):
	m += 1
	if begin == true and iterat == 0:
		iter(512*512)
		iterat = 1
	if begin == true and iterat == -1 :
		collect()
		iterat = 0
		begin = false
	
	
	
	if Input.is_action_just_pressed("ui_left"):
		print(colors.keys().size()-1)


func collect():
	var color_rate = colors.size()
	var color_dinsity = 0
	var threshhold = 1000
	var value = colors.values()
	for i in value.size():
		if value[i] > threshhold:
			color_dinsity += 1
	color_rate = clamp(color_rate,0,4)
	if color_rate < 3:
		print("try adding more color")
	color_dinsity = clamp(color_dinsity,0,4)
	var x = colors.hash()
	randomize()
	seed(x)
	var paint_rate = rand_range(0.0,1.0)
	paint_rate
	color_rate += 1
	var sum = color_rate + paint_rate + color_dinsity
	if sum < 4.0:
		sum = 4.0 + paint_rate
	$score.text = str(sum)
	return sum
	

func get_image():
	var viewport_texture = $ViewportContainer/Viewport.get_texture()
	var image = viewport_texture.get_data()
	image.convert(Image.FORMAT_RGBA8)
	image.flip_y()
	var e = ImageTexture.new()
	e.create_from_image(image)
	return image



func rate():
	colors = {}
	img = get_image()
	iterat = 0
	begin = true

func iter(n):
	var num = 0
	var b = 0
	for i in n:
		b += 1
		if b >= 1000:
			b = 0
			yield(get_tree().create_timer(0.02), "timeout")
		var c = i
		if c > w*w:
			iterat += num - 1
			return
		num += 1
		var x = c % w
		var y = c / w
		img.lock()
		var color = img.get_pixel(x,y)
		color.a = 1.0
		if colors.has(color) :
			colors[color] += 1
		else :
			colors[color] = 0
		img.unlock()
		
		
	rating_ended = false
	iterat = -1
	


func _on_Button_rate_pressed():
	if rating_ended == false:
		rating_ended = true
		rate()
