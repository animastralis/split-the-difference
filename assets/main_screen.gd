extends Control

const TAB_SUMMARY := preload("res://assets/scenes/tab_summary.tscn")
const TAB_SUMMARY_LIST_SEPARATOR := preload("res://assets/scenes/tab_summary_list_separator.tscn")

@onready var anim := $AnimationPlayer
@onready var add_tab_button := $TabListView/AddTab
@onready var add_tab_view: AddTabView = $AddTabView
@onready var tab_summary_list := $TabListView/VBoxContainer/MarginContainer/TabSummaryList


func _ready() -> void:
	add_tab_button.pressed.connect(_on_add_tab_button_pressed)
	add_tab_view.tab_submitted.connect(_on_tab_view_tab_submitted)
	add_tab_view.tab_discarded.connect(_on_tab_view_tab_discarded)


func _on_add_tab_button_pressed() -> void:
	add_tab_view.reset_form()
	anim.play("show_add_tab_view")


func _on_tab_view_tab_submitted() -> void:
	_load_tabs()
	anim.play("hide_add_tab_view")


func _on_tab_view_tab_discarded() -> void:
	anim.play("hide_add_tab_view")


func _load_tabs() -> void:
	for child in tab_summary_list.get_children():
		child.queue_free()
	
	# FIXME: Decouple
	var num_tabs := len(DataManager.datastore.tab_data)
	var counter := 0
	for tab in DataManager.datastore.tab_data:
		var tab_summary: TabSummary = TAB_SUMMARY.instantiate()
		tab_summary_list.add_child(tab_summary)
		tab_summary.tab = tab
		
		if counter < num_tabs - 1:
			tab_summary_list.add_child(TAB_SUMMARY_LIST_SEPARATOR.instantiate())
