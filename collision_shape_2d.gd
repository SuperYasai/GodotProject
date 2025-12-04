# KillZone.gd
extends CollisionShape2D

func _ready() -> void:
	# connect safely in code so it's copy-paste friendly
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	# Only act on nodes in the "player" group
	if body.is_in_group("player"):
		# optional debug:
		print("KillZone: touched by ", body.name)
		# call the player's kill function
		if body.has_method("kill_player"):
			body.kill_player()
		else:
			# fallback: try to move it to the respawn if the script differs
			if body.has_node("../RespawnPoint"):
				body.global_position = $"../RespawnPoint".global_position
