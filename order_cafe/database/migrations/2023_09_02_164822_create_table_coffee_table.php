<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTableCoffeeTable extends Migration
{
    public function up()
    {
        Schema::create('table_coffee', function (Blueprint $table) {
            $table->id();
            $table->string('table_name', 20);
            $table->boolean('is_book');
            $table->string('description', 100)->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('table_coffee');
    }
}
