extends Node

onready var parent = get_parent()
onready var p_states = parent.States


func change_state(from, to):
	match (from):
		p_states.IDLE:
			if to == p_states.ACTIVE:
				parent.current_state = p_states.ACTIVE
				$Active.enabled = true
		p_states.ACTIVE:
			if to == p_states.STICKED:
				parent.current_state = p_states.STICKED
				$Active.enabled = false
				$Sticked.stick()
		p_states.STICKED:
			if to == p_states.THROWED:
				parent.current_state = p_states.THROWED
				$Active.enabled = true
		p_states.THROWED:
			if to == p_states.ACTIVE:
				parent.current_state = p_states.ACTIVE
				$Active.enabled = true
			if to == p_states.STICKED:
				parent.current_state = p_states.STICKED
				$Active.enabled = false
				$Sticked.stick()
	
	if to == p_states.IDLE:
		parent.current_state = p_states.IDLE
		$Active.enabled = false


func state_transition(from, to):
	match (from):
		p_states.IDLE:
			pass
		p_states.ACTIVE:
			pass
		p_states.STICKED:
			pass
		p_states.THROWED:
			pass

