extends Node

const MAIN_SCREEN := preload("res://assets/scenes/main_screen/main_screen.tscn")
const TAB_DETAIL_SCREEN := preload("res://assets/scenes/tab_detail_screen/tab_detail_screen.tscn")

var current_scene: Control


func _ready() -> void:
	Events.tab_selected.connect(_on_tab_selected)
	Events.return_to_main_menu_pressed.connect(_on_return_to_main_menu_pressed)
	current_scene = $MainScreen


func _on_tab_selected(tab: Tab) -> void:
	remove_child(current_scene)
	current_scene.queue_free()
	var detail: TabDetailScreen = TAB_DETAIL_SCREEN.instantiate()
	current_scene = detail
	add_child(current_scene)
	current_scene.init(tab)


func _on_return_to_main_menu_pressed() -> void:
	remove_child(current_scene)
	current_scene.queue_free()
	var main_screen: MainScreen = MAIN_SCREEN.instantiate()
	current_scene = main_screen
	add_child(main_screen)
