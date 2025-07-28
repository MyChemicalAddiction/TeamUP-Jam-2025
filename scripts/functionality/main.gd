extends Node2D

"""
The main scene contains all that is currently visible/active in the game. 
This script contains functionality for switching scenes, which the SceneManager
singleton delegates functionality to.

To make the main scene start at a certain level, assign that level's scene to
the default_scene variable (currently set to the Mock Level).
"""

## The animation player that fades & unfades the screen.
@export var anim_player: AnimationPlayer 

## The Node2D that holds the current level (NOT THE LEVEL ITSELF)
@onready var currentLevel := $CurrentLevel 

## The scene that gets loaded by default (use this for debug purposes - drag & drop a level scene from the files)
@export var default_scene: PackedScene 

var currentScene: Node ## The actual current level scene node.

func _ready():
	SceneManager.change_scene.connect(transition_to_scene)
	if default_scene:
		SceneManager.transition_to_scene(default_scene)
	
## For transitioning the player's location to a different scene
func transition_to_scene(new_scene: PackedScene): 
	get_tree().paused = true ## Pauses the game 
	
	default_scene = new_scene ## Sets the scene that the player will go to
	
	anim_player.play("FadeToBlack") ## Makes the screen fade

func reset_scene():
	get_tree().paused = true ## Pauses the game 
	anim_player.play("FadeToBlack") ## Makes the screen fade

func finished_fading():
	get_tree().paused = false ## Unpauses the game
	
	if currentScene:
		currentScene.queue_free() ## Removes the old scene
	
	if default_scene:
		currentScene = default_scene.instantiate()
		currentLevel.add_child(currentScene) ## Adds the new scene
	
	else:
		queue_free()
		SceneManager.quit.emit()
		anim_player.play("FadeToNormal") ## Makes the screen unfade
		return
	
	anim_player.play("FadeToNormal") ## Makes the screen unfade
