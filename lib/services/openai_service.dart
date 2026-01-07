    import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String openAiApiKey = dotenv.env['OPENAI_API_KEY'] ?? "";
 
  static const String _baseUrl = "https://api.openai.com/v1/chat/completions";

  Future<String> sendMessage(String userMessage) async {
    final url = Uri.parse(_baseUrl);

    if (openAiApiKey.isEmpty) {
      throw Exception("❌ OPENAI_API_KEY non définie. Ajoute-la dans l'environnement.");
    }

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $openAiApiKey",
    };

    final body = jsonEncode({
      "model": "gpt-4.1-mini", 
      "messages": [
        {
          "role": "system",
          "content": "Tu es un assistant IA utile et professionnel."
        },
        {
          "role": "user",
          "content": userMessage
        }
      ]
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final String reply =
          data["choices"][0]["message"]["content"] ?? "Pas de réponse.";
      return reply;

    } else {
      print("Erreur API: ${response.statusCode} - ${response.body}");
      throw Exception("Impossible d'obtenir une réponse de OpenAI.");
    }
  }
  
}
