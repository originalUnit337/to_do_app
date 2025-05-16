import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';

class SwitchDataPicker extends StatefulWidget {
  const SwitchDataPicker({super.key});

  @override
  State<SwitchDataPicker> createState() => _SwitchDataPickerState();
}

class _SwitchDataPickerState extends State<SwitchDataPicker> {
  bool _isSwitched = true;
  DateTime? _selectedDate;

  Future<void> _selectData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.due_by,
              style: AppFontStyle.title,
            ),
            Switch(
              value: _isSwitched,
              onChanged: (value) {
                setState(() {
                  _isSwitched = value;
                  if (!_isSwitched) {
                    _selectedDate = null;
                  } else {
                    _selectData(context);
                  }
                });
              },
            ),
          ],
        ),
        Text(
          _selectedDate == null
              ? 'nothing'
              : _selectedDate!.toLocal().toString(),
        ),
      ],
    );
  }
}
