<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Inmueble extends Model
{
    protected $fillable = [
        'nombre', 'tipo', 'precio','descripcion','municipio','foto',
    ];
}
