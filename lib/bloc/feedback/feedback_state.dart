part of 'feedback_cubit.dart';

sealed class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackSubmissionSuccess extends FeedbackState {}

class FeedbackSubmissionError extends FeedbackState {
  final String error;

  const FeedbackSubmissionError({required this.error});

  @override
  List<Object> get props => [error];
}
