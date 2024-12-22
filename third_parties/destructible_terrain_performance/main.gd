extends Node2D
@export var min_movement_update: int = 5
@export var circle_radius: float = 40


var old_mouse_pos: Vector2 = Vector2()
var mouse_pos: Vector2 = Vector2()

@onready var carving_area:= get_node("map/carvingArea")
@onready var quadrantsManager:QuadrantManager = get_node("map/quadrantsManager")
@onready var sprite = get_node("map/Sprite2D")
@onready var map = get_node("map")
var Quadrant = preload("res://third_parties/destructible_terrain_performance/quadrant.tscn")

func _ready():
	var path = "res://testScene.png"
	var texture = await load_image_async(path)
	if texture:
		sprite.texture = texture
		#_make_mouse_circle()
		print (sprite.name)
		quadrantsManager.sprite = sprite
		quadrantsManager.carving_area = carving_area
		quadrantsManager.position = sprite.position
		var damageMap:MaskViewport = get_node("map/Sprite2D/damageMap")
		damageMap.setup(sprite)
		map.setup()

		quadrantsManager.build_grid_from_image()

func load_image_async(path: String) -> ImageTexture:
	if not FileAccess.file_exists(path):
		push_error("The file does not exist.")
	var image = Image.new()
	var texture = ImageTexture.new()
	var error = image.load(path)
	if error != OK:
		print("Failed to load image: ", path)
		return null
	texture.set_image(image)
	return texture

func load_image_to_sprite(path: String) -> void:
	print (path)
	if FileAccess.file_exists(path):
		print ("TRUE")
	else:
		print ('FALSE')
	var _image:Image = Image.new()
	var _itex:ImageTexture = ImageTexture.new()
	if _image.load(path) == OK:
		var texture = load(path)
		print("Image loaded successfully")
		sprite.texture = texture
		#_itex = ImageTexture.create_from_image(_image)
		#if _itex:
			## var sprite:Sprite2D = get_node("map/Sprite2D")
			#sprite.texture = _itex
			#print (sprite.texture.get_image().get_size())
			#sprite.position = map.position


# func _ready():
# 	_make_mouse_circle()
# 	print (sprite.name)
# 	quadrantsManager.sprite = sprite
# 	quadrantsManager.carving_area = carving_area
# 	quadrantsManager.position = sprite.position
# 	quadrantsManager.build_grid_from_image()


#
#func _process(_delta):
	#pass
	#if Input.is_action_pressed("click_left"):
		#if old_mouse_pos.distance_to(mouse_pos) > min_movement_update:
			#quadrantsManager.carve(carving_area)
			#old_mouse_pos = mouse_pos
			#%circleDraw.update(carving_area.global_position, 50)
#

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = get_global_mouse_position()
		carving_area.position = mouse_pos
		queue_redraw()


func _make_mouse_circle():
	var nb_points = 15
	var pol = []
	for i in range(nb_points):
		var angle = lerp(-PI, PI, float(i)/nb_points)
		pol.push_back(mouse_pos + Vector2(cos(angle), sin(angle)) * circle_radius)
	carving_area.update_polygon(pol)
