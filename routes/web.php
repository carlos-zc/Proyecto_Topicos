<?php

Auth::routes();

Route::get('/', function () {
    return view('welcome');
});

// Route::apiResources(['user' => 'API\UserController']);


Route::get('/home', 'HomeController@index')->name('home');

Route::get('/usuarios', 'API\UserController@viewUsers')->name('usuarios');

Route::get('/profile', 'API\UserController@viewProfile')->name('profile');

Route::get('/profiles', 'API\UserController@profile')->name('profiles');

Route::put('/profiles', 'API\UserController@updatePerfil')->name('profiles');

// Route::get('/users', 'API\UserController@index')->name('users');

// INMUEBLES
Route::get('/inmuebles-pers', 'API\InmuebleController@viewPersonal')->name('inmuebles-pers');

Route::get('/inmuebles', 'API\InmuebleController@viewGeneral')->name('inmuebles');

Route::Resources(['venta' => 'API\InmuebleController']);
// Route::post('/inmueble', 'API\InmuebleController@store')->name('inmueble');
