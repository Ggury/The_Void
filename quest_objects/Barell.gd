extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "MainPlayer":
		body.barell_counter +=1
		body.checkpoint = $".".global_position
		$".".queue_free()
		
