if (distance_to_object(obj_Player) < World.ANIMALS_DISTANCE_TO_ACTIVE) {

	// Modifica o fator de interpolação para algo mais perceptível
	move_x = lerp(move_x, dir_x * alerta * 0.1, 0.1) * (room_speed / 60);  // Aqui aumentei o fator e o valor de interpolação

	// Verifica colisão com o chão e executa pulo se estiver em movimento
	if (place_meeting(x + 2.0, y, floor_tilemap) && move_x != 0 || place_meeting(x - 2.0, y, floor_tilemap) && move_x != 0) {
	    jump();
	}

	if (on_floor()) {
		sprite_index = Galinha__spr;
		move_y = 0;
	}
	else {
		sprite_index = Galinha_Jump_spr;
		move_y = gravity_speed;
	}

	if (dir_x < 0) {
		image_xscale = -1;
	
		var tile_x = floor(x / 16);
		var tile_y = floor(y / 16);
	
		if (tile_x - 1 > 0) {
			if (get_biome(World.height_map[tile_x - 1], World.world_sizey, World.temperature_map[tile_x - 1]) != 0) {
				dir_x = 1;
			}
			else {
				dir_x = map_value(perlin_noise(move_perlin_noise), -1.0, 1.0, -1.0, 1.0);
			}
		}
	}
	else if (dir_x > 0) {
		image_xscale = 1;
	
		var tile_x = floor(x / 16);
		var tile_y = floor(y / 16);
	
		if (tile_x + 1 < World.world_sizex) {
			if (get_biome(World.height_map[tile_x + 1], World.world_sizey, World.temperature_map[tile_x + 1]) != 0) {
				dir_x = -1;
			}
			else {
				dir_x = map_value(perlin_noise(move_perlin_noise), -1.0, 1.0, -1.0, 1.0);
			}
		}
	}
	else {
		dir_x = map_value(perlin_noise(move_perlin_noise), -1.0, 1.0, -1.0, 1.0);
	}

	if (move_x < -0.1) {
		image_speed = 0;
		image_index = 0;
	}
	else if (move_x > 0.1) {
		image_speed = 0;
		image_index = 0;
	}
	else {
		image_speed = 1;
	}

	move_perlin_noise += 0.01 * vontade_de_explorar;

	// Aplica o movimento e a colisão
	move_and_collide(move_x, move_y, floor_tilemap);

	// Step Event da galinha (Object9)

	// Incrementa o contador a cada frame
	contador_tempo += 1 * (delta_time / 100000);

	// Verifica se o tempo de espera foi atingido
	if (contador_tempo >= tempo_espera) {
	    // Soltar o ovo na posição da galinha
	    instance_create_layer(x, y, layer, obj_ovo);  // Cria o ovo na mesma posição da galinha
    
	    // Reseta o contador para o próximo ovo
	    contador_tempo = 0;
	}
	
	if (contador_tempo >= canto) {
		audio_play_sound_at(GalinhaSFX, x, y, 0, global.falloff_ref, global.falloff_max, 1, false, 0);
		canto = random_range(70, 300);
		
		contador_tempo = 0;
	}
}

fome = max(0, fome-1);
alerta = min(100, alerta+1);

if (alerta == 100) {
	alerta = 0;
}

// coisas n dependentes do player:
if (World.time > 18 && World.time < 24 || World.time > 0 && World.time < 5) {
	sono = min(100, sono+1);
}
else {
	sono = max(0, sono-1);
}