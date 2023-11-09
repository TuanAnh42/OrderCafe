<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    protected $table = 'book';

    protected $fillable = [
        'table_id', 'customer_name', 'customer_phone', 'start_time', 'end_time', 'booking_time',
    ];

    // Định nghĩa quan hệ với bảng TableCoffee
    public function tableCoffee()
    {
        return $this->belongsTo(TableCoffee::class, 'table_id');
    }
}

