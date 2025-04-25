## A Singleton that holds Tab data.
##
## Saves, loads, and provides the data for other nodes to reference.
extends Node

var datastore: Datastore

func _ready() -> void:
	# TODO: Load datastore from disk
	datastore = Datastore.new()
	var example_tab := _create_example_tab()
	datastore.tabs.append(example_tab)


func _create_example_tab() -> Tab:
	var tab := Tab.new()
	tab.name = "Coffee"
	
	# Members
	var ex_persons: Array[Person] = []
	for n in ["Bob", "Jim", "Mary", "David", "Sarah", "Alex", "Elizabeth"]:
		var person := Person.new()
		person.name = n
		person.balance = 0.0
		ex_persons.append(person)
	tab.members = ex_persons
	
	# Purchases
	#for p in ex_persons:
		#var order := Purchase.Order.new()
		#order.person = p
		#order.item = "Coffee"
		#order.cost =
	
	return tab


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


func add_purchase_to_tab(tab: Tab, purchase: Purchase) -> void:
	for t in datastore.tabs:
		if t.name == tab.name:
			t.purchases.append(purchase)
	
	# Subtract individual cost from each Person's balance if they didn't pay.
	for person in tab.members:
		person.balance -= purchase.orders[person.name].cost
		if person.name == purchase.purchaser.name:
			person.balance += purchase.cost
	
	tab.members.sort_custom(
		func(a: Person, b: Person):
			return a.balance < b.balance
	)
	
	tab.next_purchaser = tab.members[0]


func get_tab_by_name(tab_name: String) -> Tab:
	for tab in datastore.tabs:
		if tab.name == tab_name:
			return tab
	
	return Tab.new()
