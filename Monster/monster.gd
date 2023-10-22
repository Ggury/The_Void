extends CharacterBody3D

signal ate_player

@export var min_speed = 10
@export var max_speed = 18
@export var min_radar_uses = 5
@export var max_radar_uses = 10

var radar_used
var is_agressive = false


func _ready():
	var player_position = get_player_position()
	look_at_player(player_position)
	
	radar_used = randi_range(min_radar_uses, max_radar_uses)
	
	
func _process(delta):
	var player_position = get_player_position()
	if radar_used <= 0 and not is_agressive:
		look_at_player(player_position)
		
		radar_used = randi_range(min_radar_uses, max_radar_uses)
	
	if is_agressive:
		look_at(player_position, Vector3.UP)
		
		velocity = Vector3.FORWARD * max_speed
		velocity = velocity.rotated(Vector3.UP, rotation.y)
		velocity = velocity.rotated(Vector3.RIGHT, rotation.x)
		velocity = velocity.rotated(Vector3.FORWARD, rotation.z)


func _physics_process(_delta):
	move_and_slide()


func get_player_position():
	return get_parent().get_node("MainPlayer").position


func look_at_player(player_position):
	look_at(player_position, Vector3.UP)
	rotate_object_local(Vector3.UP, randf_range(-PI / 6, PI / 6))

	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	velocity = velocity.rotated(Vector3.RIGHT, rotation.x)
	velocity = velocity.rotated(Vector3.FORWARD, rotation.z)


func _on_main_player_radar_used():
	radar_used -= 1


func _on_near_player_area_body_exited(body):
	if body.name == "MainPlayer":
		look_at_player(body.position)


func _on_vision_timer_timeout():
	var overlaps = $AreaOfSight.get_overlapping_bodies()

	for overlap in overlaps:
		if overlap.name != "MainPlayer":
			continue
			
		var player_position = overlap.position
		$VisionRayCast.look_at(player_position, Vector3.UP)
		
		if $VisionRayCast.is_colliding():
			var collider = $VisionRayCast.get_collider()
			if collider.name == "MainPlayer":
				is_agressive = true


func _on_mouth_area_body_entered(body):
	if body.name == "MainPlayer" and is_agressive:
		print("Game over")
		ate_player.emit()
