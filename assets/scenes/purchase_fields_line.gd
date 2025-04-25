class_name PurchaseFieldsLine
extends HBoxContainer

var person: Person

@onready var person_name_label := $PersonName
@onready var price_field := $Price
@onready var order_name_field := $OrderName


func init(person_: Person) -> void:
	person = person_
	person_name_label.text = person.name


func get_order() -> Purchase.Order:
	var order := Purchase.Order.new()
	order.person = person
	order.cost = float(price_field.text)
	order.item = order_name_field.text
	return order
