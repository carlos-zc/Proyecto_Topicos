<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
// use Image;
use Intervention\Image\ImageManagerStatic as Image;

class UserController extends Controller
{
    // public function __construct()
    // {
    //     $this->middleware('auth');
    // }

    public function profile()
    {
        return Auth::user();
    }

    public function viewProfile()
    {
        return view('profile');
    }

    public function index(Request $request)
    {
        // $usuarios = User::latest()->paginate(3);
        $usuarios = User::orderBy('id', 'DESC')->paginate(3);
        
        return [
            'pagination'=> [
                'total'            => $usuarios->total(),
                'current_page'     => $usuarios->currentPage(),
                'per_page'         => $usuarios->perPage(),
                'last_page'        => $usuarios->lastPage(),
                'from'             => $usuarios->firstItem(),
                'to'               => $usuarios->lastPage(),
            ],
            'usuarios' => $usuarios
        ];
    }

    public function viewUsers()
    {
        return view('usuarios');
    }

    public function updatePerfil(Request $request)
    {
        $user = Auth::user();
        $currentPhoto = $user->photo;

        $this->validate($request, [
            'name' => 'required|string|max:100',
            'email' => 'required|string|email|max:255|unique:users,email,'.$user->id,
            'ci' => 'string|max:8',
            'password' => 'string|min:8',
        ]);

        if($request->photo != $currentPhoto){
            // $image = explode(';', explode('/', $request->photo)[1])[0];
            $name = time().'.'.explode('/',explode(':',substr($request->photo, 0, strpos($request->photo, ';'))) [1]) [1];

            \Image::make($request->photo)->save(public_path('img/profile/').$name);
            $request->merge(['photo' => $name]);

            $userPhoto = public_path('img/profile/').$currentPhoto;
            if(file_exists($userPhoto) && $userPhoto != public_path('img/profile/perfil.png')){
                @unlink($userPhoto);
            }
        }
        
        $user->city = request('city');
        $user->state = request('state');
        $user->ci = request('ci');
        $user->birth = request('birth');
        $user->photo = request('photo');

        if(!empty($request->clave)){
            $user->password = Hash::make($request['clave']);
        }

        $user->update($request->all());
        return ['mensaje' => "Cargado"];
    }

    
    public function show($id)
    {
        // $user = User::findOrFail($id);
        // return $user->active;
    }

    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);

        // Cambiar estado activo del usuario
        $user->active = request('active');

        $user->save();

        return ['mensaje' => 'Estado actualizado'];
    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);
        $currentPhoto = $user->photo;
        $userPhoto = public_path('img/profile/').$currentPhoto;
        if(file_exists($userPhoto) && $userPhoto != public_path('img/profile/perfil.png')){
            @unlink($userPhoto);
        }

        // Borrar usuario
        $user->delete();

        return ['mensaje' => 'Usuario eliminado'];
    }
}
