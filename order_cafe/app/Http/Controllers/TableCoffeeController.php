<?php

namespace App\Http\Controllers;

use App\Models\TableCoffee;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class TableCoffeeController extends Controller
{
    // Lấy tất cả dữ liệu từ bảng table_coffee
    public function getAllTableCoffees()
    {
        $coffees = TableCoffee::all();
        return response()->json($coffees);
    }

    // Thêm một bản ghi mới vào bảng table_coffee
    public function createTableCoffee(Request $request)
    {
        $validatedData = $request->validate([
            'table_name' => 'required|string',
            'is_book' => 'required|boolean',
            'description' => 'nullable|string|max:100',
        ]);

        $coffee = TableCoffee::create($validatedData);
        return response()->json($coffee, 201);
    }
    public function updateTableCoffee(Request $request, $id)
{
    // Kiểm tra xem bàn có tồn tại không
    $coffee = TableCoffee::find($id);

    if (!$coffee) {
        return response()->json(['message' => 'Bàn không tồn tại'], 404);
    }

    $validatedData = $request->validate([
        'is_book' => 'required|boolean',
    ]);

    // Cập nhật trạng thái is_book của bàn
    $coffee->is_book = $validatedData['is_book'];
    $coffee->save();

    return response()->json($coffee, 200);
}

}
