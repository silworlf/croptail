extends Panel

@onready var animated_sprited_2d: AnimatedSprite2D = $Emote/AnimatedSprite2D
@onready var emote_idle_timer: Timer = $EmoteIdleTimer

var idle_emotes : Array = ["emote_1_idle","emote_2_smile","emote_3_ear_wave","emote_4_blink","emote_5_ilove_kiss","emote_6_say_love","emote_7_hug","emote_8_happy","emote_9_cool","emote_10_angry","emote_11_sleep","emote_12_excited"]

func _ready() -> void:
	animated_sprited_2d.play("emote_1_idle")
	
	InventoryManagement.inventory_changed.connect(on_inventory_changed)
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals)

func play_emote(animation: String) -> void :
	animated_sprited_2d.play(animation)


func _on_emote_idle_timer_timeout() -> void:
	var index = randi_range(0,11)
	var emote = idle_emotes[index]
	
	animated_sprited_2d.play(emote)
	
func on_inventory_changed() -> void:
	animated_sprited_2d.play("emote_7_hug")

func on_feed_the_animals() -> void:
	animated_sprited_2d.play("emote_6_say_love")
