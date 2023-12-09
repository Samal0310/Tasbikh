import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/top_panel_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopPanel extends StatelessWidget {
  // final bool activity;
  // final Function toggleActivity;
  const TopPanel({super.key}); //this.activity, this.toggleActivity,

  @override
  Widget build(BuildContext context) {
    final topPanelProvider = context.watch<TopPanelProvider>();

    bool activity = topPanelProvider.activity;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 38,
            margin: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (activity == false) {
                        topPanelProvider.toggleActivity();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: activity == true ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(4),
                      child: Text(
                        'Activity'.tr(),
                        style: TextStyle(
                          color: activity == true ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (activity == true) {
                        topPanelProvider.toggleActivity();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: activity == true ? Colors.white : Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(4),
                      child: Text(
                        'Saves'.tr(),
                        style: TextStyle(
                          color: activity == true ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const ButtonGoSettings(),
      ],
    );
  }
}

class ButtonGoSettings extends StatelessWidget {
  const ButtonGoSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, '/settings');
            context.go('/settings');
          },
          child: SizedBox(
            width: 54,
            height: 38,
            child: Image.asset('assets/img/menu.png'),
          ),
        ),
      ),
    );
  }
}
