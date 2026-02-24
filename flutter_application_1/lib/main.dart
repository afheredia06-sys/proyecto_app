// lib/main.dart - CÓDIGO FLUTTER PARA TU APP AGRILUX
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Card,
        CircleAvatar,
        Color,
        ColorScheme,
        Colors,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        FontWeight,
        Icon,
        IconData,
        Icons,
        ListTile,
        MaterialApp,
        Padding,
        Row,
        Scaffold,
        SizedBox,
        StatelessWidget,
        Text,
        TextStyle,
        ThemeData,
        VoidCallback,
        Widget,
        runApp;

void main() {
  runApp(const AgriluxApp());
}

class AgriluxApp extends StatelessWidget {
  const AgriluxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agrilux',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D5A27), // Color verde de tu diseño
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EB), // Color beige de fondo
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D5A27),
        title: Row(
          children: [
            Icon(Icons.eco, color: Colors.white), // Reemplazo de Leaf
            const SizedBox(width: 8),
            const Text(
              'AGRILUX',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false, // Sin botón de retroceso
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tu aliado en el campo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5A27),
              ),
            ),
            const SizedBox(height: 30),

            // Diagnóstico de Plagas
            _buildMenuItem(
              icon: Icons.bug_report,
              title: 'Diagnóstico de Plagas',
              subtitle: 'Sube una foto de tu cultivo',
              onTap: () {},
            ),

            // Mercado
            _buildMenuItem(
              icon: Icons.shopping_cart,
              title: 'Mercado',
              subtitle: 'Compra y vende papa',
              onTap: () {},
            ),

            // Contactar Agrilux
            _buildMenuItem(
              icon: Icons.chat,
              title: 'Contactar Agrilux',
              subtitle: 'Habla con nosotros por WhatsApp',
              onTap: () {},
            ),

            // Mi Perfil
            _buildMenuItem(
              icon: Icons.person,
              title: 'Mi Perfil',
              subtitle: 'Registrarme',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF2D5A27)..withValues(alpha: 0.1),
          child: Icon(icon, color: const Color(0xFF2D5A27)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
