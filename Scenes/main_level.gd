extends Node3D

var objects_to_detect
@onready var emitter = get_node("MainPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
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
