import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/counter_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../services/show_alert_dhikr.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: TextButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/custompage');
                context.go('/settings/custompage');
              },
              child: const Text('Перейти на CustomPage'),
            ),
          ),
          ListTile(
            tileColor: Colors.black12,
            leading: const Icon(Icons.language),
            title: Text('Language:'.tr()),
            trailing: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const EditLangs();
                  },
                );
              },
              child: Text(myLangs[context.locale.toString()].toString()),
            ),
          ),
          ListTile(
            tileColor: Colors.black12,
            leading: const Icon(Icons.sim_card_alert),
            title: const Text('Смотри сюда, вот актуалочка:'),
            trailing: Text(context.read<CounterProvider>().counter.toString()),
          ),
        ],
      ),
    );
  }
}