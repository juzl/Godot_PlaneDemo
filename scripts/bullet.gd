extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 默认子弹向上移动
	position += Vector2.UP * 500 * delta
	
	# 如果飞出屏幕，则销毁
	if position.y < -100:
		queue_free()
