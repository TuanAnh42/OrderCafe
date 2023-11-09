import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:book_cafe/models/book.dart';

class BookService {
  final String apiUrl = "http://localhost:8000/api/books";

  Future<List<Book>> fetchBook() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final books = jsonData.map((json) => Book.fromJson(json)).toList();

      // Ghi dữ liệu vào Firestore
      final firestore = FirebaseFirestore.instance;
      final batch = firestore.batch();
      final collection = firestore.collection('books');

      for (var book in books) {
        batch.set(collection.doc(), book.toJson());
      }

      await batch.commit();

      return books;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Book> createBooking(Book newBooking) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newBooking.toJson()),
    );
    print(response.body);

    if (response.statusCode == 201) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      print('${response.statusCode}');

      throw Exception('Failed to create book');
    }
  }
}
