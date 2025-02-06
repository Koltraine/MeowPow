class_name State extends RefCounted

var state_name: String
var state_machine: SM
var parent: CharacterBody2D
var animations: AnimatedSprite2D


func _init(name: String) -> void:
    state_name = name

func link_sm(sm: SM):
    self.state_machine = sm
    self.parent = sm.parent
    self.animations = sm.animations

func enter():
    push_error("State '" + state_name + "' must implement the enter() method")

func exit():
    push_error("State '" + state_name + "' must implement the exit() method")

func transition_to(new_state: String):
    self.state_machine._transition(new_state)

func process(_delta: float) -> void:
    push_error("State '" + state_name + "' has not implemented the process() method")

func process_input(_e: InputEvent):
    push_error("State '" + state_name + "' has not implemented the process_input() method")