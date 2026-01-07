import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '/models/rag_api.dart';
import '/models/rag_response.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late RagApi api;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    api = RagApi(Dio());
  }

  Future<String> askRag(String question) async {
    try {
      RagResponse resp = await api.askQuestion({"question": question});
      return resp.answer;
    } on DioException catch (e) {
      // Gestion personnalisée des erreurs Dio
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return "⏱️ Délai d'attente dépassé. Veuillez réessayer.";

        case DioExceptionType.connectionError:
          return "🌐 Erreur de connexion. Vérifiez votre connexion internet et réessayez.";

        case DioExceptionType.badResponse:
          return "⚠️ Le serveur a renvoyé une erreur. Veuillez réessayer plus tard.";

        case DioExceptionType.cancel:
          return "❌ Requête annulée.";

        case DioExceptionType.unknown:
        default:
          return "❌ Une erreur est survenue. Veuillez réessayer.";
      }
    } catch (e) {
      // Pour les autres types d'erreurs
      return "❌ Une erreur inattendue s'est produite. Veuillez réessayer.";
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _controller.clear();
      _isLoading = true;
    });

    final answer = await askRag(text);
    setState(() {
      _messages.add(ChatMessage(text: answer, isUser: false));
      _isLoading = false;
    });
  }

  Widget _bubble(ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: msg.isUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            color: msg.isUser
                ? Colors.white
                : Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _bubble(_messages[i]),
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          const Divider(height: 1),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Écrire un message...",
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
