import 'package:flutter/material.dart';
import 'package:smart_student_assistant_rags/pages/chatbot_page.dart';
import '../widgets/app_drawer.dart';

/// Page d'accueil principale de l'application
/// Elle présente l'université, un message de bienvenue
/// et introduit l'assistant IA destiné à aider l'étudiant
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Student Assistant'),
      ),

      // Menu latéral
      drawer: const AppDrawer(),

      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            
            Icon(
              Icons.school,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Université Mundiapolis',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Votre assistant académique',
              style: Theme.of(context).textTheme.bodyLarge,
            ),


          ],
        ),
      ),
    );
  }
}
