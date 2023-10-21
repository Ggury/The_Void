extends CharacterBody3D

@export var min_speed = 10
@export var max_speed = 18
@export var min_radar_uses = 5
@export var max_radar_uses = 10

var radar_uses
var is_agressive = false


func _ready():
	var player_position = get_player_position()
	look_at_player(player_position)
	
	radar_uses = randi_range(min_radar_uses, max_radar_uses)
	
	
func _process(delta):
	if radar_uses <= 0:
		var player_position = get_player_position()
		look_at_player(player_position)
		
		radar_uses = randi_range(min_radar_uses, max_radar_uses)


func _physics_process(_delta):
	move_and_slide()


func get_player_position():
	return get_parent().get_node("MainPlayer").position


func look_at_player(player_position):
	look_at_from_position(position, player_position, Vector3.UP)
	rotate_object_local(Vector3.UP, randf_range(-PI / 6, PI / 6))

	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	velocity = velocity.rotated(Vector3.RIGHT, rotation.x)
	velocity = velocity.rotated(Vector3.FORWARD, rotation.z)


func _on_main_player_radar_used():
	radar_uses -= 1


func _on_near_player_area_body_exited(body):
	print(body.name)
	if body.name == "MainPlayer":
		look_at_player(body.position)
