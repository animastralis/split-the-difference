class_name TabDetailScreen
extends Control

const TAB_MEMBER_ITEM := preload("res://assets/scenes/tab_detail_screen/tab_member_item.tscn")
const PURCHASE_HISTORY_LINE := preload("res://assets/scenes/tab_detail_screen/purchase_history_line.tscn")
const SEPARATOR := preload("res://assets/shared/list_separator.tscn")

@onready var add_purchase_button := $TabDetailView/AddPurchase
@onready var add_purchase_view: AddPurchaseView = $AddPurchaseView
@onready var tab_name_label := $TabDetailView/VBoxContainer/HBoxContainer/TabName
@onready var anim := $AnimationPlayer
@onready var member_list := $TabDetailView/VBoxContainer/MemberContainer/MemberList
@onready var history_list := $TabDetailView/VBoxContainer/HistoryContainer/HistoryList
@onready var back_button := $TabDetailView/VBoxContainer/HBoxContainer/Back

var tab: Tab


func _ready() -> void:
	add_purchase_button.pressed.connect(_on_add_purchase_button_pressed)
	add_purchase_view.purchase_canceled.connect(_on_purchase_view_purchase_canceled)
	add_purchase_view.purchase_submitted.connect(_on_purchase_view_purchase_submitted)
	back_button.pressed.connect(_on_back_button_pressed)


func init(tab_: Tab) -> void:
	tab = tab_
	
	_populate_member_list(tab)
	_populate_purchase_history(tab)
	
	tab_name_label.text = tab.name
	add_purchase_view.init(tab)
	anim.play("RESET")


func _on_add_purchase_button_pressed() -> void:
	anim.play("show_add_purchase_view")


func _on_purchase_view_purchase_canceled() -> void:
	anim.play("hide_add_purchase_view")


func _on_purchase_view_purchase_submitted() -> void:
	_update_view()
	anim.play("hide_add_purchase_view")


func _on_back_button_pressed() -> void:
	Events.return_to_main_menu_pressed.emit()


# FIXME: Duplicate code
func _update_view() -> void:
	for child in member_list.get_children():
		child.queue_free()
	
	for child in history_list.get_children():
		if child.name != "RecentPurchases":
			child.queue_free()
	
	tab = DataManager.get_tab_by_name(tab.name)
	_populate_member_list(tab)
	_populate_purchase_history(tab)
	
	add_purchase_view.reset(tab)


# Helper function to populate the members list
func _populate_member_list(t: Tab) -> void:
	var counter := len(t.members) - 1
	for p in t.members:
		var item := TAB_MEMBER_ITEM.instantiate()
		member_list.add_child(item)
		item.init(p.name, p.balance)
		
		if counter > 0:
			var separator := SEPARATOR.instantiate()
			member_list.add_child(separator)
			counter -= 1


# Helper function to populate the recent purchases list
func _populate_purchase_history(t: Tab) -> void:
	var recent_purchases := t.purchases.duplicate()
	recent_purchases.reverse()
	var counter := 3
	for p in recent_purchases:
		var line: PurchaseHistoryLine = PURCHASE_HISTORY_LINE.instantiate()
		history_list.add_child(line)
		line.init(p)
		counter -= 1
		if counter > 0:
			history_list.add_child(SEPARATOR.instantiate())
		elif counter <= 0:
			break
