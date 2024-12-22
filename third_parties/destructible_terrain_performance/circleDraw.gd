extends Sprite2D

var _radius = 50
@onready var world_size = %Sprite2D.get_rect().size

func update(pos: Vector2, radius: float):
	#if world_size == Vector2(0,0):
	world_size = %Sprite2D.get_rect().size
	visible = true
	_radius = radius
	
	print("Explosion Position:", pos)
	print("Explosion Radius:", radius)
	
	# Transform world position to texture coordinates
	global_position = world_to_viewport(pos)
	print("Mapped Global Position to Texture Coordinates:", global_position)
	
	# Scale the sprite according to the radius and texture size
	scale = Vector2.ONE * (radius * 2 / texture.get_width()) * 0.9
	print("Calculated Scale:", scale)

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
