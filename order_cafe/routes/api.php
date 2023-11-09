<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BookController;
use App\Http\Controllers\TableCoffeeController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});



// Lấy tất cả dữ liệu từ bảng table_coffee
// Route::group(['prefix' => 'api', 'as' => 'api.', 'middleware' => ['cors', 'validate_api_token']], function () {
//     Route::post('table-coffees', 'ApiController@getAllTableCoffees');
// });
// Route::group(['prefix' => 'api', 'as' => 'api.', 'middleware' => ['cors', 'validate_api_token']], function () {
//     Route::post('books', 'ApiController@createBook');
// });

// Routes cho bảng table_coffee
Route::get('table-coffees', [TableCoffeeController::class, 'getAllTableCoffees']);
Route::post('table-coffees', [TableCoffeeController::class, 'createTableCoffee']);
Route::put('table-coffees/{id}', [TableCoffeeController::class, 'updateTableCoffee']);

// Routes cho bảng book
Route::get('books', [BookController::class, 'getAllBooks']);
Route::post('books', [BookController::class, 'createBook']);



