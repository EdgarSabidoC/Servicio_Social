extends Label

func print_score() -> void:
	self.text = "%010d" % PlayerSession.score
