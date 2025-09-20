extends Node

func play_sound(stream: AudioStream):
	var fx_player = get_children().pick_random()
	fx_player.stream = stream
	fx_player.play()
	return fx_player
