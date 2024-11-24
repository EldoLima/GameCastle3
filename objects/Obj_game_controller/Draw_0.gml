
#region Game over

if (game_over) 
{
    // Pega informações da câmera
    var x1 = camera_get_view_x(view_camera[0]);
    var y1 = camera_get_view_y(view_camera[0]);
    var w = camera_get_view_width(view_camera[0]);
    var h = camera_get_view_height(view_camera[0]);
    var x2 = x1 + w;
    var y2 = y1 + h;

    // Calcula o centro da tela
    var meio_w = x1 + w / 2; // Centro horizontal
    var meio_h = y1 + h / 2; // Centro vertical

    // Define o tamanho das barras
    var qtd = h * .15;

    // Animação de interpolação
    valor = lerp(valor, 1, .01);

    draw_set_color(c_black);

    // Escurecendo a tela
    draw_set_alpha(valor - .3);
    draw_rectangle(x1, y1, x2, y2, false);

    // Desenha o retângulo superior
    draw_set_alpha(1);
    draw_rectangle(x1, y1, x2, y1 + qtd * valor, false);

    // Desenha o retângulo inferior
    draw_rectangle(x1, y2, x2, y2 - qtd * valor, false);
    draw_set_alpha(1);

    // Restaura a cor para evitar interferências
    draw_set_color(-1);

    // Delay para o "Game Over"
    if (valor >= .85) 
	{
        contador = lerp(contador, 1, .01);

        // Desenha "Game Over"
        draw_set_alpha(contador);
        draw_set_font(Fnt_gameover); // Define a fonte para "Game Over"
        draw_set_valign(1);
        draw_set_halign(1);

        // Sombra do texto
        draw_set_color(c_red);
        draw_text(meio_w + 1, meio_h + 1, "G a m e  O v e r");

        // Texto principal
        draw_set_color(c_white);
        draw_text(meio_w, meio_h, "G a m e  O v e r");

        // Reseta a fonte para texto secundário
        draw_set_font(-1); // Remove fonte personalizada
        draw_set_color(c_white); // Define cor branca para o texto
        draw_text(meio_w + 10, meio_h + 40, "Press ENTER to restart");

        // Restaura alinhamento
        draw_set_valign(-1);
        draw_set_halign(-1);
        draw_set_alpha(0);

        // Checa se ENTER foi pressionado para reiniciar
        if (keyboard_check_pressed(vk_enter))
		{
            game_restart(); // Reinicia o jogo
        }
    }
}
else
{
    valor = 0; // Reseta valor quando game_over é falso
}

#endregion