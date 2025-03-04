extends Area2D
signal close
signal delete
var stat = "Open"

func _ready() -> void:
	body_entered.connect(_on_area_2d_body_entered)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Camper") && stat == "Open":
		stat = "Closed"
		close.emit()
		$Disappear.start(1)
		body.beartrapKill()


func _on_disappear_timeout() -> void:
	delete.emit()
