import 'package:intern_task/response_model.dart';

class GeminiState {
  final ResponseModel? response;
  final bool isLoading;
  final String? error;

  GeminiState({
    this.response,
    this.isLoading = false,
    this.error,
  });

  // Helper method to create a copy of the state with new values
  GeminiState copyWith({
    ResponseModel? response,
    bool? isLoading,
    String? error,
  }) {
    return GeminiState(
      response: response ?? this.response,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
