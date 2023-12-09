import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/dhikr.dart';
import 'package:flutter_application_1/pages/home/counter_panel.dart';
import 'package:flutter_application_1/providers/counter_provider.dart';
import 'package:flutter_application_1/providers/hive_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void showAlertDhikr({
  required BuildContext context,
  required bool isEdit,
  required int counter,
  int? index,
  String? title,
}) {
  TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      final hiveProvider = context.read<HiveProvider>();
      return AlertDialog(
        title: isEdit ? Text('Edit dhikr'.tr()) : Text('Save dhikr'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'Number of dhikrs:'.tr()} $counter'),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: controller,
              placeholder: title ?? 'Enter title'.tr(),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ],
        ),
        actions: [
          Visibility(
            visible: isEdit,
            child: IconButton(
              onPressed: () {
                if (index != null) {
                  hiveProvider.deleteDhikr(index);
                  // fakeDB.removeAt(index);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'.tr()),
          ),
          FilledButton(
            onPressed: () {
              if (isEdit == false) {
                hiveProvider.saveDhikr(Dhikr(
                  counter: counter,
                  title: controller.text,
                  date: DateTime.now(),
                ));
                // fakeDB.add(Dhikr(
                //   counter: counter,
                //   title: controller.text,
                //   date: DateTime.now(),
                // ));
              } else {
                if (index != null) {
                  hiveProvider.editDhikr(
                    index,
                    Dhikr(
                      counter: counter,
                      title: controller.text,
                      date: hiveProvider.dhikrs.getAt(index)?.date ??
                          DateTime.now(),
                    ),
                  );
                  // fakeDB[index] = Dhikr(
                  //   counter: counter,
                  //   title: controller.text,
                  //   date: fakeDB[index].date,
                  // );
                }
              }
              Navigator.pop(context);
            },
            child: Text('Save'.tr()),
          ),
        ],
      );
    },
  );
}

const Map<String, String> myLangs = {
  'en': 'English',
  'ru': 'Русский',
  'kk': 'Казахский',
};

class EditLangs extends StatelessWidget {
  const EditLangs({super.key});

  @override
  Widget build(BuildContext context) {
    final supportedLocales = context.supportedLocales;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: List.generate(
          supportedLocales.length,
          (index) {
            return Column(
              children: [
                ListTile(
                  onTap: () async {
                    context.go('/');

                    await context.setLocale(supportedLocales[index]);
                  },
                  title: Text(
                    myLangs[supportedLocales[index].toString()].toString(),
                  ),
                ),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
