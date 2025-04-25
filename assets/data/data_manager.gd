## A Singleton that holds Tab data.
##
## Saves, loads, and provides the data for other nodes to reference.
extends Node

const DATASTORE_SAVE_PATH := "user://datastore.tres"
const SAMPLE_TAB_PATH := "res://assets/data/sample_data/coffee_tab.tres"

var datastore: Datastore

func _ready() -> void:
	# TODO: Load datastore from disk
	load_datastore()


func _load_sample_tab() -> Tab:
	var tab := Tab.new()
	var sample_tab := load(SAMPLE_TAB_PATH)
	
	tab.name = sample_tab.name
	
	tab.members = []
	for p in sample_tab.members:
		var person: Person = p.duplicate()
		tab.members.append(person)
	
	tab.purchases = []
	for p in sample_tab.purchases:
		var purchase: Purchase = p.duplicate()
		tab.purchases.append(purchase)
	
	tab.next_purchaser = tab.members[0]
	return tab


func save_datastore() -> void:
	var err := ResourceSaver.save(datastore, DATASTORE_SAVE_PATH, ResourceSaver.FLAG_REPLACE_SUBRESOURCE_PATHS)
	if err == OK:
		print("Saved datastore to: ", DATASTORE_SAVE_PATH)
	else:
		print("ERROR: Failed to save datstore: ", err)


func load_datastore() -> void:
	var data: Datastore = ResourceLoader.load(DATASTORE_SAVE_PATH)
	if data:
		print("Loaded datstore from ", DATASTORE_SAVE_PATH)
		datastore = data
	else:
		print("Failed to load datastore. Creating new datastore.")
		datastore = Datastore.new()
		var sample_tab := _load_sample_tab()
		datastore.tabs.append(sample_tab)
		save_datastore()


func add_tab(tab_name: String, member_names: Array[String]) -> void:
	var tab := Tab.new()
	tab.name = tab_name
	
	member_names.sort()
	for n in member_names:
		var person := Person.new()
		person.name = n
		person.balance = 0.0
		tab.members.append(person)
	
	tab.next_purchaser = tab.members[0]
	datastore.tabs.append(tab)
	save_datastore()


func add_purchase_to_tab(tab: Tab, purchase: Purchase) -> void:
	for i in datastore.tabs.size():
		var t := datastore.tabs[i]
		if t.name == tab.name:
			t.purchases.append(purchase)
			
			# Subtract individual cost from each Person's balance if they didn't pay.
			for person in t.members:
				person.balance -= purchase.orders[person.name].cost
				if person.name == purchase.purchaser.name:
					person.balance += purchase.cost
	
			t.members.sort_custom(
				func(a: Person, b: Person):
					return a.balance < b.balance
			)
	
			t.next_purchaser = t.members[0]
			save_datastore()
			return


func get_tab_by_name(tab_name: String) -> Tab:
	for tab in datastore.tabs:
		if tab.name == tab_name:
			return tab
	
	return null
