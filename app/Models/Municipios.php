<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Municipios extends Model
{
    public function departamento()
    {
        return $this->belongsTo(Departamentos::class, 'id_departamento' );
    }
}
