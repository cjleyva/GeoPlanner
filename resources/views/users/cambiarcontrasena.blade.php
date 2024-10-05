@extends('layouts.app',
        $vars=[ 'breadcrum' => ['Administración','cambiar contraseña'],
                'title'=>'Cambiar contraseña',
                'activeMenu'=>'11' 
              ])

@section('content')
    <div class="row">
        <div class="col-12">
            <!-- general form elements disabled -->
            @can('administracion.usuarios.cambiarcontraseña')

            <div class="card card-primary shadow">
                <div class="card-header">
                    <h3 class="card-title">Cambiar contraseña</h3>
                </div>
                <!-- /.card-header -->
                <form role="form" method="POST"  action="{{route('usuarios.cambiar.contrasena.store')}}">
                    @csrf
                    @method('POST')

                    <div class="card-body">
                        
                        <div class="form-row">
                            <div class="col-md-4">
                              <!-- text input -->
                              <div class="form-group">
                                <label>Contraseña actual</label>
                                <input type="password" name="password" id="password"  class="form-control form-control-sm" placeholder="contraseña actual" >
                                <input type="hidden" name="id_usuario" id="id_usuario"  value="0" >
                              </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Nueva contraseña</label>
                                    <input type="password" name="new_password" id="new_password"  class="form-control form-control-sm" placeholder="nueva contraseña" >
                                    <input type="hidden" name="id_usuario" id="id_usuario"  value="0" >
                                      </div>
                                </div>
                        {{-- </div>
                        <div class="form-row"> --}}
                            <div class="col-md-4">
                              <!-- text input -->
                              <div class="form-group">
                                <label>Confirmar contraseña</label>
                                <input type="password" name="new_password_confirmation" id="new_password_confirmation"  class="form-control form-control-sm" placeholder="confirmar contraseña" >
                              </div>
                            </div>
                            <div class="col-md-3">
                            </div>
                        </div>
                    
                    </div>
                    <!-- /.card-body -->
                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary btn-sm" name="guardar" vuale="guardar" >Guardar</button>
                        <a href="{{ route('home') }}"  type="button" class="btn btn-primary float-right btn-sm"  name="cancelar" vuale="cancelar"  >Cancelar</a>
                    </div>
                </form>
            </div>
              <!-- /.card -->
            @endcan
            
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->

@endsection

@section('script')
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