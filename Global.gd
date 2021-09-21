extends Node

const map_list = ["", "res://game/maps/Map01.tscn", "res://game/maps/Map02.tscn"]

var current_map = 1

var ball_quantity = {
	"regular": 1,
	"sticky": 1
}

var points_to_win = 10

var played = false

# Configurações
var shake_intensity = 5
