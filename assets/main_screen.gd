extends Control

@onready var anim := $AnimationPlayer
@onready var add_tab_button := $TabListView/AddTab
@onready var add_tab_view: AddTabView = $AddTabView


func _ready() -> void:
	add_tab_button.pressed.connect(_on_add_tab_button_pressed)
	add_tab_view.tab_created.connect(_on_tab_view_tab_created)
	add_tab_view.tab_discarded.connect(_on_tab_view_tab_discarded)


func _on_add_tab_button_pressed() -> void:
	add_tab_view.reset_form()
	anim.play("show_add_tab_view")


func _on_tab_view_tab_created() -> void:
	anim.play("hide_add_tab_view")


func _on_tab_view_tab_discarded() -> void:
	anim.play("hide_add_tab_view")
