import 'package:flutter/material.dart';

class TabItem {
  String title;
  Icon icon;
  TabItem({this.title, this.icon});
}

final List<TabItem> _tabBar = [
  TabItem(title: 'Photo', icon: Icon(Icons.photo)),
  TabItem(title: 'Chat', icon: Icon(Icons.chat)),
  TabItem(title: 'Albums', icon: Icon(Icons.album)),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
  with TickerProviderStateMixin {
  TabController _tabController;
  int _currentTabIndex = 0;
  final GlobalKey<_MyHomePageState> scaffoldKey = GlobalKey<_MyHomePageState>();

  bool _show = false;

  void openEndDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBar.length, vsync: this);
    _tabController.addListener(() {
      print('Listener: ${_tabController.index}');
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.person)))
        ],
      ),

      drawer: Drawer(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawerHeader(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.yellow,
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Profile'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Images'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text('Files'),
              trailing: Icon(Icons.chevron_right),
            ),
            // Padding(padding: EdgeInsets.only(top: 300.0),),
            Spacer(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(onPressed: (){},child: Text('Выход'),),
                  // Padding(padding: EdgeInsets.all(25)),
                  RaisedButton(onPressed: () {}, child: Text('Регистрация')),
                ]
            ),
          ],
        ),

      ),
      endDrawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://picsum.photos/300'),
              ),
              Text('Пользователь'),
            ]
          )
        ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.green,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network('https://picsum.photos/350'),
                  Text('Photo'),
                ],
            ),
          ),
          Container(
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('https://picsum.photos/400'),
                Text('Chat'),
              ],
            )
          ),
          Container(
            color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('https://picsum.photos/900'),
                Text('Albums'),
              ],
            )
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState((){
              _tabController.index = index;
              _currentTabIndex = index;
          });
      },
        currentIndex: _currentTabIndex,
        items: [
          for(final item in _tabBar)
            BottomNavigationBarItem(
            icon: item.icon,
            label: item.title
      )
      ],
      ),
      floatingActionButton:  FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Open'),
        onPressed: () {
          // _show = true;
          // setState(() {
          //
          // });
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.credit_card),
                            Text('Сумма'),
                            Padding(padding: EdgeInsets.all(30)),
                            Text('200 руб')
                          ],
                        ),
                        ElevatedButton(
                          child: Text('Оплатить'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade300,
                              onPrimary: Colors.black87
                          ),
                          onPressed: () {
                            _show = false;
                            print('Оплата');
                            setState(() {

                            });
                          },
                        ),
                      ]
                  ),
                );
          });

        },
      ),
      // bottomSheet: _showBottomSheet(),
    );
  }

}
