extends CharacterBody3D

signal radar_used

@export var speed = 0.0
@export var jumpstrnght = 0.0
@export var gravity = 0.0
@export var mouse_sencsitivy = 0.0
@export var ismove = false
@export var isonship = false
@onready var ship = $"../SpaceShip"
@onready var mainscene = $".."
@export var isgravity :bool
@export var isgrv:float
@export var fix_tag = "gaykadefect"
@export var distance = Vector3(0,0,0)

var is_radar = false

var direction
var yaw = 0
var pitch = 0
var _velocity = Vector3.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		yaw = fmod(yaw - event.relative.x * mouse_sencsitivy, 360)
		pitch = max(min(pitch - event.relative.y * mouse_sencsitivy, 70), -70)
#		$Camera.rotation_degrees.y = yaw
		$".".rotation_degrees.y = yaw
		$".".rotation_degrees.x = pitch


func _process(delta):
	if Input.is_action_just_pressed("Radar"):
		is_radar = !is_radar
		
		if is_radar:
			$RadarTimer.start()
		else:
			$RadarTimer.stop()

		$CanvasLayer/Control/TextEdit.visible = !$CanvasLayer/Control/TextEdit.visible


func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right" , "ui_up","ui_down")
	var vert_dir = Input.get_action_strength("Jump") - Input.get_action_strength("Crawl")
	var direction = (transform.basis * Vector3(input_dir.x, vert_dir * int(isgravity), input_dir.y))
	if (Input.is_action_just_pressed("Jump") and !isgravity):
		velocity.y = 5
	
	if direction or vert_dir!=0 :
		velocity.x = lerpf (velocity.x, direction.x * speed, delta)
		velocity.z = lerpf (velocity.z, direction.z * speed,delta)
		if isgravity:
			velocity.y = lerpf(velocity.y, direction.y * speed,delta)
	else:
		velocity.x = lerpf(velocity.x,0,delta*2)
		if isgravity:
			velocity.y = lerpf(velocity.y,0,delta*2)
		velocity.z = lerpf(velocity.z,0,delta*2)
	move_and_slide()



func _on_radar_timer_timeout():
	emit_signal("radar_used")
	print(distance)
	$AudioStreamPlayer3D.play()
	$CanvasLayer/Control/TextEdit.text = str("x:"+str(int(distance.x)) +" y:" + str(int(distance.y)) + " z:" + str(int(distance.z)))
