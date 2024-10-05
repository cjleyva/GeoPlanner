@extends('layouts.app', $vars = ['breadcrum' => ['Editar Geo Localización'], 'title' => 'Geo Localización', 'activeMenu' => '0'])
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
                                    <label for="fecha_solicitud">{!! trans('Elaborada por') !!}</label>
                                    <input type="text" class="form-control form-control-sm" name="id" id="" value="{{ Auth::user()->name }}" disabled>
                                        <input type="hidden" class="form-control form-control-sm" name="id_usuario" id="id_user" value="{{ Auth::user()->id }}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="fecha_solicitud">{!! trans('Fecha de creación') !!}</label>
                                    <input type="date" class="form-control form-control-sm" name="fecha" id="" value="{{$data->fecha}}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="tipo_documento">{!! trans('Longitud') !!}</label>
                                    <input type="text" class="form-control form-control-sm" name="longitud" id="longitud" value="{{$data->longitud}}" style="text-align: right">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="numero_documento">{!! trans('Latitud') !!}</label>
                                    <input type="text" class="form-control form-control-sm" name="latitud" id="latitud" value="{{$data->latitud}}" style="text-align: right">
                                </div>
                        </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <label for="descripcion">{!! trans('Observaciones') !!}</label>
                                    <textarea class="form-control form-control-sm" name="observaciones" id="observaciones" cols="30" rows="3">{{$data->observaciones}}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <input type="hidden" name="id" value="{{$data->id}}">
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
@section('scripts')
    <script type="text/javascript">
            var idProductos = new Array();

            function llenarTablaProductos() {
                var total = $("#addProducto").attr('data-count');
                total++;
                var cell = `
                    <tr>
                        <td class="border">
                            <select class="form-control form-control-sm select2" id="id_producto_` + total +`" name="id_producto[]" onchange="dataProducto(` + total +`)" required>
                            </select>
                        </td>
                        <td class="border">
                            <input class="form-control form-control-sm" type="number" style="text-align: center;" min="0" step=".01" name="cantidad[]" id="cantidad_` + total +`" value="" onchange="calcularPrecio(` + total +`)" required>
                        </td>
                        <td class="border">
                            <input type="number" class="form-control form-control-sm" name="precio_unit[]" step="0.01" min="0"  value='0' id="precio_unit_` + total +`" style="text-align: right;" onchange="calcularPrecio(` + total + `)" required>
                        </td>
                        <td class="border">
                            <input type="number" name="subT[]" id="subT_` + total + `" min="0" style="text-align: right;" class="form-control form-control-sm" readonly>
                        </td>
                        <td class="border">
                            <button type="button" class="btn btn-danger btn-xs  delete-cell" onclick="deletesCell(this,)">Eliminar</button>
                        </td>
                    </tr>
                    `;

                $("#addProducto").attr('data-count', total);
                $("#tblProductos tbody").append(cell);
                $('.select2').select2();
            }
    </script>
@endsection
