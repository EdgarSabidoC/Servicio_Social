extends RichTextLabel

@onready var prices: String = "[left]
	[center][color=Orange]PIZZAS ENTERAS[/color][/center]\n
	[color=Orange]*[/color] Pizza chica: \t\t\t[color=Yellow]$90[/color]
	[color=Orange]*[/color] Pizza mediana: \t[color=Yellow]$130[/color]
	[color=Orange]*[/color] Pizza grande: \t\t[color=Yellow]$150[/color]

	[center][color=Lightblue]REBANADAS DE PIZZA[/color][/center]\n
	[color=Lightblue]*[/color] Rebanada chica: \t\t\t[color=Yellow]$35[/color]
	[color=Lightblue]*[/color] Rebanada mediana: \t[color=Yellow]$40[/color]
	[color=Lightblue]*[/color] Rebanada grande: \t\t[color=Yellow]$50[/color]

	[center][color=Lightgreen]COMPLEMENTOS[/color][/center]\n
	[color=Lightgreen]*[/color] Refrescos: \t\t[color=Yellow]$25[/color]
	[color=Lightgreen]*[/color] Orden de pan: \t[color=Yellow]$35[/color]
[/left]"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = prices


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
