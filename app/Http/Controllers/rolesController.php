<?php

namespace App\Http\Controllers;

use Session;
use Illuminate\Http\Request;
use \Spatie\Permission\Models\Role;
use \Spatie\Permission\Models\Permission;


class rolesController extends Controller
{
    //   function __construct() {

    //   } 

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $roles = Role::all();
        $users = \App\User::with('roles')->get();
        return view('roles.index', compact('roles'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        $request->validate([
            'name' => 'required|unique:roles|max:100',
        ]);


        $role = Role::create(['name' => $request->name]);

        $roles = Role::all();
        //return view('roles.index', compact('roles'))->withback();

        $request->session()->flash('info', 'Registro guardado con éxito');

        if (isset($errors)) {
            return back()->withInput();; //->with('msg', 'The Message');
        } else {
            return back(); //->withSuccess('Registro guardado');
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Role $role)
    {
        $role->delete();
        return back()->with('info', 'Se ha eliminado el registro');
    }

    public function permisosindex($role)
    {

        $rol = Role::find($role);
        $permisos_rol = $rol->Permissions->pluck('name')->toArray();
        $permisos = Permission::all();
        return view('roles.permisos', compact('rol', 'permisos_rol', 'permisos'));
    }

    public function permisosstore(Request $request)
    {

        $rol = Role::find($request->roleid);
        $permisos_no_rol =  Permission::all();
        foreach ($permisos_no_rol  as $permiso_no_rol) {
            $rol->revokePermissionTo($permiso_no_rol);
        }
        foreach ($request->permision as $permiso) {
            $rol->givePermissionTo($permiso);
        }

        $permisos_rol = $rol->permissions->all();

        return back()->with('info', 'Se han asignado los permisos');

    }
}
