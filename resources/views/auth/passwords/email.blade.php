@extends('layouts.app_nologin')
@section('content')
<div class="container">
  <div class="row">
    <div class="col-lg-12">
      <div class="login-logo">
        <a href="../../index.html"><img src="/dist/img/logo_geo.png" alt="IMJ Logo" width="200"></a>
      </div>
      <!-- /.login-logo -->
    </div>
    <div class="col-lg-12 login-forma">
      <div class="card">
        <div class="card-body login-card-body">
          <p class="login-box-msg">Ingrese su correo electrónico</p>
          @if (session('status'))
          <div class="alert alert-success" role="alert">
            {{ session('status') }}
          </div>
          @endif
          <form method="POST" action="{{ route('password.email') }}">
            @csrf
            <div class="input-group mb-3">
              <input type="email" class="form-control form-control-sm @error('email') is-invalid @enderror" placeholder="Correo electrónico" id="email" name="email" required autocomplete="email" autofocus>
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-envelope"></span>
                </div>
              </div>
              @error('email')
              <span class="invalid-feedback" role="alert">
                <strong>{{ $message }}</strong>
              </span>
              @enderror
            </div>
            <div class="row">
              <!-- /.col -->
              <div class="col">
                <button type="submit" class="btn btn-primary btn-sm btn-block">Enviar link de cambio de clave</button>
              </div>
              <!-- /.col -->
            </div>
          </form>
        </div>
        <!-- /.login-card-body -->
      </div><!-- /.card -->
    </div>
    <!--login-forma-->
  </div>
  <!--row-->
</div>
<!--container-->

@endsection