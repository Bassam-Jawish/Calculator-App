import 'package:calculator/blocs/history_cubit/history_cubit.dart';
import 'package:calculator/blocs/switch_cubit/switch_cubit.dart';
import 'package:calculator/model/historyitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../Theme/theme.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);

  final List<HistoryItem> result = Hive.box<HistoryItem>('history')
      .values
      .toList()
      .reversed
      .toList()
      .cast<HistoryItem>();

  @override
  Widget build(BuildContext context) {
    final state2 = context.watch<SwitcheCubit>().state;

    return Scaffold(
        backgroundColor: state2.switchValue
            ? DarkColors.backgroundColor
            : LightColors.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: state2.switchValue ? Colors.white : Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'History',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: state2.switchValue ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<HistoryCubit>().wipeHistory(result, context);
              },
              color: state2.switchValue ? Colors.white : Colors.black,
              icon: const Icon(Icons.auto_delete_outlined),
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff6ABA6D), Color(0xff85C888)])),
          ),
        ),
        body: BlocConsumer<HistoryCubit, HistoryState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Container(
              child: state.empty
                  ? const Center(
                      child: Text(
                        'Empty!',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(15.0),
                      itemCount: result.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          tileColor: state2.switchValue
                              ? DarkColors.historyTile
                              : LightColors.historyTile,
                          title: Text(
                            result[i].title,
                            style: TextStyle(
                              fontSize: 25,
                              color: state2.switchValue
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            result[i].subtitle,
                            style: TextStyle(
                              fontSize: 15,
                              color: state2.switchValue
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ));
  }
}
