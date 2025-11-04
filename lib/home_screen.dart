import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/gemini_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = TextEditingController();
    final geminiState = ref.watch(geminiNotifierProvider);
    final geminiNotifier = ref.read(geminiNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 🤝 Gemini'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Text Field for user input
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter your prompt...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),

            // 2. Button to submit the prompt
            ElevatedButton(
              onPressed: geminiState.isLoading
                  ? null // Disable button while loading
                  : () {
                if (textController.text.isNotEmpty) {
                  geminiNotifier.generateContent(textController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: geminiState.isLoading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
                  : const Text('Generate', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24.0),

            // 3. Display area for the response
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SingleChildScrollView(
                  child: Builder(
                    builder: (context) {
                      // Show error if any
                      if (geminiState.error != null) {
                        return Text(
                          geminiState.error!,
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      // Show response if available
                      final response = geminiState.response;
                      if (response != null) {
                        return SelectableText(response.candidate[0].content.part.text[0].text);
                      }
                      // Show a placeholder
                      return const Text(
                          'Your generated content will appear here...');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}