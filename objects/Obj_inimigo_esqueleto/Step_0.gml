/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var chao = place_meeting(x, y + 1, Obj_block);

if (!chao)
{
	velv += GRAVIDADE * massa * global.vel_mult;
}
 
 
switch(estado)
{
	case "parado":
	{
		velh = 0;
		timer_estado++;
		if(sprite_index != Spr_esqueleto_idle)
		{ 
			image_index =0;
		}
		// estado de moviemnto do inimigo 
		sprite_index = Spr_esqueleto_idle;
		
		
		//indo para o estado de patrulha 
		if (irandom(timer_estado) > 300)
		{
			estado = choose ("movendo", "parado", "movendo");			
		}
		scr_ataca_player_melee(Obj_player, dist, xscale);
		
		break;
	}
	case "movendo":
	{
		timer_estado++;
		if (sprite_index != Spr_esqueleto_walk)
		{
			image_index = 0;
			velh = choose (1, -1);
		}
		
		// estado de movimento do inimigo 
		sprite_index = Spr_esqueleto_walk;
		
		// condição de troca de estado 
		if (irandom(timer_estado) > 300)
		{
			estado = choose ("parado", "parado", "movendo");
			timer_estado = 0;
		}
		scr_ataca_player_melee(Obj_player, dist, xscale);
		
		break;
	}
	case "ataque":
	{
		velh = 0;
		if (sprite_index != Spr_esqueleto_Attack)
		{
			image_index = 0;
			posso = true;
		}
		sprite_index = Spr_esqueleto_Attack;
		
		// troca de estado 
		if (image_index > image_number-1)
		{
			estado = "parado";
		}
		
		// Criando o dano 
		if (image_index >= 8 && dano == noone && image_index < 15 && posso)
		{
			dano = instance_create_layer(x + sprite_width/2, y - sprite_height/3, layer, Obj_dano);
			dano.dano = ataque;
			dano.pai = id;
			posso = false
		}
		
		//Destruindo o dano 
		if (dano != noone && image_index >= 15)
		{
			instance_destroy(dano);
				dano = noone;
		}
		
		
		break;
	}
	case "hit":
	{
		if (sprite_index != Spr_esqueleto_hit)
		{ 
			image_index = 0;
			//vida_atual--;
		}
		sprite_index = Spr_esqueleto_hit;
		
		//Condição para do estado de hit
	
			if (vida_atual > 0)
			{
				if (image_index > image_number-1)
				{ 
					estado = "parado";
				}
			}
			else
			{
				if (image_index >= 3)
				{ 
					estado = "dead";
				}
				
			
			}
			break;
	}
	case "dead":
	{
		velh = 0;
		if (sprite_index != Spr_esqueleto_dead)
		{
			image_index = 0;
		}
		sprite_index = Spr_esqueleto_dead;
		
		//Morrendo de verdade
		if (image_index > image_number-1)
		{
			image_speed = 0;
			image_alpha -= .01;
			
			if (image_alpha <= 0) instance_destroy();
		}
	
		break;
	}
	
	
	
}