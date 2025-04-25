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
	autofill_button.pressed.connect(_on_autofill_button_pressed)


func init(tab_: Tab) -> void:
	tab = tab_
	for person in tab.members:
		var line := PURCHASE_FIELDS_LINE.instantiate()
		input_fields.add_child(line)
		line.init(person)
	reset(tab)


func _on_cancel_button_pressed() -> void:
	purchase_canceled.emit()


func _on_submit_button_pressed() -> void:
	var orders: Dictionary[String, Order] = {}
	var total_cost := 0.0
	for line in input_fields.get_children():
		var order: Order = line.get_order()
		orders[order.person.name] = order
		total_cost += order.cost
	
	var purchase := Purchase.new()
	purchase.timestamp = Time.get_unix_time_from_system()
	purchase.cost = total_cost
	purchase.orders = orders
	purchase.purchaser = tab.next_purchaser
	
	DataManager.add_purchase_to_tab(tab, purchase)
	purchase_submitted.emit()


func _on_autofill_button_pressed() -> void:
	# This shouldn't be possible but just in case
	if len(tab.purchases) == 0:
		return
	
	var prev_purchase := tab.purchases[-1]
	for line in input_fields.get_children():
		var prev_order: Order = prev_purchase.orders[line.person.name]
		line.autofill(prev_order)


func reset(tab_: Tab) -> void:
	tab = tab_
	for line in input_fields.get_children():
		line.clear()
	
	# Disable autofill button if there are no purchases to autofill from.
	autofill_button.disabled = len(tab.purchases) == 0
