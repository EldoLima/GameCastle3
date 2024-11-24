/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
#region Geral
//Iniciando variaveis 
var right, left, jump, attack, dash;
 var chao = place_meeting(x, y + 1, Obj_block);
 
 
right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
jump = keyboard_check(ord("W"));
attack = keyboard_check_pressed(ord("K"));
dash = keyboard_check(ord("L"));
if (ataque_buff > 0) ataque_buff -= 1;






//Aplicando gravidade 
if (!chao)
{ 
	 if (velv < max_velv *2) 
	
   {
	velv += GRAVIDADE * massa * global.vel_mult;
   }
}

//codigo de movimentação 
velh = (right - left ) * max_velh * global.vel_mult;

#endregion
//Iniciando maquina de estados
#region maquina de estados
switch(estado)
{
	#region parado
	case  "parado":
	{
		//Comportamento de estado 
		sprite_index = Spr_player_parado1;
		
		
		//Condição de troca de estado
		//Movendo
		if (right || left)
		{
			estado = "movendo";
		}
		else if (jump || velv != 0)
		{
			estado = "pulando";
			velv = (-max_velv * jump);
			image_index = 0;
		}
		else if (attack)
		{
			estado = "ataque";
			velh = 0
			image_index = 0;
		}
		else if (dash)
		{
			estado = "dash";
			image_index = 0;
		}
		break;
	}
	#endregion
	
	#region movendo 
	case "movendo":
	{
		//comportamento de estado de movimento
		sprite_index = Spr_player_run
		
		
		//Condição de troca de estado
		//Parado 
		if (abs(velh) < .1)
		{
			estado = "parado";
			velh = 0;	
		}
		else if (jump || velv != 0)
		{
			estado = "pulando";
			velv = (-max_velv * jump);
			image_index = 0;
		}
		else if (attack)
		{
			estado = "ataque";
			velh = 0
			image_index = 0;
		}
		else if (dash)
		{
			estado = "dash" ;
			image_index = 0;
		}
		break;
	}
 #endregion
	
	#region pulando 
	case "pulando":
	{ 
		//Comportamento de estado pulo/queda
		
		if (velv > 0)
		{
			sprite_index = Spr_player_fall;
		}
		else
		{
			sprite_index = Spr_player_pulo
			//Garantindo que a animação não se repita
			if (image_index >= image_number-1)
			{
				image_index = image_number-1;
			}
		}
		
		//condição de troca de estado 
		if (chao)
		{
			estado = "parado";
		}
		
		break;
	}
	#endregion
	
	#region ataque
	case "ataque":
	{
		velh = 0;
		
		if (combo == 0)
		{
		sprite_index = Spr_player_atq1;
		}
		else if (combo == 1)
		{
			sprite_index = Spr_player_atq2;
		}
		else if (combo == 2)
		{ 
			sprite_index = Spr_player_atq3;
		}
		// criando objeto de dano 
		if (image_index >=2 && dano == noone && posso)
		{
			dano		= instance_create_layer(x + sprite_width/2, y - sprite_height/15, layer, Obj_dano);
			dano.dano	= ataque * ataque_mult;
			dano.pai	= id;
			posso		= false;
		}
		
		
		// configurando com o buff
		if (attack &&  combo <2)
		{
			ataque_buff = room_speed;
		}
		
		if (ataque_buff && combo < 2 && image_index >= image_number-1)
		{
			combo++;
			image_index = 0;
			posso = true;
			ataque_mult += .7;
			if (dano)
			{
				instance_destroy(dano, false);
				dano = noone;
			}
			// zerar o buffer 
			ataque_buff = 0;
		}
		
		if (image_index > image_number-1)
		{
			estado = "parado"
			velh	= 0;
			combo	= 0;
			posso	= true;
			ataque_mult = 1;
			if (dano)
			{
				instance_destroy(dano, false);
				dano = noone;
			}
		}
		if (dash)
		{
			estado = "dash" ;
			image_index = 0;
			combo = 0;
			if (dano)
			{
				instance_destroy(dano, false);
				dano = noone;
			}
			if (velv != 0)
			{
	
			estado = "pulando";
			velv = (-max_velv * jump);
			image_index = 0;
	
			}	
		}
			break;
	}
	#endregion
	
	#region dash 
	
	case "dash":
	{
		sprite_index = Spr_player_dash;
		
		//velocidade
		velh = image_xscale * dash_vel;
		
		
		
		//saindo do estado de dash 
		if (image_index >= image_number - 1)
		{
			estado = "parado"
		}
		
		break;
	}
	#endregion
	
	#region hit
	case "hit":
	{
		if (sprite_index != Spr_player_hit)
		{
			sprite_index = Spr_player_hit;
			image_index = 0;
			
			//Tremendo a tela
			screenshake(3);
		}
		
		//Ficando parado ao levar dano
		velh = 0;
		
		
		// saindo do estado de hit(parando de tomar dano)
		if (vida_atual > 0)
		{
			
			if (image_index >= image_number - 1)
			{
				estado = "parado";
		
			}
		}
		else
		{
			if (image_index >= image_number - 1)
			{
				estado = "dead";
			}
		}
		break;
	}
	
	#endregion
	
	#region dead
	case "dead":
	{
		
		//Checando se o controlador existe
		if (instance_exists(Obj_game_controller))
		{
			with(Obj_game_controller)
			{
				game_over = true;
			}
		}
		
		
		velh = 0;
		if (sprite_index != Spr_player_dead)
		{
			// entrando no estado dead
			
			sprite_index = Spr_player_dead;
			image_index = 0;
		}
		// ficando parado no local apos morrer
		
			if (image_index >= image_number - 1)
			{
				image_index = image_number -1;
			}
		
			break;
	}
		#endregion
		
	//Estado padrão 
	default:
	{
		estado = "parado"
	}
}

#endregion
/*
if(keyboard_check(vk_enter)) game_restart();