class_name TabSummary
extends Button

const NORMAL := Color("#343940")
const HOVERED := Color("#577399")
const PRESSED := Color("#495867")

@onready var tab_name_label := $TabSummary/TabName
@onready var next_to_pay_label := $TabSummary/NextToPay

var tab: Tab :
	set(val):
		tab = val
		tab_name_label.text = str(tab.name)
		next_to_pay_label.text = tab.members[0].name + "'s Turn"


func _ready() -> void:
	self.pressed.connect(_on_pressed)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)


func _on_pressed() -> void:
	tab_name_label.add_theme_color_override("font_color", PRESSED)
	next_to_pay_label.add_theme_color_override("font_color", PRESSED)
	Events.tab_selected.emit(tab)


func _on_mouse_entered() -> void:
	tab_name_label.add_theme_color_override("font_color", HOVERED)
	next_to_pay_label.add_theme_color_override("font_color", HOVERED)


func _on_mouse_exited() -> void:
	tab_name_label.add_theme_color_override("font_color", NORMAL)
	next_to_pay_label.add_theme_color_override("font_color", NORMAL)
