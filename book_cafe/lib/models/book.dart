import 'package:intl/intl.dart';

class Book {
  int tableId;
  String customerName;
  String customerPhone;
  String startTime;
  String endTime;
  DateTime bookingTime;

  Book({
    required this.tableId,
    required this.customerName,
    required this.customerPhone,
    required this.startTime,
    required this.endTime,
    required this.bookingTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'table_id': tableId,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'start_time': startTime,
      'end_time': endTime,
      'booking_time': DateFormat("yyyy-MM-dd").format(bookingTime.toLocal()),
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      tableId: json['table_id'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      bookingTime: DateTime.parse(json['booking_time']),
    );
  }
}
