extends CharacterBody2D
class_name FighterBase

@export var max_health: int = 100
@export var move_speed: float = 420.0
@export var jump_velocity: float = -950.0
@export var attack_damage: int = 12

var current_health: int = max_health
var is_facing_right: bool = true
var is_attacking: bool = false
var is_blocking: bool = false
var is_hit: bool = false
var super_meter: float = 0.0
var current_state: String = "idle"

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Hitbox if has_node("Hitbox") else null
@onready var hurtbox: Area2D = $Hurtbox if has_node("Hurtbox") else null

signal health_changed(new_health)
signal super_changed(new_meter)
signal died
signal attack_performed(attack_type)

func _ready():
	current_health = max_health
	if hitbox:
		hitbox.monitoring = false
	if hurtbox:
		hurtbox.connect("area_entered", _on_hurtbox_entered)

func _physics_process(delta):
	if is_hit or is_attacking:
		return
	
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	move_and_slide()
	update_animation()

func update_animation():
	if is_hit:
		return
	if not is_on_floor():
		animation_player.play("jump")
	elif velocity.x != 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")

func take_damage(amount: int, knockback: float = 0):
	if is_blocking:
		amount = int(amount * 0.35)
	
	current_health = max(0, current_health - amount)
	emit_signal("health_changed", current_health)
	
	if current_health <= 0:
		die()
	else:
		is_hit = true
		velocity.x = -knockback if is_facing_right else knockback
		animation_player.play("hit")
		await get_tree().create_timer(0.4).timeout
		is_hit = false

func gain_super(amount: float):
	super_meter = min(super_meter + amount, 100.0)
	emit_signal("super_changed", super_meter)

func die():
	emit_signal("died")
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()

func flip_direction():
	is_facing_right = !is_facing_right
	if sprite:
		sprite.flip_h = !sprite.flip_h

func perform_attack(attack_type: String, damage: int, duration: float):
	is_attacking = true
	attack_damage = damage
	emit_signal("attack_performed", attack_type)
	
	if hitbox:
		hitbox.monitoring = true
	
	animation_player.play(attack_type)
	await get_tree().create_timer(duration).timeout
	
	if hitbox:
		hitbox.monitoring = false
	is_attacking = false

func perform_special(special_name: String):
	is_attacking = true
	animation_player.play("special_" + special_name)
	await animation_player.animation_finished
	is_attacking = false

func perform_super():
	if super_meter >= 100:
		super_meter = 0
		emit_signal("super_changed", super_meter)
		is_attacking = true
		animation_player.play("super")
		await animation_player.animation_finished
		is_attacking = false

func _on_hurtbox_entered(area):
	if area.is_in_group("hitbox") and area.get_parent() != self:
		var attacker = area.get_parent()
		take_damage(attacker.attack_damage, 180 if attacker.is_facing_right else -180)