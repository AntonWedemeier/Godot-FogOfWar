extends Node2D

# with conversion to Godot version 3.1 use static typing

var node_VPFog
var fog_tex_upperleft = Vector2(0.0, 0.0)
var fog_tex_scale = Vector2(1.0, 1.0)


func _ready():
	node_VPFog = $ViewportFog/Fog
	pass


# Gives the path of the image for dissolving the fog.
# The image can have areas in which alpha is < 0.99). These areas are ignored by the shader.
# The (inverse of the) red channel inside the image determines the minimal alpha of the fog. 
# For instance a black area dissolves the fog completely; a white area dosnot change the alpha of the fog texture.
# The size of the image is multiplied by the scale parameter.
# This call only gets its effect on the next call from 'level_start' 
# If this method is not called the preload texture mentioned inside the the script "Fog.gd" is used.
func set_clear_texture_path(clear_image_path, clear_image_scale):
	node_VPFog.set_clear_texture_path(clear_image_path, clear_image_scale)


# Gives the fog_color.
# This call only gets its effect on the next call from 'level_start' 
# If this method is not called the value of the viriable 'fog_color' inside the the script "Fog.gd" is used.
func set_fog_color(fog_color):
	node_VPFog.set_fog_color(fog_color)


# Start making a (new) rectangular fog texture filled with the fog color.
# The fog gets a size given with the parameter 'fog_size'.
# The fog is placed inside the 2D world at the coordinates given with parameter 'fog_upperleft'.
# The 'fog_texture_scale' defines the used fog texture according to: texture-size = fog_size * fog_texture_scale.
# The scale is expected to be <= 1.0. A smaller value gives a a coarser result.
func level_start(fog_size, fog_upperleft, fog_texture_scale):
	fog_tex_upperleft = fog_upperleft
	fog_tex_scale = fog_texture_scale
	
	self.position = fog_tex_upperleft
	self.scale = Vector2(1.0 / fog_tex_scale.x, 1.0 / fog_tex_scale.y)
	node_VPFog.level_start(fog_size * fog_texture_scale, fog_tex_scale)


# Gives the location (inside the 2D world) where the fog is dissolved.
func set_clear_position(clear_position_new):
	node_VPFog.set_clear_position((clear_position_new - fog_tex_upperleft) * fog_tex_scale)

