<?php

use Illuminate\Http\Request;

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResources(['user' => 'API\UserController']);

// Route::apiResources(['venta' => 'API\InmuebleController']);

Route::get('profile', 'API\UserController@profile');
Route::put('profile', 'API\UserController@updateProfile');