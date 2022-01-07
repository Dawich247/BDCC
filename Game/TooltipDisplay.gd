extends MarginContainer

var is_active := false setget set_is_active

onready var _tween := $Tween
onready var _title := $VBoxContainer/Title
onready var _body := $VBoxContainer/Body


func _ready() -> void:
	modulate = Color.transparent
	set_is_active(false)


func _process(_delta: float) -> void:
	rect_global_position = get_global_mouse_position() - Vector2(rect_size.x/2.0, rect_size.y) - rect_pivot_offset
	rect_global_position.x = max(0, rect_global_position.x)
	#rect_global_position.x = clamp(rect_global_position.x, 0, ProjectSettings.get("display/window/size/width") - rect_size.x)
	#rect_global_position.y = clamp(rect_global_position.y, 0, ProjectSettings.get("display/window/size/height") - rect_size.y)


func set_is_active(value: bool):
	is_active = value
	set_process(is_active)

	if is_active:
		modulate = Color.white
		_tween.stop_all()
	else:
		_tween.interpolate_property(self, "modulate", modulate, Color.transparent, 0.2)
		_tween.start()


func set_text(title: String, body: String):
	_title.text = title.capitalize()
	_body.text = body
	#yield(get_tree(), "idle_frame")
	#_body.set_size(Vector2(_body.get_size().x, _body.get_v_scroll().get_max()))
	yield(get_tree(), "idle_frame")
	rect_size.y = 0
	rect_size.x = 0
	#_body.set_size(Vector2(_body.get_size().x, _body.get_v_scroll().get_max()))
	#yield(get_tree(), "idle_frame")
	
	#rect_size = Vector2(0,0)
	#_body.rect_size = Vector2(0,0)
	#$VBoxContainer.rect_size = Vector2(250,0)
