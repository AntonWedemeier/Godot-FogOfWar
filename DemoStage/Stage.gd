extends Node2D

var node_BG
var node_FOW


func _ready():
	node_BG = $"BG"
	node_FOW = $"FogOfWar"
	
	node_FOW.set_fog_color(Color(0.2, 0.2, 0.2, 1.0))
#	node_FOW.set_clear_texture_path("res://FogOfWar/CirkelGradient.png", Vector2(0.75, 0.75))
	node_FOW.level_start(node_BG.texture.get_size(), node_BG.position, Vector2(1.0, 1.0))
	pass
