extends Node


onready var parent = get_parent()
onready var p_states = parent.States

onready var dash_cooldown = $Dashing/DashCooldown
onready var dash_duration = $Dashing/DashDuration


func change_state(from, to):
	match (from):
		p_states.DISABLED:
			match (to):
				p_states.IDLE:
					parent.current_state = p_states.IDLE
		p_states.IDLE:
			match (to):
				p_states.DISABLED:
					parent.current_state = p_states.DISABLED
				p_states.MOVING:
					parent.current_state = p_states.MOVING
					$Moving.enabled = true
		p_states.MOVING:
			match (to):
				p_states.IDLE:
					$Moving.enabled = false
					parent.current_state = p_states.IDLE
				p_states.DASHING:
					if dash_cooldown.is_stopped():
						$Moving.enabled = false
						parent.current_state = p_states.DASHING
						$Dashing.start_dash()
					
		p_states.DASHING:
			match (to):
				p_states.IDLE:
					parent.current_state = p_states.IDLE
				p_states.MOVING:
					if dash_duration.is_stopped():
						$Moving.enabled = true
						parent.current_state = p_states.DASHING


func state_transition(from, to):
	match (from):
		p_states.DISABLED:
			pass
		p_states.IDLE:
			pass
		p_states.MOVING:
			pass
		p_states.DASHING:
			pass
