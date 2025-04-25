## Individual order on a Tab.
class_name Purchase
extends Resource

## Unix integer timestamp
var timestamp: float

## Person who paid for the Purchase.
var purchaser: Person

## Total cost of Purchase's Orders.
var cost: float

## Dictionary of individual Persons' Orders.
var orders: Dictionary[String, Order]


## An individual Person's purchased item.
##
## A collection of Orders makes up a Purchase.
class Order:
	var person: Person
	var item: String
	var cost: float
