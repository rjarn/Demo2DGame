extends KinematicBody2D


var speed = 200
var velocity = Vector2.ZERO

var currentTime
var currentTimeString
var hungerLevel = 100
var bathroomLevel = 100

var pauseMenuOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(1).set_texture(load(Autoload.faceTexture))
	pass # Replace with function body.

func _physics_process(delta):
	display_time()
	get_input()
	velocity = move_and_slide(velocity)
	
	hungerLevel -= delta
	$Control/hunger.set_text(str("hunger = ", str(int(hungerLevel))))
	if hungerLevel > 66:
		$Control/hungerTexture.set_texture(load("res://assets/uiart/greenbar.png"))
	elif hungerLevel > 33:
		$Control/hungerTexture.set_texture(load("res://assets/uiart/yellowbar.png"))
	elif hungerLevel <= 33:
		$Control/hungerTexture.set_texture(load("res://assets/uiart/redbar.png"))
	
	bathroomLevel -= delta
	$Control/bathroom.set_text(str("bathroom = ", str(int(bathroomLevel))))
	if bathroomLevel > 66:
		$Control/bathroomTexture.set_texture(load("res://assets/uiart/greenbar.png"))
	elif bathroomLevel > 33:
		$Control/bathroomTexture.set_texture(load("res://assets/uiart/yellowbar.png"))
	elif bathroomLevel <= 33:
		$Control/bathroomTexture.set_texture(load("res://assets/uiart/redbar.png"))

func display_time():
	currentTime = OS.get_time()
	
	if currentTime.hour > 12:
		currentTimeString = str(currentTime.hour - 12, ":", currentTime.minute, ":", currentTime.second, " PM")
		$Control/Clock.set_text(currentTimeString)
	else:
		currentTimeString = str(currentTime.hour, ":", currentTime.minute, ":", currentTime.second, " AM")
		$Control/Clock.set_text(currentTimeString)

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed("e"):
		for i in get_slide_count():
			var fuck = get_slide_collision(i)
			if fuck.collider.name == "hemburgr":
				hungerLevel = int(100)
				get_parent().get_child(5).stop()
				get_parent().get_child(5).play()
			elif fuck.collider.name == "shittr":
				bathroomLevel = int(100)
				get_parent().get_child(7).stop()
				get_parent().get_child(7).play()
				if !(get_parent().get_child(6).emitting):
					get_parent().get_child(6).emitting = true
				print("yay")
				
	
	#according to bug report, scroll wheel inputs
	#only work with "is_action_just_released"
	if Input.is_action_just_released("scrollup"):
		$Camera2D.set_zoom(($Camera2D.get_zoom() - Vector2(.1, .1)))
		pass
	if Input.is_action_just_released("scrolldown"):
		$Camera2D.set_zoom(($Camera2D.get_zoom() + Vector2(.1, .1)))
		pass

func doLifeStuff():
	
	pass

func onEscapePress():
	if !pauseMenuOpen:
		pauseMenuOpen = true
		var scene = load("res://scenes/Pause.tscn")
		var instance = scene.instance()
		get_parent().add_child(instance)
	else:
		pauseMenuOpen = false
		print("ho")
		get_parent().get_child(get_child_count() - 1).queue_free()
	pass
