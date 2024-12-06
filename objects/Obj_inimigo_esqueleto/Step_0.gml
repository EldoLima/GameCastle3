var chao = place_meeting(x, y + 1, Obj_block); // Verifica se há chão
var parede = place_meeting(x + velh, y, Obj_block); // Verifica se há parede à frente, considerando a direção do movimento

// Calculando a distância até o jogador
var distancia_player = point_distance(x, y, Obj_player.x, Obj_player.y); // Distância até o jogador
var distancia_ataque_max = 50; // Distância máxima para o inimigo atacar

// Gravidade
if (!chao) {
    velv += GRAVIDADE * massa * global.vel_mult;
}

// A lógica de movimento e interação com o jogador
switch(estado) {
    case "parado":
        velh = 0;
        timer_estado++;
        if(sprite_index != Spr_esqueleto_idle) { 
            image_index = 0;
        }
        sprite_index = Spr_esqueleto_idle;

        // Condição para começar a patrulha
        if (irandom(timer_estado) > 300) {
            estado = choose("movendo", "parado", "movendo");			
        }
        // Verifica se o jogador está na área de ataque
        scr_ataca_player_melee(Obj_player, dist, xscale);
        break;

    case "movendo":
        timer_estado++;
        if (sprite_index != Spr_esqueleto_walk) {
            image_index = 0;
            velh = choose(1, -1); // Inicializa a direção
        }
        
        // Movimentação do inimigo
        sprite_index = Spr_esqueleto_walk;

        // Se o inimigo bater numa parede ou não houver chão, muda a direção
        if (parede || !chao) {
            velh = -velh; // Inverte a direção
        }

        // Condição para mudar de estado
        if (irandom(timer_estado) > 300) {
            estado = choose("parado", "parado", "movendo");
            timer_estado = 0;
        }

        // Verifica se o jogador está dentro da distância de ataque e faz o inimigo atacar
        if (distancia_player < distancia_ataque_max && (x < Obj_player.x && xscale == 1 || x > Obj_player.x && xscale == -1)) {
            // O inimigo ataca se estiver à frente do jogador
            estado = "ataque"; // Inicia o ataque
        } else if (distancia_player < 150) {
            estado = "movendo"; // Caso o jogador esteja longe, o inimigo volta para o movimento
        }

        break;

    case "ataque":
        velh = 0;
        if (sprite_index != Spr_esqueleto_Attack) {
            image_index = 0;
            posso = true;
        }
        sprite_index = Spr_esqueleto_Attack;

        // Ação de ataque
        if (image_index > image_number-1) {
            estado = "parado";
        }

        if (image_index >= 8 && dano == noone && image_index < 15 && posso) {
            dano = instance_create_layer(x + sprite_width/2, y - sprite_height/3, layer, Obj_dano);
            dano.dano = ataque;
            dano.pai = id;
            posso = false;
        }

        if (dano != noone && image_index >= 15) {
            instance_destroy(dano);
            dano = noone;
        }

        break;

    case "hit":
        if (sprite_index != Spr_esqueleto_hit) { 
            image_index = 0;
        }
        sprite_index = Spr_esqueleto_hit;

        if (vida_atual > 0) {
            if (image_index > image_number-1) { 
                estado = "parado";
            }
        } else {
            if (image_index >= 3) { 
                estado = "dead";
            }
        }
        break;

    case "dead":
        velh = 0;
        if (sprite_index != Spr_esqueleto_dead) {
            image_index = 0;
        }
        sprite_index = Spr_esqueleto_dead;

        if (image_index > image_number-1) {
            image_speed = 0;
            image_alpha -= .01;
            if (image_alpha <= 0) instance_destroy();
        }

        break;
}

// Virando o inimigo para o jogador
if (Obj_player.x > x) {
    xscale = 1; // Vira para a direita
} else {
    xscale = -1; // Vira para a esquerda
}
