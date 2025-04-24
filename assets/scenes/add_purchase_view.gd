class_name AddPurchaseView
extends PanelContainer

signal purchase_submitted
signal purchase_canceled

# BUTTONS #
@onready var autofill_button := $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Autofill
@onready var cancel_button := $MarginContainer/Buttons/Cancel
@onready var submit_button := $MarginContainer/Buttons/Submit

# FORMS #
@onready var input_fields := $MarginContainer/VBoxContainer/MarginContainer2/InputFields


func _ready() -> void:
	cancel_button.pressed.connect(_on_cancel_button_pressed)
	submit_button.pressed.connect(_on_submit_button_pressed)


func _on_cancel_button_pressed() -> void:
	purchase_canceled.emit()


func _on_submit_button_pressed() -> void:
	purchase_submitted.emit()
