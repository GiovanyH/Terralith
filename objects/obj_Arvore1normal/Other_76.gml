
if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
		case "AxeAttack":
			if (distance_to_object(obj_Player) < 10.0) {
				if (life <= 0) {
					sprite_index = ArvoreBasicaToco_spr;
				}
				else {
					part_particles_burst(ps, x, y-64, DestroiArvore);
				
					var madeira = instance_create_layer(x, y-32, 2, DropItem);
					madeira.IMPULSO_X = random_range(-3, 3);
					madeira.sprite_index = MadeiraBasica_spr;
				
					life--;
				}
			}
		break;

        case "destroy":
            sequence_destroy(event_data[? "element_id"]);
        break;
    }
}