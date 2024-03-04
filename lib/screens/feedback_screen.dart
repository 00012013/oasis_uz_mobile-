import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis_uz_mobile/bloc/feedback/feedback_cubit.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';
import 'package:oasis_uz_mobile/repositories/feedback_repository.dart';
import 'package:oasis_uz_mobile/widgets/custom_snackbar.dart';
import 'package:oasis_uz_mobile/widgets/custom_text.dart';
import 'package:oasis_uz_mobile/widgets/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackCubit(FeedbackRepository()),
      child: FeedbackScreenContent(),
    );
  }
}

class FeedbackScreenContent extends StatelessWidget {
  FeedbackScreenContent({super.key});

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController(text: "+998");

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.feedback,
          color: Colors.black,
          size: 18,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: BlocListener<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            if (state is FeedbackSubmissionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomText(
                      text: AppLocalizations.of(context)!.feedbackSuccess,
                      color: Colors.white),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  animation: CurvedAnimation(
                    parent: AnimationController(
                      vsync: Scaffold.of(context),
                      duration: const Duration(milliseconds: 250),
                    ),
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
              );
              CustomSnackBar(backgroundColor: Colors.green).showError(
                context,
                AppLocalizations.of(context)!.feedbackSuccess,
              );
            } else if (state is FeedbackSubmissionError) {
              CustomSnackBar().showError(
                context,
                AppLocalizations.of(context)!.feedbackFailed,
              );
            }
          },
          child: Column(
            children: [
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      CustomText(text: AppLocalizations.of(context)!.fullName),
                      const SizedBox(height: 5),
                      CustomTextField(
                        labelText: '',
                        controller: _fullNameController,
                      ),
                      const SizedBox(height: 20),
                      CustomText(text: AppLocalizations.of(context)!.phone),
                      const SizedBox(height: 5),
                      CustomTextField(
                        labelText: '',
                        isPhone: true,
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 20),
                      CustomText(text: AppLocalizations.of(context)!.message),
                      const SizedBox(height: 5),
                      CustomTextField(
                        maxLines: 10,
                        labelText: AppLocalizations.of(context)!.messageText,
                        controller: _messageController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final fullName = _fullNameController.text;
                  final phoneNumber = _phoneController.text;
                  final message = _messageController.text;
                  context
                      .read<FeedbackCubit>()
                      .submitFeedback(fullName, phoneNumber, message);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealColor,
                  minimumSize: Size(MediaQuery.sizeOf(context).width * 0.5,
                      MediaQuery.sizeOf(context).width * 0.1),
                ),
                child: CustomText(
                  text: AppLocalizations.of(context)!.submit,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
