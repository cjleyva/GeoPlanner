@extends('layouts.app', $vars = ['breadcrum' => ['Crear Geo Localización'], 'title' => 'Geo Localización', 'activeMenu' => '0'])
@section('title', 'Geo Localización')
@section('css')
    <link rel="stylesheet" href="{{ asset('dist/css/estilos_pedidos.css') }}">
@endsection
@section('content')
    <div class="container">
        <div class="row justify-content-center align-items-center">
            <div class="col-12">
                <div class="card card-primary shadow">
                    <div class="card-header">
                        <h3 class="card-title">Geo Localización</h3>
                    </div>
                    <form method="POST" action="{{route('geo_localizacion.store')}}">
                        @csrf
                        <div class="card-body">
                            <div class="row">
                                <div class="form-group col-md-3">
                                    <label for="id_usuario">{!! trans('Elaborada por') !!}</label>
                                    <input type="text" class="form-control form-control-sm" name="id" id="" value="{{ Auth::user()->name }}" disabled>
                                        <input type="hidden" class="form-control form-control-sm" name="id_usuario" id="id_user" value="{{ Auth::user()->id }}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="fecha">{!! trans('Fecha de creación') !!}</label>
                                    <input type="date" class="form-control form-control-sm" name="fecha" id="" value="{{ $fecha }}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="latitud">{!! trans('Latitud') !!}</label>
                                    <input type="text" class="form-control form-control-sm" name="latitud" id="latitud" value="" style="text-align: right" maxlength="10">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="longitud">{!! trans('Longitud') !!}</label>
                                    <input type="text" class="form-control form-control-sm" name="longitud" id="longitud" value="" style="text-align: right" maxlength="10">
                                </div>
                        </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <label for="descripcion">{!! trans('Observaciones') !!}</label>
                                    <textarea class="form-control form-control-sm" name="observaciones" id="observaciones" cols="30" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <button type="submit" id="guardar" name="guardar" value="" class="btn btn-primary btn-sm float-center">{!! trans('Guardar') !!}</button>
                                    <a href="{{ route('geo_localizacion.index') }}" class="btn btn-primary btn-sm float-right">{!! trans('Regresar') !!}</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection


