extends AnimatedSprite2D

# 飞机速度
@export var speed:float = 500
# 初始生命
var hp:float = 1
# 销毁倒计时
var timer:float = 0.2

# 子弹场景的预加载
var bullet_scene = preload("res://scenes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 连接自身 Area2D 的 area_entered 信号，当敌机进入范围时触发
	$Area2D.connect("area_entered", Callable(self, "_on_area_2d_area_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_movement(delta)
	handle_shooting()
	
	# 如果生命值为0，启动销毁计时器
	if hp <= 0:
		timer -= delta
		# 计时结束后，销毁该节点
		if timer <= 0:
			queue_free()
		return
	
# 处理飞机的移动逻辑
func handle_movement(delta: float) -> void:
	if Input.is_action_pressed("move_up") and position.y > 0:
		position.y += -speed * delta
	if Input.is_action_pressed("move_down") and position.y < 660:
		position.y += speed * delta
	if Input.is_action_pressed("move_left") and position.x > 0:
		position.x += -speed * delta
	if Input.is_action_pressed("move_right") and position.x < 500:
		position.x += speed * delta

# 处理子弹的发射逻辑
func handle_shooting() -> void:
	if Input.is_action_just_pressed("shoot"):
		# 在左侧和右侧生成子弹
		fire_bullet(Vector2.RIGHT * 20 + Vector2.DOWN * 20)
		fire_bullet(Vector2.RIGHT * 80 + Vector2.DOWN * 20)

# 发射子弹的功能函数
func fire_bullet(bullet_offset: Vector2) -> void:
	# 实例化子弹场景并将其添加为父节点的子节点
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	# 设置子弹的初始位置
	bullet.position = position + bullet_offset

# 处理敌机进入的信号
func _on_area_2d_area_entered(area: Area2D) -> void:
	# 检查当前的生命值，如果为0，则直接返回
	if hp <= 0:
		return
		
	# 检查进入的区域是否为 AnimatedSprite2D 类型的敌机
	if area.get_parent() is AnimatedSprite2D:
		# 减少生命值并播放爆炸动画
		hp -= 1
		self.play("player_explode")
	
