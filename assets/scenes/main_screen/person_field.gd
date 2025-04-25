class_name PersonField
extends HBoxContainer

@onready var new_person_field := $NewPerson
@onready var delete_button := $Delete


func _ready() -> void:
	delete_button.pressed.connect(_on_delete_button_pressed)


func _on_delete_button_pressed() -> void:
	queue_free()


func get_person_name() -> String:
	return new_person_field.text
