extends AnimatedSprite2D

var growth_interval = 1200  # Growth time per stage
var current_stage = 0  # Tracks the current growth stage

func _ready():
	animation = "pumpkin_growth"  # Use the "growth" animation we set up
	frame = current_stage  # Start with the first frame
	$Timer.start(growth_interval)  # Start the timer

func _on_Timer_timeout():
	# Advance to the next frame in the growth sequence
	if current_stage < sprite_frames.get_frame_count("growth") - 1:
		current_stage += 1
		frame = current_stage  # Update frame
	else:
		$Timer.stop()  # Stop the timer when fully grown

func harvest():
	if current_stage == sprite_frames.get_frame_count("growth") - 1:
		# Add to inventory or similar action
		queue_free()  # Remove crop after harvesting
		
var crop_scene = preload("res://Nojo Life/Scenes/crop.tscn")

func plant_crop(position):
	var crop = crop_scene.instance()
	crop.position = position
	add_child(crop)
