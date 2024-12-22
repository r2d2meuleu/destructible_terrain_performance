class_name MaskViewport extends SubViewport

@onready var sprite:Sprite2D = %Sprite2D 

# Called when the node enters the scene tree for the first time.
func _ready():
	set_size(sprite.get_rect().size)
	print (sprite.get_rect().size)
	#set_global_canvas_transform(Transform2D(0, sprite.global_position/2))

func setup(sprite2d):
	sprite = sprite2d
	set_size(sprite.get_rect().size)
	print (sprite.get_rect().size)
	print (self.name)
	print (sprite.material.get_shader_parameter("destruction_mask"))
	sprite.material.set_shader_parameter("destruction_mask", self.get_texture())
	print (sprite.material.get_shader_parameter("destruction_mask"))
