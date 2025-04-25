class_name TabSummary
extends HBoxContainer

const HOVERED := Color("#577399")
const NOT_HOVERED := Color("#343940")

@onready var tab_name_button := $TabName
@onready var next_to_pay_label := $NextToPay

var tab: Tab :
	set(val):
		tab = val
		tab_name_button.text = str(tab.name)
		next_to_pay_label.text = tab.members[0].name + "'s Turn"


func _ready() -> void:
	tab_name_button.pressed.connect(_on_tab_name_button_pressed)
	tab_name_button.mouse_entered.connect(_on_tab_name_button_mouse_entered)
	tab_name_button.mouse_exited.connect(_on_tab_name_button_mouse_exited)


func _on_tab_name_button_pressed() -> void:
	Events.tab_selected.emit(tab)


func _on_tab_name_button_mouse_entered() -> void:
	next_to_pay_label.add_theme_color_override("font_color", HOVERED)


func _on_tab_name_button_mouse_exited() -> void:
	next_to_pay_label.add_theme_color_override("font_color", NOT_HOVERED)
