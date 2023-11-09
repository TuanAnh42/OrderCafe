import 'package:book_cafe/sceen/choosetime.dart';
import 'package:book_cafe/sceen/table_coffe.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Order Coffee'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  DateTime getDate() {
    return _MyHomePageState.selectDatetime;
  }

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static DateTime selectDatetime = DateTime.now();

  String formattedDate = DateFormat("yyyy-MM-dd").format(selectDatetime);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(formattedDate),
      firstDate: DateTime(2020),
      lastDate: DateTime(2120),
    );
    if (picked != null && picked != selectDatetime) {
      setState(() {
        selectDatetime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coffee"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text("${selectDatetime.toLocal()}".split(" ")[0]),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [MyChooseTime()],
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Spacer(),
              Row(
                children: [
                  Text(
                    "Chưa đặt",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 60,
                    height: 20,
                    color: Colors.blue.shade100,
                  ),
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  Text(
                    "Đã đặt",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(width: 60, height: 20, color: Colors.red.shade100),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: MyTableCoffee(
                selectedDate: selectDatetime), // Truyền ngày đã chọn
          ),
        ],
      ),
    );
  }
}
