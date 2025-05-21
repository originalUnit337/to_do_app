import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';

class SwitchDataPicker extends StatelessWidget {
  const SwitchDataPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final switchValue = ValueNotifier<bool>(false);
    final selectedDate = ValueNotifier<DateTime?>(null);

    Future<void> selectData(BuildContext context) async {
      final picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10),
      );
      if (picked != null && picked != selectedDate.value) {
        selectedDate.value = picked;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)?.due_by ?? 'Due by',
              style: AppFontStyle.title,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: switchValue,
              builder: (context, value, child) {
                return Switch(
                  value: value,
                  onChanged: (newValue) async {
                    switchValue.value = newValue;
                    if (!newValue) {
                      selectedDate.value = null;
                    } else {
                      await selectData(context);
                    }
                  },
                );
              },
            ),
          ],
        ),
        ValueListenableBuilder<DateTime?>(
          valueListenable: selectedDate,
          builder: (context, value, child) {
            return Text(value == null ? 'nothing' : value.toLocal().toString());
          },
        ),
      ],
    );
  }
}
