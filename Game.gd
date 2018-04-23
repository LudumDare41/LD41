extends Node

# this is a singleton, see below for more informations
# http://docs.godotengine.org/en/3.0/getting_started/step_by_step/singletons_autoload.html

var player
var deathScreenShot
var musicMenu

func _ready():
	musicMenu = AudioStreamPlayer.new()
	musicMenu.stream = load("res://Audio/LD41_Way_Out_Main_scene_-_Track_01_Merlin(1).ogg")
	self.add_child(musicMenu)
	musicMenu.play()
