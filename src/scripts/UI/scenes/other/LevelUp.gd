extends Popup

onready var level_label: = $LevelFrame/LevelLabel

onready var coins_rewards: = $RewardsContainer/Rewards/CoinsRewards
onready var gems_rewards: = $RewardsContainer/Rewards/GemsRewards

onready var continue_button: = $ContinueButton

func _ready () -> void:
	level_label.text = str (GameData.data.level)
	
	coins_rewards.amount = str (GameData.data.level * 10)
	gems_rewards.amount = str (GameData.data.level * 2)
	
	continue_button.connect ("callback", self, "queue_free")
