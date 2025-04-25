class_name TabMemberItem
extends HBoxContainer

const POSITIVE := Color("#5B8C5A")
const NEGATIVE := Color("#FE5F55")

@onready var member_name_label := $MemberName
@onready var member_balance_label := $MemberBalance


func init(member_name: String, member_balance: float) -> void:
	member_name_label.text = member_name
	
	if member_balance >= 0:
		member_balance_label.text = "$" + str(member_balance)
		member_balance_label.add_theme_color_override("font_color", POSITIVE)
	else:
		member_balance_label.text = "-$" + str(member_balance)
		member_balance_label.add_theme_color_override("font_color", NEGATIVE)
