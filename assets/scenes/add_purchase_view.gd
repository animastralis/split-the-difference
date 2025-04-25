class_name AddPurchaseView
extends PanelContainer

signal purchase_submitted(purchase: Purchase)
signal purchase_canceled

const PURCHASE_FIELDS_LINE := preload("res://assets/scenes/purchase_fields_line.tscn")

var tab: Tab

# BUTTONS #
@onready var autofill_button := $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Autofill
@onready var cancel_button := $MarginContainer/Buttons/Cancel
@onready var submit_button := $MarginContainer/Buttons/Submit

# FORMS #
@onready var input_fields := $MarginContainer/VBoxContainer/MarginContainer2/InputFields


func _ready() -> void:
	cancel_button.pressed.connect(_on_cancel_button_pressed)
	submit_button.pressed.connect(_on_submit_button_pressed)


func init(tab_: Tab) -> void:
	tab = tab_
	reset(tab)


func _on_cancel_button_pressed() -> void:
	purchase_canceled.emit()


func _on_submit_button_pressed() -> void:
	var orders: Dictionary[String, Purchase.Order] = {}
	var total_cost := 0.0
	for line in input_fields.get_children():
		var order: Purchase.Order = line.get_order()
		orders[order.person.name] = order
		total_cost += order.cost
	
	var purchase := Purchase.new()
	purchase.timestamp = Time.get_unix_time_from_system()
	purchase.cost = total_cost
	purchase.orders = orders
	purchase.purchaser = tab.next_purchaser
	
	DataManager.add_purchase_to_tab(tab, purchase)
	purchase_submitted.emit()


func reset(tab_: Tab) -> void:
	if len(input_fields.get_children()) > 0:
		for child in input_fields.get_children():
			child.queue_free()
	
	for person in tab_.members:
		var line: PurchaseFieldsLine = PURCHASE_FIELDS_LINE.instantiate()
		input_fields.add_child(line)
		line.init(person)
