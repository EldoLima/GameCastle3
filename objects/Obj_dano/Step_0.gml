/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


var outro;
var outro_lista = ds_list_create();
var quantidade = instance_place_list(x, y, Obj_entidade, outro_lista, 0);

//Adicionando todo mundo que eu toquei na lista de aplicar dano
for (var i = 0; i < quantidade ; i++)
{
	// checando o atual 
	var atual = outro_lista[|i];
	
	if (object_get_parent(atual.object_index) !=object_get_parent(pai.object_index))
	{
		// isso só vai rodar se eu realmente puder dar dano no coisinho 
		
		// checar  se eu realmente	posso dar dano 
		
		//checar se o atual ja está na lista 
		
		var pos = ds_list_find_index(aplicar_dano, atual);
		if (pos == -1)
		{
			//O atual ainda não está na minha lista de dano
			//Adiciono o atual a lista de dano
			ds_list_add (aplicar_dano, atual);
		}	
	}
}
//Aplicando o dano 
var tam = ds_list_size(aplicar_dano);
for (var i = 0; i< tam; i++)
{
	outro = aplicar_dano[| i].id;
	if (outro.vida_atual > 0)
	{	
		outro.estado = "hit";
		outro.image_index = 0;
		outro.vida_atual -= dano;
		
		//Preciso checar se estou acertando o inimigo
		//Checando se sou filho do inimigo pai
		if (object_get_parent(outro.object_index) == Obj_inimigo_pai)
		{
			//dando um screenshake apenas para inimigos
			screenshake(2);
		
		
		}
		
	}
}
//Destruindo as minhas listas
ds_list_destroy(aplicar_dano);
ds_list_destroy(outro_lista);
instance_destroy();


/*/ se eu  estou tocando em alguem 
if (outro)
{
	//checando se não estou tocando no meu pai
	if (outro.id != pai)
	{
		
		//Checando quem é o pai do outro
		var papi = object_get_parent(outro.object_index);
		if (papi != object_get_parent(pai.object_index))
		 {
		
			if (outro.vida_atual > 0)
			{	
				outro.estado = "hit";
				outro.image_index = 0;
				outro.vida_atual -= dano;
				instance_destroy();
			}
		}
	}
}
