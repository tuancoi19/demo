import 'package:demo/app_configs.dart';
import 'package:demo/models/account_entity.dart';
import 'package:demo/providers/app_provider.dart';
import 'package:demo/views/add_view.dart';
import 'package:demo/views/data_table_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyAppProvider>(
          create: (context) => MyAppProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  late MyAppProvider provider;
  bool isMobileScreen = false;

  @override
  void initState() {
    super.initState();
    provider = context.read<MyAppProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkScreenSize();
    });
  }

  void checkScreenSize() {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width <= 600;
    if (isMobile != isMobileScreen) {
      setState(() {
        isMobileScreen = isMobile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppProvider>(
      builder: (context, value, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: getBodyViewList(value.listAccount)
                        .elementAt(value.viewIndex),
                  ),
                  if (!isMobileScreen)
                    NavigationRail(
                      destinations: AppConfigs.bottomNavigationBarItems.entries
                          .map(
                            (e) => NavigationRailDestination(
                              icon: Icon(e.key),
                              label: Text(e.value),
                            ),
                          )
                          .toList(),
                      selectedIndex: value.viewIndex,
                      onDestinationSelected: (index) =>
                          provider.setViewIndex(index: index),
                    )
                ],
              ),
              bottomNavigationBar: isMobileScreen
                  ? BottomNavigationBar(
                      currentIndex: value.viewIndex,
                      onTap: (index) => provider.setViewIndex(index: index),
                      items: AppConfigs.bottomNavigationBarItems.entries
                          .map(
                            (e) => BottomNavigationBarItem(
                              icon: Icon(e.key),
                              label: e.value,
                            ),
                          )
                          .toList(),
                    )
                  : null,
              drawer: buildDrawer(),
            );
          },
        );
      },
    );
  }

  List<Widget> getBodyViewList(List<AccountEntity> accountList) {
    return [
      DataTableView(
        accountList: accountList,
      ),
      const AddView(),
    ];
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: AppConfigs.bottomNavigationBarItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(
                    AppConfigs.bottomNavigationBarItems.keys.elementAt(index),
                  ),
                  title: Text(
                    AppConfigs.bottomNavigationBarItems.values.elementAt(index),
                  ),
                  onTap: () {
                    provider.setViewIndex(index: index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
