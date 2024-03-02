import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/widgets/cutsom_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppHeader(AppLocalizations.of(context)!.messages),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
