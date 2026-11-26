// Dependencia en build.gradle:
// implementation("androidx.security:security-crypto:1.1.0-alpha06")

import android.content.Context
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey

class SecureTokenStore(context: Context) {

    // Clave maestra AES-256 guardada en el Android Keystore
    private val masterKey = MasterKey.Builder(context)
        .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
        .build()

    // SharedPreferences cifradas: cifra tanto las claves como los valores
    private val prefs = EncryptedSharedPreferences.create(
        context,
        "secure_prefs",
        masterKey,
        EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
        EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
    )

    fun guardarToken(jwt: String) = prefs.edit().putString("jwt", jwt).apply()
    fun leerToken(): String? = prefs.getString("jwt", null)
    fun borrarToken() = prefs.edit().remove("jwt").apply()
}