import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/navigation/app_router.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: AppRouter.router.pop,
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }
}
