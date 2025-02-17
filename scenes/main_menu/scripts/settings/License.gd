extends TabBar

@onready var scrollbar_textbox = $ScrollbarTextbox
@onready var settings = %Settings
@onready var controls: TabBar = $"../Controls"


func _ready() -> void:
	# Se carga la información desde el archivo:
	var license: String = _load_license()
	if license == "":
		license = "		--------VERSIÓN EN ESPAÑOL--------

	Este juego utiliza el motor de juegos Godot Engine 4.2, disponible bajo el siguiente licenciamiento:
	
	Copyright (c) 2014-presente contribuidores de Godot Engine. Copyright (c) 2007-2014 Juan Linietsky, Ariel Manzur.
	
	Se otorga permiso, de forma gratuita, a cualquier persona que obtenga una copia de este software y los archivos de 
	documentación asociados (el \"Software\"), para tratar con el Software sin restricción, incluyendo sin limitación los 
	derechos de uso, copia, modificación, fusión, publicación, distribuir, sublicenciar y/o vender copias del Software, 
	y permitir que las personas a las que se suministra el Software lo hagan, sujeto a las siguientes condiciones:

	El aviso de copyright anterior y este aviso de permiso se incluirán en todas las copias o partes sustanciales del Software.

	EL SOFTWARE SE PROPORCIONA \"TAL CUAL\", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA, INCLUYENDO PERO NO LIMITADO A LAS
	GARANTÍAS DE COMERCIABILIDAD, IDONEIDAD PARA UN PROPÓSITO PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES O LOS 
	TITULARES DE DERECHOS DE AUTOR SERÁN RESPONSABLES DE CUALQUIER RECLAMACIÓN, DAÑO U OTRA RESPONSABILIDAD, YA SEA EN UNA ACCIÓN 
	DE CONTRATO, AGRAVIO O DE OTRO TIPO, DERIVADA DE, O RELACIONADA CON EL SOFTWARE O EL USO U OTROS TRATOS EN EL SOFTWARE.
	
	-- Godot Engine:
	<[url]https://godotengine.org[/url]>
		-- Licencia de Godot Engine:
	<[url]https://godotengine.org/license/[/url]>
	-- Autores:
	<[url]https://github.com/godotengine/godot/blob/master/AUTHORS.md[/url]>

		--------ENGLISH VERSION--------

	This game uses Godot Engine 4.2, available under the following license:

	Copyright (c) 2014-present Godot Engine contributors. Copyright (c) 2007-2014 Juan Linietsky, Ariel Manzur.

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
	files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy,
	modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
	is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
	IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	
	-- Godot Engine:
	<[url]https://godotengine.org[/url]>
		-- Godot Engine License:
	<[url]https://godotengine.org/license/[/url]>
	-- Authors:
	<[url]https://github.com/godotengine/godot/blob/master/AUTHORS.md[/url]>
	
"
	var text: String =  "[center]%s[/center]" % license
	self.scrollbar_textbox.print_text(text)


# Carga el archivo de licensia de Godot:
func _load_license() -> String:
	var file: FileAccess = FileAccess.open("res://assets/graphical_assets/texts/license/godot_license.txt", FileAccess.READ)
	if not file:
		return ""
	var content: String = file.get_as_text()
	return content

