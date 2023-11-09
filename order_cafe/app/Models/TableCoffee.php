<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TableCoffee extends Model
{
    protected $table = 'table_coffee';

    protected $fillable = [
        'table_name', 'is_book', 'description',
    ];

    
}
