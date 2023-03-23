extends Navigation2D

const SPAWN_ROOMS: Array = [
	preload("res://Rooms/SpawnRoom0.tscn"),
	preload("res://Rooms/SpawnRoom1.tscn")
]
const INTERMEDIATE_ROOMS: Array = [
	preload("res://Rooms/Room0.tscn"),
	preload("res://Rooms/Room1.tscn"),
	preload("res://Rooms/Room2.tscn"),
	preload("res://Rooms/Room3.tscn"),
]
const ROOMS_WITH_WEAPON : Array = [
	preload("res://Rooms/RoomWithWeapon0.tscn"),
	preload("res://Rooms/RoomWithWeapon1.tscn"),
]
const SPECIAL_ROOMS : Array = [
	preload("res://Rooms/SpecialRoom0.tscn")
]
const END_ROOMS: Array = [
	preload("res://Rooms/EndRoom0.tscn")
]

const TILE_SIZE := 16
const FLOOR_TILE_INDEX := 14
const RIGHT_WALL_TILE_INDEX := 42
const LEFT_WALL_TILE_INDEX := 43


export(int) var num_levels := 5

onready var player : KinematicBody2D = get_parent().get_node("Player")

func _ready() -> void:
	_spawn_rooms()

func _spawn_rooms() -> void:
	var previous_room: Node2D
	var special_room_spawned := false
	
	for i in num_levels:
		var room: Node2D
		
		if i == 0:
			room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instance()
			player.position = room.get_node("PlayerSpawnPos").position
		else:
			if i == num_levels - 1:
				room = END_ROOMS[randi() % END_ROOMS.size()].instance()
			else:
				if (randi() % 3 == 0 and not special_room_spawned) or (i == num_levels - 2 and not special_room_spawned):
					room = SPECIAL_ROOMS[randi() % SPECIAL_ROOMS.size()].instance()
					special_room_spawned = true
				elif randi() % 6 == 0:
					room = ROOMS_WITH_WEAPON[randi() % ROOMS_WITH_WEAPON.size()].instance()
				else:
					room = INTERMEDIATE_ROOMS[randi() % INTERMEDIATE_ROOMS.size()].instance()
			
			var previous_room_tilemap: TileMap = previous_room.get_node("TileMap")
			var previous_room_door: StaticBody2D = previous_room.get_node("Doors/Door")
			var exit_tile_pos: Vector2 = previous_room_tilemap.world_to_map(previous_room_door.position) + Vector2.UP * 2
			
			var corridor_height := randi() % 5 + 2
			for y in corridor_height:
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(-2, -y), LEFT_WALL_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(-1, -y), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(0, -y), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(1, -y), RIGHT_WALL_TILE_INDEX)
			
			var room_tilemap: TileMap = room.get_node("TileMap")
			room.position = previous_room_door.global_position + Vector2.UP * room_tilemap.get_used_rect().size.y * TILE_SIZE + Vector2.UP * (1 + corridor_height) * TILE_SIZE + Vector2.LEFT * room_tilemap.world_to_map(room.get_node("Entrance/Position2D2").position).x * TILE_SIZE
		
		add_child(room)
		previous_room = room
