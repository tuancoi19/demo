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

  @override
  void initState() {
    super.initState();
    provider = context.read<MyAppProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: getBodyViewList(value.listAccount).elementAt(value.viewIndex),
          bottomNavigationBar: BottomNavigationBar(
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
          ),
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
}
