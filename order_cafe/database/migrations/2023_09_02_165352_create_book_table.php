<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBookTable extends Migration
{
    public function up()
    {
        Schema::create('book', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('table_id');
            $table->string('customer_name', 100);
            $table->string('customer_phone', 20);
            $table->string('start_time');
            $table->string('end_time');
            $table->date('booking_time');
            $table->timestamps();

            $table->foreign('table_id')->references('id')->on('table_coffee');
        });
    }

    public function down()
    {
        Schema::dropIfExists('book');
    }
}
