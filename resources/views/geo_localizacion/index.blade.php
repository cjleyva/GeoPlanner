@extends('layouts.app',
        $vars=[ 'breadcrum' => ['Geo Localización'],
                'title'=>'Geo Localización',
                'activeMenu'=>'0'
              ])
@section('title', 'Geo Localización')

@section('content')
        <div class="row">
            <div class="col-12">
                <div class="card card-primary shadow">
                    <div class="card-header">
                        <h3 class="card-title">Agregar Geo Localización</h3>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                        @can('geo_localizacion.crear')
                        <a href="{{route('geo_localizacion.create')}}" type="button" class="btn  btn-primary btn-sm" value=""><i class="fas fa-plus-circle"></i>&nbsp;Crear Geo Localización</a>
                        @endcan
                    </div>
                </div>
                        <div class="card card-primary shadow"> 
                        <div class="card-header">
                            <h3 class="card-title">Lista Geo Localización</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="tabledata1" class="table table-bordered" width='100%'>
                                    <thead class="thead-light">
                                        <tr>
                                            <th class="text-white">{!! trans('ID') !!}</th>
                                            <th class="text-white">{!! trans('Fecha de creacion') !!}</th>
                                            <th class="text-white">{!! trans('longitud') !!}</th>
                                            <th class="text-white">{!! trans('Latitud') !!}</th>
                                            <th class="text-white">{!! trans('Acciones') !!}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($data as $item)
                                        <tr>
                                            <td>{{$item->id}}</td>
                                            <td>{{$item->fecha}}</td>
                                            <td>{{$item->longitud}}</td>
                                            <td>{{$item->latitud}}</td>
                                            <td nowrap>
                                                <div class="row flex-nowrap">
                                                    @can('geo_localizacion.editar')
                                                    <div class="col">
                                                        <a href="{{route('geo_localizacion.edit',$item->id)}}" class="btn btn-primary btn-xs"></i> {!!trans('Editar') !!}</a>
                                                    </div>
                                                    @endcan
                                                    @can('geo_localizacion.eliminar')
                                                    <div class="col">
                                                        <a href="{{route('geo_localizacion.delete',$item->id)}}" class="btn btn-danger btn-xs" onclick="return confirm('{!! trans('Desea eliminar este registro') !!}?');"></i> {!! trans('Eliminar')!!}</a>
                                                    </div>
                                                    @endcan
                                                </div>
                                            </td>
                                        </tr>
                                            
                                        @endforeach
                                        
                                    </tbody>
                                </table>
                            </div>
                    </div>
                </div>
            </div>
        </div>
@endsection
