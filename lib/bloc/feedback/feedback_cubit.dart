import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oasis_uz_mobile/repositories/feedback_repository.dart';
import 'package:oasis_uz_mobile/repositories/modules/feedback.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final FeedbackRepository _feedbackRepository;

  FeedbackCubit(this._feedbackRepository) : super(FeedbackInitial());

  Future<void> submitFeedback(
      String fullName, String phoneNumber, String message) async {
    try {
      emit(FeedbackLoading());

      await _feedbackRepository
          .submitFeedback(Feedback(fullName, phoneNumber, message));

      emit(FeedbackSubmissionSuccess());
    } catch (e) {
      emit(FeedbackSubmissionError(error: e.toString()));
    }
  }
}
