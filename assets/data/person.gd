## A member of a Tab
##
## Used in Tabs to track money owed from a tab's Purchases.
## NOTE: Persons do not persist between tabs. Each Tab's
## Persons are unique, even if those Persons are included
## in other Tabs.
class_name Person
extends Resource

## Person's name
@export var name: String

## The amount of money a Person owes or is owed on the Tab.
## Positive -- is owed money
## Negative -- owes money
@export var balance: float


func _init() -> void:
	resource_local_to_scene = false
