class_name PlayerController extends Node2D

# Region: Nodes
@onready var witch: CharacterBody2D = $Witch
@onready var cat: CatController = $Cat
@onready var cat_hurt_box: HurtBox = $Cat/HurtBox
@onready var witch_hurt_box: HurtBox = $Witch/HurtBox
@onready var cat_collision: CollisionShape2D = $Cat/CollisionShape2D
@onready var witch_collision: CollisionShape2D = $Witch/CollisionShape2D
# End Region
# Region: Exports
@export var STAMINA_REGEN_RATE: float = 0.5
@export var STAMINA_MAX: float = 5
@export var MANA_REGEN_RATE: float = 0.5
@export var MANA_MAX: float = 100
@export var HEALTH_MAX: float = 100
# End Region

enum Form {WITCH, CAT}

var stamina: float = 0.0
var mana: float = 0.0
var health: float = HEALTH_MAX
var current_form: Form = Form.CAT

signal health_changed(value: float)
signal mana_changed(value: float)
signal stamina_changed(value: float)

func _ready() -> void:
	cat.visible = false
	switch_form()
	
	cat_hurt_box.got_hit.connect(_on_got_hit)
	witch_hurt_box.got_hit.connect(_on_got_hit)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_form"):
		switch_form()

	handle_stamina_regen(delta)
	handle_mana_regen(delta)


func switch_form() -> void:
	if current_form == Form.CAT:
		cat.visible = false
		cat_collision.disabled = true
		cat_hurt_box.monitorable = false
		witch.visible = true
		witch_collision.disabled = false
		witch_hurt_box.monitorable = true
		current_form = Form.WITCH
	else:
		cat.visible = true
		witch.visible = false
		cat_collision.disabled = false
		cat_hurt_box.monitorable = true
		witch_collision.disabled = true
		witch_hurt_box.monitorable = false
		current_form = Form.CAT

func handle_stamina_regen(delta: float) -> void:
	stamina += STAMINA_REGEN_RATE * delta
	stamina = min(stamina, STAMINA_MAX)
	stamina_changed.emit(stamina)

func handle_mana_regen(delta: float) -> void:
	mana += MANA_REGEN_RATE * delta
	mana = min(mana, MANA_MAX)
	mana_changed.emit(mana)

func _on_got_hit(value: float) -> void:
	health -= value
	health = max(health, 0)
	health_changed.emit(health)

	if health <= 0:
		die()

func die() -> void:
	print("Player died")
