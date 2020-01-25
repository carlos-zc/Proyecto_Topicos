<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Inmueble;

class InmuebleController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function viewPersonal()
    {
        return view('inmuebles/personal');
    }

    public function viewGeneral()
    {
        return view('inmuebles/general');
    }

    public function index()
    {
        $ventas = Inmueble::where('user_id', auth()->id())->orderBy('id', 'DESC')->paginate(3);
        
        return [
            'pagination'=> [
                'total'            => $ventas->total(),
                'current_page'     => $ventas->currentPage(),
                'per_page'         => $ventas->perPage(),
                'last_page'        => $ventas->lastPage(),
                'from'             => $ventas->firstItem(),
                'to'               => $ventas->lastPage(),
            ],
            'ventas' => $ventas
        ];
    }

    public function create()
    {
        $ventas = Inmueble::orderBy('id', 'DESC')->paginate(3);
        
        return [
            'pagination'=> [
                'total'            => $ventas->total(),
                'current_page'     => $ventas->currentPage(),
                'per_page'         => $ventas->perPage(),
                'last_page'        => $ventas->lastPage(),
                'from'             => $ventas->firstItem(),
                'to'               => $ventas->lastPage(),
            ],
            'ventas' => $ventas
        ];
    }

    public function store(Request $request)
    {
        $user = Auth::user();
        $venta = new Inmueble();
        $venta->nombre = $request->nombre;
        $venta->tipo = $request->tipo;
        $venta->precio = $request->precio;
        $venta->descripcion = $request->descripcion;
        $venta->municipio = $request->municipio;
        $venta->user_id = auth()->id();
        $venta->user_name = $user->name;

        if($request->foto != null){
            // $image = explode(';', explode('/', $request->foto)[1])[0];
            $name = time().'.'.explode('/',explode(':',substr($request->foto, 0, strpos($request->foto, ';'))) [1]) [1];

            \Image::make($request->foto)->save(public_path('img/inmueble/').$name);
            $request->merge(['foto' => $name]);

            $venta->foto = $request->foto;
        }

        $venta->save();

        return $venta;
    }

    public function show($id)
    {
        $user = User::findOrFail($id);
        return $user->name;
    }

    public function edit($id)
    {
        //
    }

    public function update(Request $request, $id)
    {
        $venta = Inmueble::findOrFail($id);
        $venta->nombre = $request->nombre;
        $venta->tipo = $request->tipo;
        $venta->precio = $request->precio;
        $venta->descripcion = $request->descripcion;
        $venta->municipio = $request->municipio;

        $currentPhoto = $venta->foto;

        if($request->foto != $currentPhoto){
            // $image = explode(';', explode('/', $request->foto)[1])[0];
            $name = time().'.'.explode('/',explode(':',substr($request->foto, 0, strpos($request->foto, ';'))) [1]) [1];

            \Image::make($request->foto)->save(public_path('img/inmueble/').$name);
            $request->merge(['foto' => $name]);

            $ventaPhoto = public_path('img/inmueble/').$currentPhoto;
            if(file_exists($ventaPhoto) && $ventaPhoto != public_path('img/inmueble/ejemplo.png')){
                @unlink($ventaPhoto);
            }

            $venta->foto = $request->foto;
        }

        $venta->save();
        return $venta;
    }

    public function destroy($id)
    {
        $venta = Inmueble::findOrFail($id);
        $currentPhoto = $venta->foto;
        $ventaPhoto = public_path('img/inmueble/').$currentPhoto;
        if(file_exists($ventaPhoto) && $ventaPhoto != public_path('img/inmueble/ejemplo.png')){
            @unlink($ventaPhoto);
        }

        $venta->delete();
    }

    public function viewCharts()
    {
        return view('inmuebles/charts');
    }

}


