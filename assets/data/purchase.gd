## Individual order on a Tab.
class_name Purchase
extends Resource

## Unix integer timestamp
@export var timestamp: float

## Person who paid for the Purchase.
@export var purchaser: Person

## Total cost of Purchase's Orders.
@export var cost: float

## Dictionary of individual Persons' Orders.
@export var orders: Dictionary


func _init() -> void:
	resource_local_to_scene = false
