extends RichTextLabel

@export var prices: String = "[left]
	[center][color=Orange]PIZZAS ENTERAS[/color][/center]\n
	[color=Orange]*[/color] Pizza chica (6 rebanadas): \t\t\t[color=Yellow]$90[/color]
	[color=Orange]*[/color] Pizza mediana (8 rebanadas): \t[color=Yellow]$130[/color]
	[color=Orange]*[/color] Pizza grande (12 rebanadas): \t[color=Yellow]$150[/color]

	[center][color=Lightblue]REBANADAS DE PIZZA[/color][/center]\n
	[color=Lightblue]*[/color] Rebanada chica (1/6 de pizza): \t\t\t[color=Yellow]$35[/color]
	[color=Lightblue]*[/color] Rebanada mediana (1/8 de pizza): \t\t[color=Yellow]$40[/color]
	[color=Lightblue]*[/color] Rebanada grande (1/12 de pizza): \t\t[color=Yellow]$50[/color]

	[center][color=Lightgreen]COMPLEMENTOS[/color][/center]\n
	[color=Lightgreen]*[/color] Refresco: \t\t\t[color=Yellow]$25[/color]
	[color=Lightgreen]*[/color] Orden de pan: \t[color=Yellow]$35[/color]
[/left]"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = prices
