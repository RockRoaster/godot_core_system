extends RefCounted
## 计时器数据结构


var id: String
var duration: float
var elapsed: float
var loop: bool
var paused: bool
var callback: Callable


func _init(p_id: String, p_duration: float, p_loop: bool = false, p_callback: Callable = Callable()):
	id = p_id
	duration = p_duration
	elapsed = 0.0
	loop = p_loop
	paused = false
	callback = p_callback
