extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var characterArt = $HBoxContainer/backgroundArt/characterArt

var facePathsArray = ["res://assets/characterart/blface.png",
"res://assets/characterart/grface.png",
"res://assets/characterart/reface.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_buttonFinish_pressed():
	get_tree().change_scene("res://scenes/World.tscn")
	pass # Replace with function body.


func _on_buttonMainMenu_pressed():
	get_tree().change_scene("res://scenes/Home.tscn")
	pass # Replace with function body.

func _on_OptionButtonColor_item_selected(index):
	
	# Save selected face texture to be accessible from future scenes
	Autoload.faceTexture = facePathsArray[index]
	
	# Change texture of face to selected texture
	characterArt.set_texture(load(facePathsArray[index]))
	pass # Replace with function body.
