class_name TabSummary
extends HBoxContainer

@onready var tab_name_label := $TabName
@onready var next_to_pay_label := $NextToPay

var tab: Tab :
	set(val):
		tab = val
		tab_name_label.text = str(tab.name)
		next_to_pay_label.text = tab.members[0].name
