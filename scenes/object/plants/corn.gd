extends Node2D

var corn_harvest_scene = preload("res://scenes/object/plants/corn_harvest.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_pratices: GPUParticles2D = $WateringPratices
@onready var flowering_practices: GPUParticles2D = $FloweringPractices
@onready var growth_cycle_component: GrowthCycleComponent = $GrowthCycleComponent
@onready var hurt_component: HurtComponent = $HurtComponent

var growth_state : DataTypes.GrowthStates = DataTypes.GrowthStates.Seed

func _ready() -> void:
	watering_pratices.emitting = false
	flowering_practices.emitting = false
	
	hurt_component.hurt.connect(on_hurt)
	growth_cycle_component.crop_maturity.connect(on_crop_maturity)
	growth_cycle_component.crop_harvesting.connect(on_crop_harvesting)
	
func _process(delta: float) -> void:
	growth_state = growth_cycle_component.get_current_growth_state()
	sprite_2d.frame = growth_state
	
	if growth_state == DataTypes.GrowthStates.Maturity:
		flowering_practices.emitting = true
	
func on_hurt(hit_damage : int) -> void:
	if !growth_cycle_component.is_watered : 
		watering_pratices.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_pratices.emitting = false
		growth_cycle_component.is_watered = true

func on_crop_maturity() -> void: 
	flowering_practices.emitting = true
	
func on_crop_harvesting() ->void:
	var corn_harvesting_instance = corn_harvest_scene.instantiate() as Node2D
	corn_harvesting_instance.global_position = global_position
	get_parent().add_child(corn_harvesting_instance)
	queue_free()
