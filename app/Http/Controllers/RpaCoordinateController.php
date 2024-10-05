<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class RpaCoordinateController extends Controller
{

    public function getRpaCoordinates()
    {
        // Realizar la solicitud a la API de Python
        $response = Http::get('http://url-de-tu-api/ruta-del-rpa');
    
        // Verificar si la solicitud fue exitosa
        if ($response->successful()) {
            // Obtener los datos del RPA (suponiendo que la API devuelve un JSON con latitud y longitud)
            $data = $response->json();
            return response()->json($data);
        } else {
            return response()->json(['error' => 'No se pudo obtener la información del RPA'], 500);
        }
    }
    
}
