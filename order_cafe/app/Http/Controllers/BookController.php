<?php
namespace App\Http\Controllers;

use App\Models\Book;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class BookController extends Controller
{
    // Lấy tất cả dữ liệu từ bảng book
    public function getAllBooks()
    {
        $books = Book::all();
        return response()->json($books);
    }

    // Thêm một bản ghi mới vào bảng book
    public function createBook(Request $request)
    {
        $validatedData = $request->validate([
            'table_id' => 'required|exists:table_coffee,id',
            'customer_name' => 'required|string|max:100',
            'customer_phone' => 'required|string|max:20',
            'start_time' => 'required|string|max:50',
            'end_time' => 'required|string|max:50',
            'booking_time' => 'required|date',
        ]);

        $book = Book::create($validatedData);
        return response()->json($book, 201);
    }
}
