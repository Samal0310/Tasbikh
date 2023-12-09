import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/models/dhikr.dart';
import 'package:flutter_application_1/providers/hive_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/show_alert_dhikr.dart';
import 'counter_panel.dart';

class SavesDB extends StatelessWidget {
  const SavesDB({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last saves dhikrs'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 60,
              height: 2,
              color: const Color(0xFF4664FF),
              margin: const EdgeInsets.fromLTRB(0, 4, 0, 20),
            ),
            Expanded(
              child: FutureBuilder(
                  future: context.read<HiveProvider>().openBox(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CupertinoActivityIndicator(color: Colors.blue),
                      );
                    } else {
                      return ValueListenableBuilder(
                        valueListenable:
                            context.read<HiveProvider>().dhikrs.listenable(),
                        builder: (context, dhikrs, _) {
                          return ListView.builder(
                            itemCount: dhikrs.length,
                            itemBuilder: (context, index) {
                              // Инвертируем индекс
                              index = (dhikrs.length - 1) - index;

                              final int counter =
                                  dhikrs.getAt(index)?.counter ?? 0;
                              final String title =
                                  dhikrs.getAt(index)?.title ?? '';
                              final DateTime date =
                                  dhikrs.getAt(index)?.date ?? DateTime.now();

                              return DbItem(index, counter, title, date);
                            },
                          );
                        },
                      );
                    }
                  }),
              // child: ListView.builder(
              //   itemCount: fakeDB.length,
              //   itemBuilder: (context, index) {
              //     // Инвертируем индекс
              //     index = (fakeDB.length - 1) - index;

              //     return DbItem(index);
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class DbItem extends StatelessWidget {
  final int index;
  final int counter;
  final String title;
  final DateTime date;

  const DbItem(this.index, this.counter, this.title, this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightBlueAccent,
      ),
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  counter.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 2,
            height: 30,
            color: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy').format(date),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    showAlertDhikr(
                      context: context,
                      isEdit: true,
                      title: 'Name of the file dhikr'.tr(),
                      counter: counter,
                      index: index,
                    );
                  },
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: Image.asset('assets/img/edit.png'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
