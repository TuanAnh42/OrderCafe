import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:book_cafe/models/table.dart';

class TableCoffeeService {
  Future<List<TableCoffee>> fetchTableCoffees() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/table-coffees'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => TableCoffee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
