@extends('layouts.app')

@section('content')
<style type="text/css">
    body{padding-top:30px;}

    .glyphicon {  margin-bottom: 10px;margin-right: 10px;}

    small {
    display: block;
    line-height: 1.428571429;
    color: #999;
    }
</style>

<div class="container">
    <profile-component></profile-component>
</div><!-- Termina perfil -->
@endsection
