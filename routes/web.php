<?php

use Spatie\Permission\Models\Permission;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Auth;

// Route::get('/', function () {

//  return view('welcome');
// });


Auth::routes();

Route::get('/', 'HomeController@index')->name('home');
Route::get('/logout', 'HomeController@index')->name('home');
Route::get('/home', 'HomeController@index')->name('home');

Route::group(['prefix' => 'sistema', 'middleware' => 'auth'],function(){

    Route::get('/', 'HomeController@index')->name('home');

    ////// Roles ///
    Route::get('roles', 'rolesController@index')->name('roles.index');
    Route::post('roles/create', 'rolesController@store')->name('roles.store');
    Route::delete('roles/{role}/destroy', 'rolesController@destroy')->name('roles.destroy');
    Route::get('roles/{idrole}/permision', 'rolesController@permisosindex')->name('roles.permision');
    Route::post('roles/permision/create', 'rolesController@permisosstore')->name('roles.pemision.store');

    ////// Usuarios ///
    Route::get('users', 'userController@index')->name('usuarios.index');
    Route::post('users/create', 'userController@store')->name('usuarios.store');
    Route::delete('users/{user}/destroy', 'userController@destroy')->name('usuarios.destroy');

    ////// Cambiar contraseña ///
    Route::get('users/cambiarcontrasena', 'userController@cambiarcontrasena')->name('usuarios.cambiar.contrasena');
    Route::post('users/cambiarcontrasenastore', 'userController@cambiarcontrasenastore')->name('usuarios.cambiar.contrasena.store');

   ////// Geo Localizacion ///
   Route::get('geo_localizacion/index','GeoLocalizacionController@index')->name('geo_localizacion.index')->middleware('can:geo_localizacion.index');
   Route::get('geo_localizacion/crear','GeoLocalizacionController@create')->name('geo_localizacion.create')->middleware('can:geo_localizacion.crear');
   Route::post('geo_localizacion/store','GeoLocalizacionController@store')->name('geo_localizacion.store')->middleware('can:geo_localizacion.crear');
   Route::get('geo_localizacion/editar/{id}','GeoLocalizacionController@edit')->name('geo_localizacion.edit')->middleware('can:geo_localizacion.editar');
   Route::get('geo_localizacion/eliminar/{id}','GeoLocalizacionController@delete')->name('geo_localizacion.delete')->middleware('can:geo_localizacion.eliminar');
   
   
   ///////// rps ///
   Route::get('/rpa-coordinates','RpaCoordinateController@getRpaCoordinates')->name('getRpaCoordinates');//->middleware('can:geo_localizacion.index');

   Route::get('/rpa-coordinates', [TuControlador::class, 'getRpaCoordinates']);

    ////////////////Permisos////////////////////
    Route::get('/clearcache', function () {
        Artisan::call('cache:clear');
        Artisan::call('config:clear');
        Artisan::call('route:clear');
        Artisan::call('view:clear');
        return '<h1>se ha borrado el cache</h1>';
    });

    Route::get('/crearpermisos', function () {
       Permission::create(['name' =>  'geo_localizacion']);
       Permission::create(['name' =>  'geo_localizacion.index']);
       Permission::create(['name' =>  'geo_localizacion.crear']);
       Permission::create(['name' =>  'geo_localizacion.editar']);
       Permission::create(['name' =>  'geo_localizacion.eliminar']);

       return '<h1>se han creado los permisos</h1>';
    });


});



