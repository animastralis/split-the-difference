class_name Tab
extends Resource

## Tab's Name
@export var name: String

## List of Persons on this Tab.
@export var members: Array[Person]

## History of Purchases made on this Tab.
@export var purchases: Array[Purchase]

## The person most indebted to others on this Tab.
@export var next_purchaser: Person


func _init() -> void:
	resource_local_to_scene = false
