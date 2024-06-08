extends Label

func print_score() -> void:
	self.text = str(PlayerSession.score)
