import 'package:book_cafe/main.dart';
import 'package:book_cafe/models/book.dart';
import 'package:book_cafe/models/table.dart';
import 'package:book_cafe/sceen/choosetime.dart';
import 'package:book_cafe/service/bookService.dart';
import 'package:book_cafe/service/tableService.dart';
import 'package:flutter/material.dart';

class MyTableCoffee extends StatefulWidget {
  final DateTime selectedDate;

  MyTableCoffee({required this.selectedDate, Key? key}) : super(key: key);
  @override
  _MyTableCoffeeState createState() => _MyTableCoffeeState();
}

class _MyTableCoffeeState extends State<MyTableCoffee> {
  final TableCoffeeService tableCoffeeService = TableCoffeeService();
  List<TableCoffee> tableCoffees = [];
  MyHomePage _homePage = MyHomePage(
    title: "hihi",
  );
  List<Book> bookingList = [];

  BookService bookService = BookService();
  TextEditingController nameCus = TextEditingController();
  TextEditingController phoneCus = TextEditingController();
  MyChooseTime choose = MyChooseTime();
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadTableCoffees();
  }

  Future<void> _loadTableCoffees() async {
    final tableCoffeesData = await tableCoffeeService.fetchTableCoffees();
    final selectedDateString = widget.selectedDate.toString().substring(0, 10);
    final filteredTableCoffees = tableCoffeesData.where((table) {
      final tableDateString = table..toString().substring(0, 10);
      return tableDateString == selectedDateString;
    }).toList();

    setState(() {
      tableCoffees = filteredTableCoffees;
    });
    setState(() {
      tableCoffees = tableCoffeesData;
    });
  }

  Future<void> _createNewBook(Book newBooking) async {
    try {
      final createdBooking = await bookService.createBooking(newBooking);
      final tableBook = tableCoffees.firstWhere(
        (tableCoffees) => tableCoffees.id == newBooking.tableId,
        orElse: (null),
      );
      if (!tableBook.isBook && tableBook.isBook != null) {
        tableBook.isBook = true;
      }

      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Đặt bàn thành công"),
          ),
        );
        nameCus.clear();
        phoneCus.clear();
        startTime = TimeOfDay(hour: 0, minute: 0);
        endTime = TimeOfDay(hour: 0, minute: 0);
        bookingList.add(createdBooking);
      });
    } catch (e) {
      print("Lỗi khi đặt bàn: $e");
      print(newBooking.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Lỗi khi đặt bàn."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          itemCount: tableCoffees.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (tableCoffees[index].isBook) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final bookingInfo = bookingList.firstWhere(
                        (booking) => booking.tableId == tableCoffees[index].id,
                        orElse: (null),
                      );

                      if (bookingInfo != null) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                    "Tên Khách Hàng : ${bookingInfo.customerName}")

                                // Column(
                                //   children: [
                                //
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Center();
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(children: [
                                Text(
                                  "Nhập Thông Tin",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Nhập Tên",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(10.0),
                                  ),
                                  controller: nameCus,
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "Nhập Số Điện Thoại",
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                    controller: phoneCus,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [MyChooseTime()],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    var newBooking = Book(
                                      tableId: tableCoffees[index].id,
                                      customerName: nameCus.text,
                                      customerPhone: phoneCus.text,
                                      startTime:
                                          choose.getStartTime().format(context),
                                      endTime:
                                          choose.getEndTime().format(context),
                                      bookingTime: _homePage.getDate(),
                                    );

                                    _createNewBook(newBooking);

                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Lưu"))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: Container(
                color: tableCoffees[index].isBook
                    ? Colors.red.shade100
                    : Colors.blue.shade100,
                child: Center(
                  child: Text(tableCoffees[index].tableName),
                ),
              ),
            );
          }),
    );
  }
}
