extends Node

# 敌机场景预加载
var enemy_scene = preload("res://scenes/enemy.tscn")

# 刷新计时器
var timer:float = 0

func _ready() -> void:
	pass

	
func _process(delta: float) -> void:
	timer += delta
	
	if timer >1:
		timer = 0
		# 实例化敌机场景
		var enemy = enemy_scene.instantiate()
		# 敌机在x方向随机刷新
		var x:float = randf_range(50, 550)
		enemy.position = Vector2(x, 0)
		# 将敌机添加为父节点的子节点
		get_parent().add_child(enemy)
