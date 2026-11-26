import 'package:flutter/material.dart';
import 'services/token_storage.dart';

void main() => runApp(const MaterialApp(home: PruebaToken()));

class PruebaToken extends StatefulWidget {
  const PruebaToken({super.key});
  @override
  State<PruebaToken> createState() => _PruebaTokenState();
}

class _PruebaTokenState extends State<PruebaToken> {
  final _storage = TokenStorage();
  String _estado = 'Sin acciones todavía';

  // JWT de ejemplo (no es una sesión real)
  static const _jwtEjemplo =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NSJ9.firma_de_ejemplo';

  Future<void> _guardar() async {
    await _storage.guardarToken(_jwtEjemplo);
    setState(() => _estado = 'Token guardado ✅');
  }

  Future<void> _leer() async {
    final token = await _storage.leerToken();
    setState(() => _estado = token == null
        ? 'No hay token guardado'
        : 'Token recuperado:\n$token');
  }

  Future<void> _borrar() async {
    await _storage.borrarToken();
    setState(() => _estado = 'Token borrado 🗑️');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Token seguro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_estado, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton(onPressed: _guardar, child: const Text('Guardar token')),
            const SizedBox(height: 8),
            FilledButton(onPressed: _leer, child: const Text('Leer token')),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: _borrar, child: const Text('Borrar token')),
          ],
        ),
      ),
    );
  }
}