@extends('layouts.app')

@section('content')

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">NOMBRE</th>
      <th scope="col">EMAIL</th>
    </tr>
  </thead>
  <tbody>
  @foreach($users as $user)
    <tr>
      <th scope="row">{{$user->id}}</th>
      <td>{{$user->nombre}}</td>
      <td>{{$user->email}}</td>
    </tr>
    @endforeach
  </tbody>
</table>

@endsection