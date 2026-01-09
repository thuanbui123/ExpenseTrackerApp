import 'package:expense_tracker_app/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Transaction> transactions = [];

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void addTransaction(String title, double amount) {
    final newTx = Transaction(title: title, amount: amount, date: DateTime.now());
    setState(() {
      transactions.add(newTx);
    });
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTransaction(enteredTitle, enteredAmount);

    Navigator.of(context).pop();

    _titleController.clear();
    _amountController.clear();
  }

  static const List<Widget> _pages = [Center(child: Text('Trang chủ')), Center(child: Text('Thống kê')), Center(child: Text("Cài đặt"))];

  void showAddTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, top: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Thêm chi tiêu mới', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(labelText: "Tên khoản chi tiêu.(Ví dụ: Ăn sáng)titleController "),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Số tiền (VNĐ)'),
                controller: _amountController,
                keyboardType: TextInputType.number, // Hiện bàn phím số
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submitData, child: const Text('Lưu giao dịch')),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Xin chào,', style: TextStyle(color: Colors.grey, fontSize: 14)),
            Text(
              'Thuân Bùi',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: transactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet_outlined, size: 100, color: Colors.grey[300]),
                  const SizedBox(height: 20),
                  const Text(
                    'Chưa có giao dịch nào',
                    style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  const Text('Hãy nhấn nút + để thêm chi tiêu đầu tiên!', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: const Icon(Icons.attach_money, color: Colors.white),
                    ),
                    title: Text(transactions[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(transactions[index].date.toString()),
                    trailing: Text(
                      '${transactions[index].amount}đ',
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.greenAccent[700], // Màu khi được chọn
        unselectedItemColor: Colors.grey, // Màu khi không chọn
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Thống kê'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.greenAccent),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 30, backgroundColor: Colors.white, backgroundImage: NetworkImage('https://wp-cms-media.s3.ap-east-1.amazonaws.com/lay_anh_dai_dien_facebook_dep_1_2967d609e0.jpg')),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Thuân Bùi',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                          ),
                          Text('thuan.bui@email.com', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(leading: const Icon(Icons.home), title: const Text('Trang chủ'), onTap: () => Navigator.pop(context)),
            ListTile(leading: const Icon(Icons.history), title: const Text('Lịch sử giao dịch'), onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskModal(context);
        },
        tooltip: 'Thêm giao dịch',
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
