extends AnimatedSprite2D

# 敌机初始生命
var hp:float = 1
# 销毁倒计时
var timer:float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	# 连接自身 Area2D 的 area_entered 信号，当子弹进入范围时触发
	$Area2D.connect("area_entered", Callable(self, "_on_area_2d_area_entered"))

# 处理子弹进入的信号
func _on_area_2d_area_entered(_area: Area2D) -> void:
	# 检查当前的生命值，如果为0，则直接返回
	if hp <= 0:
		return
		
	# 检测到进入的信号，则敌机减少生命值并播放爆炸动画
	hp -= 1
	self.play("explode")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 如果生命值为0，启动销毁计时器
	if hp <= 0:
		timer -= delta
		# 计时结束后，销毁该节点
		if timer <= 0:
			queue_free()
		return
	
	# 默认向下移动
	position += Vector2.DOWN * 300 * delta
	
	# 如果移出屏幕底部，则销毁
	if position.y > 900:
		queue_free()
