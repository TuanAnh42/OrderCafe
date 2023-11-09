class TableCoffee {
  final int id;
  final String tableName;
  bool isBook;
  final String description;

  TableCoffee({
    required this.id,
    required this.tableName,
    required this.isBook,
    required this.description,
  });

  factory TableCoffee.fromJson(Map<String, dynamic> json) {
    return TableCoffee(
      id: json['id'],
      tableName: json['table_name'],
      isBook: json['is_book'] == false,
      description: json['description'],
    );
  }
}
