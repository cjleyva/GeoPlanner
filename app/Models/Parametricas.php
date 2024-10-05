<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Parametricas extends Model
{
    //

    use SoftDeletes;

    protected $dates = ['deleted_at'];

    public static function getFromCategory($categoria){
        $parametricas = parametricas::Where('categoria', $categoria)
        ->where('estado',1)
        ->orderBy('orden')
        ->select('id',"valor", 'texto')
        ->get();
        return $parametricas;
    }
}
