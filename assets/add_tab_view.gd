class_name AddTabView
extends PanelContainer

#signal tab_created(tab: Tab)
signal tab_created
signal tab_discarded

const PERSON_FIELD := preload("res://assets/scenes/person_field.tscn")

@onready var person_field_list := $MarginContainer/VBoxContainer/MarginContainer2/PersonFieldList
@onready var add_person_field_button := $MarginContainer/VBoxContainer/MarginContainer2/PersonFieldList/AddPersonField
@onready var discard_button := $MarginContainer/HBoxContainer/Discard
@onready var submit_button := $MarginContainer/HBoxContainer/Submit


func _ready() -> void:
	add_person_field_button.pressed.connect(_on_add_person_field_button_pressed)
	discard_button.pressed.connect(_on_discard_button_pressed)
	submit_button.pressed.connect(_on_submit_button_pressed)


func _on_add_person_field_button_pressed() -> void:
	var new_field := PERSON_FIELD.instantiate()
	person_field_list.add_child(new_field)
	person_field_list.move_child(add_person_field_button, -1)


func _on_discard_button_pressed() -> void:
	tab_created.emit()


func _on_submit_button_pressed() -> void:
	tab_discarded.emit()


func reset_form() -> void:
	person_field_list.remove_child(add_person_field_button)
	for child in person_field_list.get_children():
		child.queue_free()
	
	person_field_list.add_child(PERSON_FIELD.instantiate())
	person_field_list.add_child(PERSON_FIELD.instantiate())
	person_field_list.add_child(add_person_field_button)
