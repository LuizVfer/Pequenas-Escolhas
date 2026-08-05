#region Evitar duplicação

if (instance_number(obj_room_controller) > 1)
{
    instance_destroy();
    exit;
}

#endregion


#region Intensidade do parallax

parallax_mid = 0.5;
parallax_far = 0.2;
parallax_sky = 0;

#endregion


#region IDs iniciais

layer_mid = -1;
layer_far = -1;
layer_sky = -1;

#endregion