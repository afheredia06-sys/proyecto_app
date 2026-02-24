import 'package:flutter/material.dart';
// CORREGIDO: espacios

import 'package:flutter_application_1/services/agricultor_service.dart'; // SIN espacios
import 'package:flutter_application_1/models/agricultor_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Instancia del servicio
  final _service = AgricultorService();

  // Variables de estado
  Agricultor? _agricultor;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAgricultor();
  }

  Future<void> _loadAgricultor() async {
    try {
      // 1. Obtener usuario actual
      final user = await _service.getCurrentUser();

      // 2. Buscar si es agricultor registrado
      final agricultor = await _service.getAgricultorByEmail(user['email']);

      setState(() {
        // CORREGIDO: setState() { ... } (no setState(）)
        _agricultor = agricultor;
        _loading = false;
      });
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D5A27)),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildMenu(),
              const SizedBox(height: 48),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFF2D5A27),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.eco, color: Colors.white, size: 50),
        ),
        const SizedBox(height: 16),
        const Text(
          'AGRILUX',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D5A27),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _agricultor != null
              ? '¡Hola, ${_agricultor!.nombre.split(' ')[0]}!'
              : 'Tu aliado en el campo',
          style: const TextStyle(fontSize: 20, color: Color(0xFF5D4E37)),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    final menuItems = [
      _MenuItem(
        title: '🌿 Diagnóstico de Plagas',
        description: 'Sube una foto de tu cultivo',
        page: 'diagnostico',
        color: const Color(0xFF2D5A27),
        icon: Icons.camera_alt,
      ),
      _MenuItem(
        title: '💰 Mercado',
        description: 'Compra y vende papa',
        page: 'mercado',
        color: const Color(0xFF8B6914),
        icon: Icons.attach_money,
      ),
      _MenuItem(
        title: '💬 Contactar Agrilux',
        description: 'Habla con nosotros por WhatsApp',
        page: 'contacto',
        color: const Color(0xFF1E7D34),
        icon: Icons.message,
      ),
      _MenuItem(
        title: '👤 Mi Perfil',
        description: _agricultor != null ? 'Ver mis datos' : 'Registrarme',
        page: 'perfil',
        color: const Color(0xFF5D4E37),
        icon: Icons.person,
      ),
    ];

    return Column(
      children: menuItems.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildMenuItem(item),
        );
      }).toList(),
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/${item.page}');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(item.icon, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Text(
      'Versión 1.0 - Hecho para agricultores 🌱',
      style: TextStyle(
        fontSize: 14,
        color: const Color(0xFF5D4E37).withOpacity(0.6),
      ),
    );
  }
}

// Clase auxiliar para los items del menú
class _MenuItem {
  final String title;
  final String description;
  final String page;
  final Color color;
  final IconData icon;

  const _MenuItem({
    required this.title,
    required this.description,
    required this.page,
    required this.color,
    required this.icon,
  });
}
