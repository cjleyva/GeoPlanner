<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use \Spatie\Permission\Models\Role;
use Carbon\Carbon;
use Illuminate\Support\Facades\Hash;

class userController extends Controller
{
    public function index()
    {
        $users = User::with('roles')->latest()->get();
        $roles = Role::all();
        return view('users.index', compact('users', 'roles'));
    }
    public function store(Request $request)
    {
        if (isset($request->id_usuario) && $request->id_usuario > 0) {
            if (isset($request->password) && !empty($request->password))
                $request->validate([
                    'name' => ['required', 'string', 'max:255'],
                    'email' => ['required', 'string', 'email', 'max:255'],
                    'password' => ['required', 'string', 'min:8'],
                ]);
            else {
                $request->validate([
                    'name' => ['required', 'string', 'max:255'],
                    'email' => ['required', 'string', 'email', 'max:255'],
                ]);
            }

            $usuario = user::find($request->id_usuario);
            $usuario->name = $request->name;
            $usuario->email = $request->email;
            if (isset($request->password) && !empty($request->password)) {
                $usuario->password = Hash::make($request->password);
            }   
            $usuario->syncRoles($request->rol);
            $usuario->save();
        } else {
            $request->validate([
                'name' => ['required', 'string', 'max:255'],
                'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
                'password' => ['required', 'string', 'min:8'],
            ]);
            $usuario = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ]);
            $usuario->assignRole($request->rol);
        }

        return back()->with('info', 'se ha guardado la información del usuario');
    }

    public function destroy(user $user)
    {
        $current_timestamp = Carbon::now()->timestamp;
        $user->email = $user->email . $current_timestamp;
        $user->save();
        $user->delete();

        return back()->with('info', 'se ha eliminado el usuario');
    }

    public function cambiarcontrasena()
    {
        return view('users.cambiarcontrasena');
    }

    public function cambiarcontrasenastore(request $request)
    {

        $user = auth()->user();
        if (!Hash::check($request->password, auth()->user()->password)) {
            return back()->with('error', 'la contraseña actual no es válida');
        }

        $request->validate([
            'password' => ['required', 'string', 'min:8'],
            'new_password' => ['required', 'string', 'min:8', 'confirmed'],
        ]);

        auth()->user()->update(['password' => Hash::make($request->new_password)]);
        auth()->user()->save();

        return back()->with('success', 'se ha cambiado la clave');

    }
}
