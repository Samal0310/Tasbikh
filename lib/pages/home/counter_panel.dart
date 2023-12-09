import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/counter_provider.dart';
import 'package:flutter_application_1/providers/top_panel_provider.dart';
import 'package:provider/provider.dart';

import '../../services/show_alert_dhikr.dart';

class CounterPanel extends StatelessWidget {
  const CounterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility (
      visible: context.watch<TopPanelProvider>().activity,
      child: const Column (
        children: [
        Counter(),
        SaveButton(),
      ],
      ),
    );
}
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final providerCounter = context.read<CounterProvider>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      margin: const EdgeInsets.only(top: 20, bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => providerCounter.decrement(),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/img/decrement.png'),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () => providerCounter.increment(),
                child: SizedBox(
                  width: 154,
                  height: 154,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      const CounterNumber (),
                      Text(
                        'Dhikr'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => providerCounter.zeroing(),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/img/zeroing.png'),
            ),
          ),
        ],
      ),
    );
  }
}

class CounterNumber extends StatelessWidget {
  const CounterNumber({
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    final providerCounter = context.watch<CounterProvider>();
    return Text(
      providerCounter.counter.toString(),
      style: const TextStyle(
        fontFamily: 'Gilroy-Bold',
        fontSize: 48,
        color: Colors.white,
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showAlertDhikr(
        context: context,
        isEdit: false,
        counter: context.read<CounterProvider>().counter,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 45,
        alignment: Alignment.center,
        child: Text(
          'Save dhikr'.tr(),
          style: const TextStyle(fontSize: 14, color: Colors.blue),
        ),
      ),
    );
  }
}
