extends RichTextLabel


# Genera los precios:
func get_prices() -> Dictionary:
	var prices: Dictionary = {"sp": 90,"mp": 130,"bp": 150,
							"ss": 35,"ms": 40,"bs": 50,
							"sodas": 25,"breads": 35}
	if PlayerSession.difficulty == "easy":
		self.text = "[left]
	[center][color=Orange]PIZZAS ENTERAS[/color][/center]\n
	[color=Orange]*[/color] Pizza chica (6 rebanadas): \t\t\t[color=Yellow]$90.00[/color]
	[color=Orange]*[/color] Pizza mediana (8 rebanadas): \t[color=Yellow]$130.00[/color]
	[color=Orange]*[/color] Pizza grande (12 rebanadas): \t[color=Yellow]$150.00[/color]

	[center][color=Lightblue]REBANADAS DE PIZZA[/color][/center]\n
	[color=Lightblue]*[/color] Rebanada chica (1/6 de pizza): \t\t\t[color=Yellow]$35.00[/color]
	[color=Lightblue]*[/color] Rebanada mediana (1/8 de pizza): \t\t[color=Yellow]$40.00[/color]
	[color=Lightblue]*[/color] Rebanada grande (1/12 de pizza): \t\t[color=Yellow]$50.00[/color]

	[center][color=Lightgreen]COMPLEMENTOS[/color][/center]\n
	[color=Lightgreen]*[/color] Refresco: \t\t\t[color=Yellow]$25.00[/color]
	[color=Lightgreen]*[/color] Orden de pan: \t[color=Yellow]$35.00[/color]
	[/left]"
	elif PlayerSession.difficulty == "medium":
		prices = {"sp": randi_range(0,5),"mp": randi_range(0,5),"bp": randi_range(0,5),
				"ss": randi_range(0,5),"ms": randi_range(0,5),"bs": randi_range(0,5),
				"sodas": randi_range(0,5),"breads": randi_range(0,5)}
		self.text = "[left]
	[center][color=Orange]PIZZAS ENTERAS[/color][/center]\n
	[color=Orange]*[/color] Pizza chica (6 rebanadas): \t\t\t[color=Yellow]$89.{sp}0[/color]
	[color=Orange]*[/color] Pizza mediana (8 rebanadas): \t[color=Yellow]$129.{mp}0[/color]
	[color=Orange]*[/color] Pizza grande (12 rebanadas): \t[color=Yellow]$149.{bp}0[/color]

	[center][color=Lightblue]REBANADAS DE PIZZA[/color][/center]\n
	[color=Lightblue]*[/color] Rebanada chica (1/6 de pizza): \t\t\t[color=Yellow]$34.{ss}0[/color]
	[color=Lightblue]*[/color] Rebanada mediana (1/8 de pizza): \t\t[color=Yellow]$39.{ms}0[/color]
	[color=Lightblue]*[/color] Rebanada grande (1/12 de pizza): \t\t[color=Yellow]$49.{bs}0[/color]

	[center][color=Lightgreen]COMPLEMENTOS[/color][/center]\n
	[color=Lightgreen]*[/color] Refresco: \t\t\t[color=Yellow]$24.{sodas}0[/color]
	[color=Lightgreen]*[/color] Orden de pan: \t[color=Yellow]$34.{breads}0[/color]
	[/left]".format(prices)
	elif PlayerSession.difficulty == "hard":
		prices = {"sp": randi_range(0,9),"mp": randi_range(0,9),"bp": randi_range(0,9),
				"ss": randi_range(0,9),"ms": randi_range(0,9),"bs": randi_range(0,9),
				"sodas": randi_range(0,9),"breads": randi_range(0,9)}
		self.text = "[left]
	[center][color=Orange]PIZZAS ENTERAS[/color][/center]\n
	[color=Orange]*[/color] Pizza chica (6 rebanadas): \t\t\t[color=Yellow]$89.{sp}9[/color]
	[color=Orange]*[/color] Pizza mediana (8 rebanadas): \t[color=Yellow]$129.{mp}9[/color]
	[color=Orange]*[/color] Pizza grande (12 rebanadas): \t[color=Yellow]$149.{bp}9[/color]

	[center][color=Lightblue]REBANADAS DE PIZZA[/color][/center]\n
	[color=Lightblue]*[/color] Rebanada chica (1/6 de pizza): \t\t\t[color=Yellow]$34.{ss}9[/color]
	[color=Lightblue]*[/color] Rebanada mediana (1/8 de pizza): \t\t[color=Yellow]$39.{ms}9[/color]
	[color=Lightblue]*[/color] Rebanada grande (1/12 de pizza): \t\t[color=Yellow]$49.{bs}9[/color]

	[center][color=Lightgreen]COMPLEMENTOS[/color][/center]\n
	[color=Lightgreen]*[/color] Refresco: \t\t\t[color=Yellow]$24.{sodas}9[/color]
	[color=Lightgreen]*[/color] Orden de pan: \t[color=Yellow]$34.{breads}9[/color]
	[/left]".format(prices)
	
	return prices
