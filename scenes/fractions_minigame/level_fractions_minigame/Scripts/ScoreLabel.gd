extends Label


func print_score() -> void:
	self.text = "%08d" % PlayerSession.score
