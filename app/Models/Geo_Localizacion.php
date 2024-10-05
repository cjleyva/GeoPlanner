<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Geo_Localizacion extends Model
{
    use SoftDeletes;
    protected $table = 'geo_localizacion';
}
