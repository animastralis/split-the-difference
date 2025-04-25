class_name PurchaseFieldsLine
extends HBoxContainer

var person: Person

@onready var person_name_label := $PersonName
@onready var price_field := $Price
@onready var order_name_field := $OrderName


func init(person_: Person) -> void:
	person = person_
	person_name_label.text = person.name


func clear() -> void:
	price_field.text = ""
	order_name_field.text = ""


func autofill(order: Order) -> void:
	price_field.text = str(order.cost)
	order_name_field.text = order.item


func get_order() -> Order:
	var order := Order.new()
	order.person = person
	order.cost = float(price_field.text)
	order.item = order_name_field.text
	return order
