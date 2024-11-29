extends Node2D

# Place this in a script controlling the parent node or a test script
func _ready():
	var debug_mask = Sprite2D.new()
	debug_mask.texture = $Sprite2D.material.get_shader_parameter("destruction_mask")
	debug_mask.scale = $Sprite2D.scale  # Match scaling
	debug_mask.position = $Sprite2D.position  # Match position
	debug_mask.centered = $Sprite2D.centered  # Match position
	debug_mask.modulate = Color(1, 1, 1, 0.5)  # Semi-transparent overlay
	add_child(debug_mask)
