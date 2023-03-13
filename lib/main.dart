import 'package:calculator/UI/history.dart';
import 'package:calculator/UI/mainscreen.dart';
import 'package:calculator/blocs/history_cubit/history_cubit.dart';
import 'package:calculator/blocs/logic/logic_cubit.dart';
import 'package:calculator/blocs/switch_cubit/switch_cubit.dart';
import 'package:calculator/model/historyitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  await Hive.openBox<HistoryItem>('history');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
  );

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogicCubit()),
        BlocProvider(create: (context) => SwitcheCubit()),
        BlocProvider(create: (context) => HistoryCubit()),
      ],
      child: BlocBuilder<SwitcheCubit, SwitcheState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Calculator',
            theme: state.switchValue ? ThemeData.dark() : ThemeData.light(),
            initialRoute: '/',
            routes: {
              '/': (context) => MainScreen(),
              '/history': (context) => History(),
            },
            home: null,
          );
        },
      ),
    );
  }
}
