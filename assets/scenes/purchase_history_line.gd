class_name PurchaseHistoryLine
extends HBoxContainer

@onready var date_label := $Date
@onready var cost_label := $Cost
@onready var purchaser_label := $Purchaser


func init(purchase: Purchase) -> void:
	var date := Time.get_datetime_dict_from_unix_time(purchase.timestamp)
	var date_string := "%02d-%02d-%02d" % [
		date["month"], date["day"], date["year"]
	]
	date_label.text = date_string
	cost_label.text = "$" + str(purchase.cost)
	purchaser_label.text = purchase.purchaser.name
