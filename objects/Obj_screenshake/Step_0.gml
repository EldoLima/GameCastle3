/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Tremendo
view_xport[0] = random_range(-shake, shake);
view_yport[0] = random_range(-shake, shake);

shake *= .9;

// Destruindo
if (shake <= .2)
{
	instance_destroy();

}