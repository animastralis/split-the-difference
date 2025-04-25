## Running tally of a group's shared purchases.
##
## Keeps a list of Persons involved, as well as a list of past Purchases.

class_name Tab
extends Resource

## Tab's Name
@export var name: String

## List of Persons on this Tab.
##
## When a new Purchase is added to the tab, members is sorted by Persons'
## balance. The Person who owes the most is placed in front and recorded
## as the next_purchaser. See DataManager for implementation.
@export var members: Array[Person]

## History of Purchases made on this Tab.
@export var purchases: Array[Purchase]

## The person most indebted to others on this Tab.
@export var next_purchaser: Person


func _init() -> void:
	resource_local_to_scene = false
