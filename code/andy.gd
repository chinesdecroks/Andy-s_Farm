extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED = 80.0
var facing := Vector2.DOWN


func _physics_process(_delta: float) -> void:
	
	var dir := Vector2.ZERO
	var using_tool = Input.is_action_pressed("use_tool")
	
	if not using_tool:
		dir = Input.get_vector("left", "right", "up", "down")
		if dir != Vector2.ZERO:
			if abs(dir.x) > abs(dir.y):
				facing = Vector2(sign(dir.x), 0)
			else:
				facing = Vector2(0, sign(dir.y))
	
	velocity = dir * SPEED
	move_and_slide()
	
	update_animation(dir != Vector2.ZERO, using_tool)
			

func update_animation(is_moving: bool, using_tool: bool) -> void:
	var state := "walk" if is_moving else "idle"
	var direction := get_direction_name()
	if using_tool:
		anim.play("harvest_" + direction)
	else:
		anim.play(state + "_" + direction)
	
func get_direction_name() -> String:
	match facing:
		Vector2.DOWN: return "down"
		Vector2.UP: return "up"
		Vector2.RIGHT: return "right"
		_: return "left"
		
	

	move_and_slide()
