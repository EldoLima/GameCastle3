/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// sistema de colisão e movimentação 
var _velh = sign(velh);
var _velv = sign(velv);

#region horizontal
//Horizontal
repeat(abs(velh))
{
	if(place_meeting(x + _velh, y,Obj_block))
	{ 
		Velh = 0;
		break;
	}
	x +=  _velh;
}
#endregion

#region vertical
//vertical
repeat(abs(velv))
{
	if(place_meeting(x, y + _velv, Obj_block))
	{
		velv = 0;
		break;
	}	
	y += _velv;
}		
#endregion