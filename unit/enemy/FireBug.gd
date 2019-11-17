extends "res://unit/Unit.gd"

var is_player_detected : bool = false
var detected_player : Node = null

var is_attacking = false
var is_attacked = false
var attack_duration = 2
var attack_point = 1
var attack_timer = 0

onready var animation_player = $"Scene Root/Armature/AnimationPlayer"
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.get_animation("Walk").loop = true
	animation_player.get_animation("Idle").loop = true
	animation_player.play("Idle")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):	
	if detected_player:
		if animation_player.current_animation == "Idle":
			animation_player.play("Walk")
		var facing = -self.global_transform.basis.z
		var dir = detected_player.global_transform.origin - self.global_transform.origin
#		var a = Vector2(facing.x,facing.z).angle_to(Vector2(dir.x,dir.z))
		var a = Vector2(dir.x,dir.z).angle_to(Vector2(facing.x,facing.z))
#		print(a," / ", b)
		var a_max = deg2rad(360) * delta
		var angle = clamp(a, -a_max, a_max)
		self.rotate_object_local(Vector3(0,1,0), angle)
		var dis = self.global_transform.origin.distance_to(detected_player.global_transform.origin)
		var d = min(dis,1)# * delta
		var m = -self.global_transform.basis.z * d
		m.y = -100
		move_and_slide(m, Vector3(0, 1, 0))
		if is_attacking:
			attack_timer += delta
			if not is_attacked and attack_timer >= attack_point:
				is_attacked = true
				for area in $AttackArea.get_overlapping_areas():
					if area == $DestructibleArea:
						continue
					area.take_damage({"damage":100})
					var particles = preload("res://item/weapon/BulletHitEffect.tscn").instance()
			#		particles.global_translate(body.global_transform.origin)
					particles.set_global_transform(area.global_transform)
					get_tree().current_scene.add_child(particles)
				
			if attack_timer >= attack_duration:
				is_attacking = false				
				animation_player.play("Idle")
		else:
			if dis < 1:
				is_attacking = true
				attack_timer = 0
				is_attacked = false				
				animation_player.play("Attack")
			pass
			
	else:		
		move_and_slide(Vector3(0,-100,0),Vector3(0, 1, 0))
#		var angle = deg2rad(15) * delta
#		self.rotate_object_local(Vector3(0,1,0), angle)

func _on_DestructibleArea_die():
	die()
	pass # Replace with function body.

func _on_VisionSensor_body_detected(body):
	$VisionSensor.monitoring = false
	detected_player = body
	pass # Replace with function body.
