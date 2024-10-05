<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Geo_Localizacion;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;


class GeoLocalizacionController extends Controller
{
    public function index()
    {

        $data = Geo_Localizacion::orderBy('id')->get();

        return view('geo_localizacion.index', compact('data'));
    }

    public function create()
    {

        $fecha = $this->get_date_now();

        return view('geo_localizacion.create', compact('fecha'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'longitud' => 'required|numeric',
            'latitud' => 'required|numeric',
        ]);

        $id_usuario = $request->id_usuario;
        $fecha = $request->fecha;
        $longitud = $request->longitud;
        $latitud = $request->latitud;

        if (isset($request->id)) {
            $location = Geo_Localizacion::find($request->id);
            $location->updated_by = Auth::user()->id;
        } else {
            $location = new Geo_Localizacion();
            $location->created_by = Auth::user()->id;
        }
        $location->id_usuario = $id_usuario;
        $location->fecha = $fecha;
        $location->longitud = $longitud;
        $location->latitud = $latitud;
        $location->observaciones = $request->observaciones;
        $location->save();

        if (isset($request->id)) {
            return redirect()->route('home')->with(['info' => 'Registro actualizado con éxito', 'fecha' => $fecha, 'latitud' => $latitud, 'longitud' => $longitud]);
        } else {
            return redirect()->route('home')->with(['info' => 'Registro guardado con éxito', 'fecha' => $fecha, 'latitud' => $latitud, 'longitud' => $longitud]);
        }
    }

    public function edit($id)
    {

        $data = Geo_Localizacion::find($id);

        return view('geo_localizacion.edit', compact('data'));
    }

    public function get_date_now()
    {
        return Carbon::now()->parse()->format('Y-m-d');
    }

    public function delete($id)
    {

        $delete = Geo_Localizacion::where('id', $id)->firstOrFail();
        $delete->delete();
        $delete->deleted_by = Auth::user()->id;
        $delete->update();

        return redirect()->route('geo_localizacion.index')->with('info', 'Registro eliminado con éxito');
    }
}
