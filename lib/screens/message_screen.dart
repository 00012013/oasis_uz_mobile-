import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/widgets/cutsom_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool showReceivedMessages = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(AppLocalizations.of(context)!.messages),
            const SizedBox(height: 10),
            _buildTopBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showReceivedMessages = true;
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor:
                    showReceivedMessages ? mainColor : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                side: BorderSide(color: mainColor),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Received',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: !showReceivedMessages ? mainColor : Colors.white),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showReceivedMessages = false;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      !showReceivedMessages ? mainColor : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: BorderSide(color: mainColor),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0),
              child: Text(
                'Sent',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: !showReceivedMessages ? Colors.white : mainColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
