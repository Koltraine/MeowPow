extends CanvasLayer

@onready var health_bar: ColorRect = %Health
@onready var mana_bar: ColorRect = %Mana
@onready var stamina_bar: ColorRect = %Stamina

# @export var player: PlayerController
@export var bar_sizes: float = 100

var health_max: float
var mana_max: float
var stamina_max: float

func _ready() -> void:
	# player.health_changed.connect(_on_health_changed)
	# player.mana_changed.connect(_on_mana_changed)
	# player.stamina_changed.connect(_on_stamina_changed)

	health_max = 100
	mana_max = 100
	# stamina_max = player.STAMINA_MAX

func _on_health_changed(value: float) -> void:
	health_bar.custom_minimum_size.x = value / health_max * bar_sizes

func _on_mana_changed(value: float) -> void:
	mana_bar.custom_minimum_size.x = value / mana_max * bar_sizes

func _on_stamina_changed(value: float) -> void:
	stamina_bar.custom_minimum_size.x = value / stamina_max * bar_sizes
