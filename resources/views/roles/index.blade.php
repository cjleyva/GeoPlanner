@extends('layouts.app',
$vars=[ 'breadcrum' => ['Administración','Roles'],
'title'=>'Roles',
'activeMenu'=>'6'
])

@section('content')
<div class="row">
    <div class="col-12">
        <!-- general form elements disabled -->
        @can('administracion.roles.crear')
        <div class="card card-primary shadow">
            <div class="card-header">
                <h3 class="card-title">Crear rol</h3>
            </div>
            <!-- /.card-header -->
            <form role="form" method="POST" action="{{route('roles.store')}}">
                @csrf
                <div class="card-body">
                    <div class="form-row">
                        <div class="col-sm-6">
                            <!-- text input -->
                            <div class="form-group">
                                <label>Nombre del rol</label>
                                <input type="text" name="name" id="name" class="form-control form-control-sm" placeholder="Enter ...">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <input type="hidden" name="id" id="id" class="form-control form-control-sm" value="0">
                        </div>
                    </div>

                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary btn-sm" name="guardar" vuale="guardar">Guardar</button>
                    <a href="{{ route('roles.index') }}" type="button" class="btn btn-primary float-right btn-sm" name="cancelar" vuale="cancelar">Cancelar</a>
                </div>
            </form>
        </div>
        <!-- /.card -->
        @endcan
        <div class="card card-primary  shadow">
            <div class="card-header">
                <h3 class="card-title">Lista de roles</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <table id="tabledata1" class="table table-bordered table-striped">
                    <thead class="thead-light">
                        <tr>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @if($roles)
                            @foreach ($roles as $rol)
                                <tr>
                                    <td>{{$rol["name"]}}</td>
                                    <td>
                                        <div class="row">
                                            <div class="col">
                                                @can('administracion.roles.permisos')
                                                <a href="{{ route('roles.permision',$rol) }}" type="button" class="btn btn-sm btn-primary" name="permisos" vuale="permisos">Permisos</a>
                                                @endcan
                                            </div>
                                            <div class="col">
                                                @can('administracion.roles.eliminar')
                                                <form action="{{ route('roles.destroy',$rol)}}" method="POST">
                                                    @method('DELETE')
                                                    @csrf
                                                    <input type="submit" value="Eliminar" class="btn btn-sm btn-danger" onclick="return confirm('¿Desea eliminar el registro?')">
                                                </form>
                                                @endcan
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            @endforeach
                        @endif
                    </tbody>
                </table>
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
    </div>
    <!-- /.col -->
</div>
<!-- /.row -->
@endsection
