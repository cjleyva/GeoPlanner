@extends('layouts.app',
        $vars=[ 'breadcrum' => ['Administración','Usuarios'],
                'title'=>'Usuarios',
                'activeMenu'=>'5'
              ])

@section('content')


    <div class="row">
        <div class="col-12">
            <!-- general form elements disabled -->
            @can('administracion.usuarios.crear')

            <div class="card card-primary shadow">
                <div class="card-header">
                    <h3 class="card-title">Crear usuario</h3>
                </div>
                <!-- /.card-header -->
                <form role="form" method="POST"  action="{{route('usuarios.store')}}">
                    @csrf
                    <div class="card-body">
                        <div class="form-row">
                            <div class="col-md-3">
                              <!-- text input -->
                              <div class="form-group">
                                <label>Nombre del usuario</label>
                                <input type="text" name="name" id="name"  class="form-control form-control-sm" placeholder="Nombre" >
                                <input type="hidden" name="id_usuario" id="id_usuario"  value="0" >
                              </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Correo</label>
                                    <input type="email" name="email" id="email"  class="form-control form-control-sm" placeholder="correo@host.com" >
                                  </div>
                                </div>
                            <div class="col-md-3">
                              <!-- text input -->
                              <div class="form-group">
                                <label>Contraseña</label>
                                <input type="text" name="password" id="password"  class="form-control form-control-sm" placeholder="contraseña" >
                              </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Rol</label>
                                    <select id='rol' name='rol'   class="form-control form-control-sm" >
                                        <option value="0" ></option>
                                        @foreach($roles as $rol)
                                            <option value="{{$rol['name']}}">{{$rol['name']}}</option>
                                        @endforeach
                                    </select>
                                  </div>
                                </div>
                        </div>
                    </div>
                    <!-- /.card-body -->
                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary btn-sm" name="guardar" vuale="guardar" >Guardar</button>
                        <a href="{{ route('roles.index') }}"  type="button" class="btn btn-sm btn-primary float-right"  name="cancelar" vuale="cancelar"  >Cancelar</a>
                    </div>
                </form>
            </div>
              <!-- /.card -->
            @endcan
            <div class="card card-primary  shadow">
                <div class="card-header">
                    <h3 class="card-title">Lista de usuarios</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <table id="tabledata1" class="table table-bordered table-striped">
                        <thead class="thead-light">
                        <tr>
                            <th>Nombre</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>

                        @if($users)
                            @foreach ($users as $user)
                            <tr>
                                <td>{{$user["name"]}}</td>
                                <td>{{$user["email"]}}</td>

                                <td> {{ $user->roles[0]['name'] ?? '' }}</td>
                                <td>
                                    <div class="row">

                                        @can('administracion.usuarios.editar')
                                        <div class="col">
                                            <input type="button" value="Editar" class="btn btn-sm btn-primary"
                                                onclick="editar({{$user['id']}})">
                                            <input type="hidden" id="ed_id_usuario_{{$user['id']}}" value="{{$user['id']}}">
                                            <input type="hidden" id="ed_name_{{$user['id']}}" value="{{$user['name']}}">
                                            <input type="hidden" id="ed_email_{{$user['id']}}" value="{{$user['email']}}">
                                            <input type="hidden" id="ed_rol_{{$user['id']}}" value="{{ $user->roles[0]['name'] ?? '' }}">
                                        </div>
                                        @endcan
                                        @can('administracion.usuarios.eliminar')
                                        <div class="col" >
                                            <form action="{{ route('usuarios.destroy',$user)}}" method="POST">
                                            @method('DELETE')
                                            @csrf
                                            <input type="submit" value="Eliminar" class="btn btn-sm btn-danger" onclick="return confirm('¿Desea eliminar el registro?')">
                                            </form>
                                        </div>
                                        @endcan
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

@section('scripts')
<script>
function editar(id)
{

    //alert("Hola Editar "+id);
    v_name= $('#ed_name_'+id).val();
    v_email= $('#ed_email_'+id).val();
    v_id_usuario= $('#ed_id_usuario_'+id).val();
    v_rol= $('#ed_rol_'+id).val();

    $('#name').val(v_name);
    $('#id_usuario').val(v_id_usuario);
    $('#email').val(v_email);
    $('#rol').val(v_rol);

}
</script>



@endsection
