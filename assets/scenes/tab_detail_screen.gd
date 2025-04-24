extends Control

signal return_home_pressed

@onready var add_purchase_button := $TabDetailView/AddPurchase
@onready var add_purchase_view: AddPurchaseView = $AddPurchaseView
@onready var anim := $AnimationPlayer


func _ready() -> void:
	add_purchase_button.pressed.connect(_on_add_purchase_button_pressed)
	add_purchase_view.purchase_canceled.connect(_on_purchase_view_purchase_canceled)
	add_purchase_view.purchase_submitted.connect(_on_purchase_view_purchase_submitted)


func _on_add_purchase_button_pressed() -> void:
	anim.play("show_add_purchase_view")


func _on_purchase_view_purchase_canceled() -> void:
	anim.play("hide_add_purchase_view")


func _on_purchase_view_purchase_submitted() -> void:
	anim.play("hide_add_purchase_view")
