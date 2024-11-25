extends Sprite2D

var _radius = 50
@onready var world_size = %Sprite2D.get_rect().size

func update(pos: Vector2, radius: float):
	visible = true
	
	global_position = world_to_viewport(pos)
	
	_radius = radius
	scale = Vector2.ONE * (radius * 2 / texture.get_width()) * 0.9

func world_to_viewport(point: Vector2) -> Vector2:
	var dynamic_texture_size = %damageMap.get_size()
	
	# Get sprite's origin/pivot point (in local coordinates)
	var sprite_origin = %Sprite2D.get_rect().position
	
	# Calculate the offset considering the sprite's position and origin
	var world_offset = Vector2(
		%Sprite2D.position.x + sprite_origin.x,
		%Sprite2D.position.y + sprite_origin.y
	)
	
	# Calculate the relative position in world space
	var relative_pos = Vector2(
		(point.x - world_offset.x) / world_size.x,
		(point.y - world_offset.y) / world_size.y
	)
	
	# Convert to viewport coordinates
	return Vector2(
		relative_pos.x * dynamic_texture_size.x,
		relative_pos.y * dynamic_texture_size.y
	)
