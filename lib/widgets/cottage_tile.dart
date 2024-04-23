import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/repositories/enums/status.dart';
import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:oasis_uz_mobile/widgets/custom_image.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';

class CustomCottageTile extends StatelessWidget {
  final bool isEdit;
  final Cottage cottage;

  const CustomCottageTile(
    this.isEdit, {
    Key? key,
    required this.cottage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CustomImage(
                cottage.mainAttachment!.id.toString(), 8, true, true),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(text: cottage.name, weight: FontWeight.bold),
                  CustomText(
                    text: '${cottage.weekDaysPrice} USD',
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cottage.status == Status.APPROVED
                      ? Colors.green
                      : cottage.status == Status.PENDING
                          ? Colors.amber
                          : Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: CustomText(
                  text: cottage.status.toStringValue(),
                  color: Colors.white,
                ),
              ),
              if (isEdit)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const CustomText(
                    text: "Tahrirlash",
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
