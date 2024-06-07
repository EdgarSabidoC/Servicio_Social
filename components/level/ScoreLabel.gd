extends Label

func print_score() -> void:
	self.text = "%07d" % PlayerSession.score
