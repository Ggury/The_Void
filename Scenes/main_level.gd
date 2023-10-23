extends Node3D

var objects_to_detect
@onready var emitter = get_node("MainPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	emitter.radar_used.connect(send_coords)
	objects_to_detect = get_tree().get_nodes_in_group("radardetect")
	
func send_coords():
	objects_to_detect = get_tree().get_nodes_in_group("radardetect")
	if not objects_to_detect:
		print("Nothin else")
	if objects_to_detect:
		var distance = emitter.position.distance_to(objects_to_detect[0].position)
		var nearobjpos = objects_to_detect[0].position
		for object in objects_to_detect:
			if emitter.position.distance_to(object.position) <distance:
				distance = emitter.position.distance_to(object.position)
				nearobjpos = object.position
		emitter.distance = emitter.position - nearobjpos
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_scene_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "MainPlayer":
		get_tree().change_scene_to_file("res://Scenes/End_Screen.tscn")
