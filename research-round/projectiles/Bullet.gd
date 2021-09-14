extends Spatial
#samir

var timer = 0 

export var bullet_speed = 0
export var bullet_damage = 0.5

const Kill_Time = 10

func _ready():
	$AnimationPlayer.play("grow")
	get_tree().call_group("Enemy", "unmoveable")

func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * bullet_speed * delta)
	
	timer += delta
	
	if timer > Kill_Time:
		queue_free()


func _on_Area_body_entered(body):
	if body is KinematicBody:
		if body.is_in_group("Player"):
			get_tree().call_group("Player","minus_health", bullet_damage)
			queue_free()
			get_tree().call_group("Enemy", "moveable")
#			print("die")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "grow":
		bullet_speed = 10
		bullet_damage = 1
		get_tree().call_group("Enemy", "moveable")
