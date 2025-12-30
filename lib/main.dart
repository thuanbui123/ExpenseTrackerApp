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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    Center(child: Text('Trang chủ')),
    Center(child: Text('Thống kê')),
    Center(child: Text("Cài đặt")),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: CircleAvatar(
        //     backgroundColor: Colors.purple[100],
        //     backgroundImage: NetworkImage('https://wp-cms-media.s3.ap-east-1.amazonaws.com/lay_anh_dai_dien_facebook_dep_1_2967d609e0.jpg'),
        //   ),
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Xin chào,', style: TextStyle(color: Colors.grey, fontSize: 14)),
            Text('Thuân Bùi', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black,)
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 20,),
            const Text(
              'Chưa có giao dịch nào',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 10,),
            const Text(
              'Hãy nhấn nút + để thêm chi tiêu đầu tiên!',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.greenAccent[700], // Màu khi được chọn
        unselectedItemColor: Colors.grey,            // Màu khi không chọn
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Thống kê',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30, 
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          'https://wp-cms-media.s3.ap-east-1.amazonaws.com/lay_anh_dai_dien_facebook_dep_1_2967d609e0.jpg'),
                    ),
                    const SizedBox(width: 15), 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Thuân Bùi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'thuan.bui@email.com',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Lịch sử giao dịch'),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Mở màn hình thêm giao dịch");
        },
        tooltip: 'Thêm giao dịch',
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 30,),
      ),
    );
  }
}
