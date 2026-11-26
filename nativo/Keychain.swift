import Foundation
import Security

enum Keychain {
    static func guardar(token: String, cuenta: String = "jwt") -> Bool {
        let datos = Data(token.utf8)
        let base: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: cuenta
        ]
        SecItemDelete(base as CFDictionary) // evita duplicados

        var nuevo = base
        nuevo[kSecValueData as String] = datos
        nuevo[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        return SecItemAdd(nuevo as CFDictionary, nil) == errSecSuccess
    }

    static func leer(cuenta: String = "jwt") -> String? {
        let consulta: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: cuenta,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var resultado: AnyObject?
        guard SecItemCopyMatching(consulta as CFDictionary, &resultado) == errSecSuccess,
              let datos = resultado as? Data else { return nil }
        return String(data: datos, encoding: .utf8)
    }

    static func borrar(cuenta: String = "jwt") {
        SecItemDelete([
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: cuenta
        ] as CFDictionary)
    }
}