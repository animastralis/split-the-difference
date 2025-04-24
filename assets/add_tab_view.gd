class_name AddTabView
extends PanelContainer

signal tab_submitted
signal tab_discarded

const PERSON_FIELD := preload("res://assets/scenes/person_field.tscn")

@onready var tab_name_field := $MarginContainer/VBoxContainer/MarginContainer/TabName
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
	tab_discarded.emit()


func _on_submit_button_pressed() -> void:
	var tab_name: String = tab_name_field.text
	var member_names: Array[String] = []
	
	for child in person_field_list.get_children():
		# Ignore nodes that aren't a "field" (aka add_person_field button)
		if child.is_in_group("fields"):
			var person_field := child as PersonField
			member_names.append(person_field.get_person_name())
	
	DataManager.add_tab(tab_name, member_names)
	tab_submitted.emit()


func reset_form() -> void:
	tab_name_field.text = ""
	person_field_list.remove_child(add_person_field_button)
	for child in person_field_list.get_children():
		child.queue_free()
	
	person_field_list.add_child(PERSON_FIELD.instantiate())
	person_field_list.add_child(PERSON_FIELD.instantiate())
	person_field_list.add_child(add_person_field_button)
