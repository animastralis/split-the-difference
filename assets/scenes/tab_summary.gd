class_name TabSummary
extends HBoxContainer

@onready var tab_name_button := $TabName
@onready var next_to_pay_label := $NextToPay

var tab: Tab :
	set(val):
		tab = val
		tab_name_button.text = str(tab.name)
		next_to_pay_label.text = tab.members[0].name


func _ready() -> void:
	tab_name_button.pressed.connect(_on_tab_name_button_pressed)


func _on_tab_name_button_pressed() -> void:
	Events.tab_selected.emit(tab)
