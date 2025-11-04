import 'package:dio/dio.dart';
import 'package:intern_task/response_model.dart';

import 'app_strings.dart';

class GeminiService {
  final Dio _dio;

  late final String _apiUrl;

  GeminiService(this._dio) {
    _apiUrl = "${AppStrings().baseUrl}?key=${AppStrings().apiKey}";
  }

  Future<ResponseModel> generateContent(String prompt) async {

    print("prompt:  $prompt");
    try {
      final payload = {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ]
      };

      final response = await _dio.post(
        _apiUrl,
        data: payload,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );


      if (response.statusCode == 200) {
        // Parse the response to get the generated text
        final data = response.data;
        print(data);
        ResponseModel responseModel = ResponseModel(
            candidate: [
              Candidate(
                  content: Content(
                      part: Part(
                          text: [
                            Text(
                                text: data['candidates'][0]['content']['parts'][0]['text']
                            )
                          ]
                      )
                  )
              )
            ]
        );
        return responseModel;
      } else {
        throw Exception('Failed to generate content: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      throw Exception('API call failed: ${e.message}');
    } catch (e) {
      // Handle other errors
      throw Exception('An unknown error occurred: $e');
    }
  }
}