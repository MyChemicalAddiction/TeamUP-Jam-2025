extends Control

"""
The Cutscene Player is what the CutscenePlayer singleton delegates cutscene 
playing functionality to.
"""

## Maps cutscenes to whether they've been played already or not. The indexes in 
## the dictionary show what order they should be played in. Keys that aren't 
## paths represent a number of levels on which a cutscene needn't be played.
@onready var cutscenes : Dictionary[String, bool] = {
	"fs": false,
	"dh": false,
	"res://scenes/cutscenes/cutscene_1.tscn": false,
	"fn": false,
	"nh": false,
	"res://scenes/cutscenes/cutscene_2.tscn": false,
	"kr": false,
	"se": false,
	"res://scenes/cutscenes/cutscene_3.tscn": false,
}

@export var intro_cutscene_path : String
@export var anim_player : AnimationPlayer ## used for fading the screen

signal finished_intro_cutscene
signal fading_in
signal fading_out

signal on_enabled
signal on_disabled

func _ready():
	update()
	SaveLoad.loaded.connect(update) ## Updates which cutscnees have alraedy been played only on load
	CutscenePlayer.cutscene_player = self
	process_mode = Node.PROCESS_MODE_ALWAYS

## Updates which cutscenes have already beenn played
func update():
	var level_completed_data = SaveLoad.get_data("level_completed_data")
	
	for i in range(len(cutscenes.keys())):
		cutscenes[cutscenes.keys()[i]] = false
	
	for i in range(clamp(len(level_completed_data), 0, len(cutscenes.keys()))):
		cutscenes[cutscenes.keys()[i]] = true

## Instantiates a cutscene scene, awaits its finish signal then fades screen to black & at end of fade
func play_cutscene():

	var index = len(SaveLoad.get_data("level_completed_data")) - 1

	if !cutscenes[cutscenes.keys()[index]]:
		if len(cutscenes.keys()[index]) > 2: ## Only instantiates a cutscene if the key at the index is longer than 2 characters (if not - means there is no cutscene after that amount of levels completed)
			visible = true
			anim_player.play("fade_to_black")
			
			get_tree().paused = true
			
			await anim_player.animation_finished

			var new_cutscene = load(cutscenes.keys()[index]).instantiate()
			cutscenes[cutscenes.keys()[index]] = true
			
			add_child(new_cutscene)
			move_child(new_cutscene, 0)
			
			anim_player.play("fade_to_clear")
			
			fading_in.emit()
			on_enabled.emit()
			
			await new_cutscene.finished
			
			anim_player.play("fade_to_black")
			
			fading_out.emit()
			on_disabled.emit()
			
			await anim_player.animation_finished
			
			CutscenePlayer.finished.emit()
			new_cutscene.queue_free()
			
			anim_player.play("fade_to_clear")
			await anim_player.animation_finished
			
			visible = false
			
		else:
			CutscenePlayer.finished.emit()
			cutscenes[cutscenes.keys()[index]] = true
	else:
		CutscenePlayer.finished.emit()

func play_intro_cutscene():
	visible = true
	anim_player.play("fade_to_black")
	
	get_tree().paused = true
			
	get_tree().get_first_node_in_group("main_theme").disable()
	
	await anim_player.animation_finished
	
	var new_cutscene = load(intro_cutscene_path).instantiate()
	
	add_child(new_cutscene)
	move_child(new_cutscene, 0)
	
	anim_player.play("fade_to_clear")
	
	fading_in.emit()
	on_enabled.emit()
	
	await new_cutscene.finished
	
	anim_player.play("fade_to_black")
	
	fading_out.emit()
	on_disabled.emit()
	
	await anim_player.animation_finished

	new_cutscene.queue_free()
	
	finished_intro_cutscene.emit()
	
	anim_player.play("fade_to_clear")
	
	
	await anim_player.animation_finished
	
	visible = false
	
	SaveLoad.change_data("played_intro_cutscene", true)
