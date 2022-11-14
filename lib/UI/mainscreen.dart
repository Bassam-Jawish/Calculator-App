import 'package:calculator/Theme/theme.dart';
import 'package:calculator/blocs/switch_cubit/switch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/logic/logic_cubit.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<String> buttons1 = [
    "C",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "+/-",
    "0",
    ".",
    "=",
  ];

  final List<String> buttons2 = [
    "√",
    "C",
    "DEL",
    "%",
    "/",
    "π",
    "7",
    "8",
    "9",
    "x",
    "1/x",
    "4",
    "5",
    "6",
    "-",
    "e",
    "1",
    "2",
    "3",
    "+",
    "^",
    "+/-",
    "0",
    ".",
    "=",
    ];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final state1 = context.watch<LogicCubit>().state;
      final state2 = context.watch<SwitcheCubit>().state;

      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;

      return Scaffold(
          backgroundColor: state2.switchValue
              ? DarkColors.backgroundColor
              : LightColors.backgroundColor,
          appBar: null,
          body: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    SystemChrome.setPreferredOrientations(
                                        [DeviceOrientation.landscapeLeft]);
                                  },
                                  icon: Icon(Icons.landscape)),
                              SizedBox(
                                height: height / 6,
                                width: width / 6,
                                child: FittedBox(
                                  child: Switch(
                                    value: state2.switchValue,
                                    onChanged: (_) {
                                      context.read<SwitcheCubit>().switche();
                                    },
                                    inactiveTrackColor:
                                        DarkColors.backgroundColor,
                                    activeTrackColor:
                                        LightColors.backgroundColor,
                                    activeColor: Colors.green[200],
                                    inactiveThumbImage: const AssetImage(
                                        'assets/sun_light_mode_day-512.png'),
                                    activeThumbImage: const AssetImage(
                                        'assets/file-svg-night-mode-icon-1167999.png'),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/history');
                                  },
                                  icon: Icon(Icons.history)),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, top: 40, left: 20),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  height: height / 15,
                                  child: Text(
                                    state1.userInput,
                                    style: TextStyle(
                                        color: state2.switchValue
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 22),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  height: height / 25,
                                  child: Text(state1.userOutput,
                                      style: TextStyle(
                                          color: state2.switchValue
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 32)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    BlocListener<LogicCubit, LogicState>(
                      listener: (context, state) {
                        if (state.enough == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: SizedBox(
                                width: width,
                                height: height / 1.58,
                                child: const Center(
                                  child: Text(
                                    'No more digits!',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              duration: const Duration(milliseconds: 400),
                            ),
                          );
                        }
                      },
                      child: Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: state2.switchValue
                                ? DarkColors.sheetBackgroundColor
                                : LightColors.sheetBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: buttons1.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (context, index) {
                                switch (index) {

                                  /// CLEAR BTN
                                  case 0:
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: state2.switchValue
                                            ? DarkColors.buttonColor
                                            : LightColors.buttonColor,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          onTap: () {
                                            context
                                                .read<LogicCubit>()
                                                .clearInputAndOutput();
                                          },
                                          child: Center(
                                            child: Text(
                                              buttons1[index],
                                              style: TextStyle(
                                                  color: state2.switchValue
                                                      ? DarkColors
                                                          .leftOperatorCDColor
                                                      : LightColors
                                                          .leftOperatorCDColor,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  case 1:
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: state2.switchValue
                                            ? DarkColors.buttonColor
                                            : LightColors.buttonColor,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          onTap: () {
                                            if (state1.userInput.isNotEmpty) {
                                              context
                                                  .read<LogicCubit>()
                                                  .deleteBtnAction();
                                            }
                                          },
                                          onLongPress: () {
                                            if (state1.userInput.isNotEmpty) {
                                              context
                                                  .read<LogicCubit>()
                                                  .deleteAllBtnAction();
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              buttons1[index],
                                              style: TextStyle(
                                                  color: state2.switchValue
                                                      ? DarkColors
                                                          .leftOperatorCDColor
                                                      : LightColors
                                                          .leftOperatorCDColor,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  case 19:
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: state2.switchValue
                                            ? DarkColors.equalColor
                                            : LightColors.equalColor,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          onTap: () {
                                            int last =
                                                state1.userInput.length - 1;
                                            if (state1.userInput.isNotEmpty &&
                                                !isOperatorSt(
                                                    state1.userInput[last]) && state1.userInput[last] != "√") {
                                              context
                                                  .read<LogicCubit>()
                                                  .equalPressed();
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              buttons1[index],
                                              style: TextStyle(
                                                  color: state2.switchValue
                                                      ? DarkColors
                                                          .leftOperatorCDColor
                                                      : LightColors
                                                          .leftOperatorCDColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  default:
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: state2.switchValue
                                            ? DarkColors.buttonColor
                                            : LightColors.buttonColor,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          onTap: () {
                                            if (state1.userInput.isNotEmpty) {
                                              if (state1.userInput.length ==
                                                  52) {
                                                context
                                                    .read<LogicCubit>()
                                                    .full();
                                              } else {
                                                int last =
                                                    state1.userInput.length - 1;
                                                if (!isOperatorSt(
                                                    state1.userInput[last])) {
                                                  context
                                                      .read<LogicCubit>()
                                                      .btnTap(buttons1[index]);
                                                } else {
                                                  if (!isOperatorSt(
                                                      buttons1[index])) {
                                                    context
                                                        .read<LogicCubit>()
                                                        .btnTap(buttons1[index]);
                                                  }
                                                }
                                              }
                                            } else {
                                              if (!isOperatorSt(
                                                  buttons1[index])) {
                                                context
                                                    .read<LogicCubit>()
                                                    .btnTap(buttons1[index]);
                                              } else if (buttons1[index] ==
                                                  "+/-") {
                                                context
                                                    .read<LogicCubit>()
                                                    .btnTap(buttons1[index]);
                                              }
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              buttons1[index],
                                              style: TextStyle(
                                                  color: isOperatorSt(
                                                          buttons1[index])
                                                      ? state2.switchValue
                                                          ? DarkColors
                                                              .operatorColor
                                                          : LightColors
                                                              .operatorColor
                                                      : state2.switchValue
                                                          ? Colors.white
                                                          : Colors.black,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                }
                              }),
                        ),
                      ),
                    ),
                  ],
                )

          /*









































           */
              : SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      SystemChrome.setPreferredOrientations(
                                          [DeviceOrientation.portraitUp]);
                                    },
                                    icon: Icon(Icons.portrait)),
                                SizedBox(
                                  height: height / 10,
                                  width: width / 10,
                                  child: FittedBox(
                                    child: Switch(
                                      value: state2.switchValue,
                                      onChanged: (_) {
                                        context.read<SwitcheCubit>().switche();
                                      },
                                      inactiveTrackColor:
                                          DarkColors.backgroundColor,
                                      activeTrackColor:
                                          LightColors.backgroundColor,
                                      activeColor: Colors.green[200],
                                      inactiveThumbImage: const AssetImage(
                                          'assets/sun_light_mode_day-512.png'),
                                      activeThumbImage: const AssetImage(
                                          'assets/file-svg-night-mode-icon-1167999.png'),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/history');
                                    },
                                    icon: Icon(Icons.history)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, top: 20, left: 20),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    height: height / 15,
                                    child: Text(
                                      state1.userInput,
                                      style: TextStyle(
                                          color: state2.switchValue
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 22),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    height: height / 12,
                                    child: Text(state1.userOutput,
                                        style: TextStyle(
                                            color: state2.switchValue
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 32)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      BlocListener<LogicCubit, LogicState>(
  listener: (context, state) {
    if (state.enough == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: SizedBox(
            width: width,
            height: height / 1.8,
            child: const Center(
              child: Text(
                'No more digits!',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          duration: const Duration(milliseconds: 400),
        ),
      );
    }
  },
  child: Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: state2.switchValue
                                ? DarkColors.sheetBackgroundColor
                                : LightColors.sheetBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),

                              itemCount: buttons2.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3,
                                  crossAxisSpacing: 30,
                                  crossAxisCount: 5),
                              itemBuilder: (context, index) {
                                switch (index) {

                                /// CLEAR BTN
                                  case 1:
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: state2.switchValue
                                            ? DarkColors.buttonColor
                                            : LightColors.buttonColor,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          onTap: () {
                                            context
                                                .read<LogicCubit>()
                                                .clearInputAndOutput();
                                          },
                                          child: Center(
                                            child: Text(
                                              buttons2[index],
                                              style: TextStyle(
                                                  color: state2.switchValue
                                                      ? DarkColors
                                                      .leftOperatorCDColor
                                                      : LightColors
                                                      .leftOperatorCDColor,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  case 2:
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: state2.switchValue
                                            ? DarkColors.buttonColor
                                            : LightColors.buttonColor,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          onTap: () {
                                            if (state1.userInput.isNotEmpty) {
                                              context
                                                  .read<LogicCubit>()
                                                  .deleteBtnAction();
                                            }
                                          },
                                          onLongPress: () {
                                            if (state1.userInput.isNotEmpty) {
                                              context
                                                  .read<LogicCubit>()
                                                  .deleteAllBtnAction();
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              buttons2[index],
                                              style: TextStyle(
                                                  color: state2.switchValue
                                                      ? DarkColors
                                                      .leftOperatorCDColor
                                                      : LightColors
                                                      .leftOperatorCDColor,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  case 24:
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: state2.switchValue
                                            ? DarkColors.equalColor
                                            : LightColors.equalColor,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          onTap: () {
                                            int last =
                                                state1.userInput.length - 1;
                                            if (state1.userInput.isNotEmpty &&
                                                !isOperatorSt(
                                                    state1.userInput[last]) && state1.userInput[last] != "√") {
                                              context
                                                  .read<LogicCubit>()
                                                  .equalPressed();
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              buttons2[index],
                                              style: TextStyle(
                                                  color: state2.switchValue
                                                      ? DarkColors
                                                      .leftOperatorCDColor
                                                      : LightColors
                                                      .leftOperatorCDColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  default:
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: state2.switchValue
                                            ? DarkColors.buttonColor
                                            : LightColors.buttonColor,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          onTap: () {
                                            if (state1.userInput.isNotEmpty) {
                                              if (state1.userInput.length ==
                                                  52) {
                                                context
                                                    .read<LogicCubit>()
                                                    .full();
                                              } else {
                                                int last =
                                                    state1.userInput.length - 1;
                                                if (!isOperatorSt(
                                                    state1.userInput[last]) && !isEP(state1.userInput[last])) {
                                                  if (!isEP(
                                                      buttons2[index]) && buttons2[index] != "1/x") {
                                                    context
                                                        .read<LogicCubit>()
                                                        .btnTap(buttons2[index]);
                                                  }
                                                }
                                                else if(isEP(state1.userInput[last])){
                                                  if (isOperatorSt(
                                                      buttons2[index])) {
                                                    context
                                                        .read<LogicCubit>()
                                                        .btnTap(buttons2[index]);
                                                  }
                                                }
                                                else {
                                                  if (!isOperatorSt(
                                                      buttons2[index])) {
                                                    context
                                                        .read<LogicCubit>()
                                                        .btnTap(buttons2[index]);
                                                  }
                                                }
                                              }
                                            } else {
                                              if (!isOperatorSt(
                                                  buttons2[index])) {
                                                context
                                                    .read<LogicCubit>()
                                                    .btnTap(buttons2[index]);
                                              } else if (buttons2[index] ==
                                                  '+/-') {
                                                context
                                                    .read<LogicCubit>()
                                                    .btnTap(buttons2[index]);
                                              }
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              buttons2[index],
                                              style: TextStyle(
                                                  color: isOperatorSt(
                                                      buttons2[index])
                                                      ? state2.switchValue
                                                      ? DarkColors
                                                      .operatorColor
                                                      : LightColors
                                                      .operatorColor
                                                      : state2.switchValue
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                }
                              }),
                        ),
                      ),
),
                    ],
                  ),
                ));
    });
  }

  bool isOperatorSt(String y) {
    if (y == "%" ||
        y == "/" ||
        y == "x" ||
        y == "-" ||
        y == "+" ||
        y == "=" ||
        y == "+/-" ||
        y == "." || y=="^"){
      return true;
    }
    return false;
  }

  bool isEP(String y) {
    if (y == "e" || y == "π"){
      return true;
    }
    return false;
  }

}
