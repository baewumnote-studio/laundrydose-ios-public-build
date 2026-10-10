class AppLinks {
  const AppLinks._();
  static const privacyPolicy = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    defaultValue: '',
  );
  static const support = String.fromEnvironment(
    'SUPPORT_URL',
    defaultValue: '',
  );
  static const supportEmail = String.fromEnvironment(
    'SUPPORT_EMAIL',
    defaultValue: '',
  );

  static Uri? get privacyPolicyUri => _httpsUri(privacyPolicy);
  static Uri? get supportUri => _httpsUri(support);
  static Uri? get supportEmailUri {
    final value = supportEmail.trim();
    if (value.isEmpty || !value.contains('@')) return null;
    return Uri(scheme: 'mailto', path: value);
  }

  static Uri? _httpsUri(String raw) {
    final uri = Uri.tryParse(raw.trim());
    return uri != null && uri.scheme == 'https' && uri.host.isNotEmpty
        ? uri
        : null;
  }
}
