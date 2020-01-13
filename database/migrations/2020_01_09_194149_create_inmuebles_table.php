<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateInmueblesTable extends Migration
{
    public function up()
    {
        Schema::create('inmuebles', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('nombre');
            $table->string('tipo');
            $table->double('precio');
            $table->text('descripcion')->nullable();
            $table->string('municipio');
            $table->string('foto')->default('ejemplo.png');
            $table->bigInteger('user_id')->unsigned();
<<<<<<< HEAD
            $table->string('user_name');
=======
>>>>>>> 48efbcfd856c058c337daa441ba9b082619376f6
            $table->foreign('user_id')->references('id')->on('users');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('inmuebles');
    }
}
