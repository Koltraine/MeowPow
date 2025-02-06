class_name SM extends RefCounted

var states: Dictionary = {}
var current_state: State

var parent: CharacterBody2D
var animations: AnimatedSprite2D

func _init(target: CharacterBody2D, anim: AnimatedSprite2D) -> void:
    self.parent = target
    self.animations = anim

func add_state(to_add: State):
    to_add.link_sm(self)
    
    states[to_add.state_name] = to_add
    
    if states.size() == 1:
        current_state = to_add
        current_state.enter()

func _transition(target: String):
    # print("Transitioning from ", current_state.state_name, " to ", target)
    if target in states:
        current_state.exit()
        current_state = states[target]
        current_state.enter()
    else:
        push_error("State '" + target + "' not in state machine.")

func process(delta: float):
    current_state.process(delta)

func process_input(e: InputEvent):
    current_state.process_input(e)