import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _claveToken = 'jwt_token';
  final _almacen = const FlutterSecureStorage();

  Future<void> guardarToken(String jwt) =>
      _almacen.write(key: _claveToken, value: jwt);

  Future<String?> leerToken() => _almacen.read(key: _claveToken);

  Future<void> borrarToken() => _almacen.delete(key: _claveToken);
}