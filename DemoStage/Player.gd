extends Sprite

const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
const MOVE_SPEED = 150.0

var node_BG
var node_FOW
var stage_pos
var stage_size


func _ready():
	node_BG = $"../BG"
	node_FOW = $"../FogOfWar"
	stage_pos = node_BG.position
	stage_size = node_BG.texture.get_size()


func _process(delta):
	var input_dir = Vector2()
	if Input.is_key_pressed(KEY_UP):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN):
		input_dir.y += 1.0
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1.0
	position += (delta * MOVE_SPEED) * input_dir
	
	# Check if we moved past the background, if so just move us back
	position.x = min(max(position.x, stage_pos.x), stage_pos.x + stage_size.x)
	position.y = min(max(position.y, stage_pos.y), stage_pos.y + stage_size.y)
	
	node_FOW.set_clear_position(position)

