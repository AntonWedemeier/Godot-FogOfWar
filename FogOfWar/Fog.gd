extends Sprite

# with conversion to Godot version 3.1 use static typing

var clear_image_texture_path
var clear_image_texture_scale = Vector2(1.0, 1.0)
var fog_color = Color(0.2, 0.2, 0.2, 0.9)
var clear_texture = preload("res://FogOfWar/FogGradient.png")   # channel red becames alpha

var fog_tex_size = Vector2(1, 1)
var node_VP
var node_FogTexture
var image
var image_texture
var clear_position
var clear_position_old
var clear_position_shader
var clear_size
var clear_size_shader
var first = true


func _ready():
	node_FogTexture = $"../../FogTexture"
	level_start(fog_tex_size, Vector2(1.0, 1.0)) # just to have a start
	pass


func set_clear_texture_path(clear_image_path, clear_image_scale):
	clear_image_texture_path = clear_image_path
	clear_image_texture_scale = clear_image_scale


func set_fog_color(color):
	fog_color = color


func level_start(fog_texture_size, fog_texture_scale):
	if clear_image_texture_path != null:
		clear_texture = load(clear_image_texture_path)
	
	fog_tex_size = fog_texture_size
	
	node_VP = get_parent()
	node_VP.size = fog_tex_size
	node_VP.transparent_bg = true
	node_VP.set_vflip(true)
	
	self.position = Vector2(0.0, 0.0)
	self.centered = false
	
	node_FogTexture = $"../../FogTexture"
	node_FogTexture.position = Vector2(0.0, 0.0)
	node_FogTexture.centered = self.centered
	node_FogTexture.flip_v = false
	
	image = Image.new()
	image.create(fog_tex_size.x, fog_tex_size.y, false, Image.FORMAT_RGBA8)
	image.fill(fog_color)
	image_texture = ImageTexture.new()
	image_texture.create(fog_tex_size.x, fog_tex_size.y, Image.FORMAT_RGBA8, 0)
	image_texture.set_data(image)
	set_texture(image_texture)
	
	clear_size = clear_texture.get_size()
	clear_size *= clear_image_texture_scale
	clear_size *=  fog_texture_scale
	clear_size_shader = clear_size / fog_tex_size
	clear_position = Vector2(-clear_size.x * 0.5, -clear_size.y * 0.5)
	clear_position_old = null
	first = true


func set_clear_position(clear_position_new):
	clear_position = clear_position_new


# warning-ignore:unused_argument
func _process(delta):
	set_shader_uniform()


func set_shader_uniform():
	if clear_position == clear_position_old : return
	clear_position_old = clear_position
	if !first:
		image_texture.set_data(get_parent().get_texture().get_data())
	first = false
	
	clear_position_shader = clear_position
	# position is center sprite; must be top-left
	clear_position_shader.x -= clear_size.x * 0.5
	clear_position_shader.y -= clear_size.y * 0.5
	# to texture coordinates
	clear_position_shader -= self.position # fog_texture_position
	# to shader values in range [0.0, 1.0)
	clear_position_shader = clear_position_shader / fog_tex_size
	self.material.set_shader_param("last_texture", image_texture)
	self.material.set_shader_param("clear_texture", clear_texture)
	self.material.set_shader_param("clear_position", clear_position_shader)
	self.material.set_shader_param("clear_size", clear_size_shader)

