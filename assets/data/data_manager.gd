## A Singleton that holds Tab data.
##
## Saves, loads, and provides the data for other nodes to reference.
extends Node

var datastore: Datastore


func _ready() -> void:
	# TODO: Load datastore from disk
	datastore = Datastore.new()


func add_tab(tab_name: String, member_names: Array[String]) -> void:
	var tab := Tab.new()
	tab.name = tab_name
	
	member_names.sort()
	for n in member_names:
		var person := Person.new()
		person.name = n
		person.balance = 0.0
		tab.members.append(person)
	
	datastore.tab_data.append(tab)
