import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/widgets/cutsom_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyCottagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppHeader(AppLocalizations.of(context)!.myCottages),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
