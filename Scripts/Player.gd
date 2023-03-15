class_name Player
extends CharacterBody2D

@export var speed = 100
@export var accel = 500
@export var frict = 500

var input_direction = Vector2.ZERO

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true
