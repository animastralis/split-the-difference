## An individual Person's purchased item.
##
## A collection of Orders makes up a Purchase.
class_name Order
extends Resource

@export var person: Person
@export var item: String
@export var cost: float

func _init() -> void:
	resource_local_to_scene = false
