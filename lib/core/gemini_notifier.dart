import 'gemini_service.dart';
import 'gemini_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeminiNotifier extends StateNotifier<GeminiState> {
  final GeminiService _geminiService;

  GeminiNotifier(this._geminiService) : super(GeminiState());

  // Method to call the Gemini API
  Future<void> generateContent(String prompt) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true, error: null);

      final response = await _geminiService.generateContent(prompt);

      // Set success state with the response
      state = state.copyWith(isLoading: false, response: response);
    } catch (e) {
      // Set error state
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final dio = ref.watch(dioProvider);
  return GeminiService(dio);
});

final geminiNotifierProvider =
StateNotifierProvider<GeminiNotifier, GeminiState>((ref) {
  final geminiService = ref.watch(geminiServiceProvider);
  return GeminiNotifier(geminiService);
});
