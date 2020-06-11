import 'package:pip_services_emailsettings/pip_services_emailsettings.dart';

import './IEmailSettingsClientV1.dart';

class EmailSettingsMemoryClientV1 implements IEmailSettingsClientV1 {
  List<EmailSettingsV1> _settings = <EmailSettingsV1>[];

  @override
  Future<List<EmailSettingsV1>> getSettingsByIds(
      String correlationId, List<String> recipientIds) async {
    var settings = _settings.where((s) => recipientIds.contains(s.id)).toList();
    return settings;
  }

  @override
  Future<EmailSettingsV1> getSettingsById(
      String correlationId, String recipientId) async {
    var settings = _settings.isNotEmpty
        ? _settings.firstWhere((s) => s.id == recipientId)
        : null;
    return settings;
  }

  @override
  Future<EmailSettingsV1> getSettingsByEmail(
      String correlationId, String email) async {
    var settings = _settings.isNotEmpty
        ? _settings.firstWhere((s) => s.email == email)
        : null;
    return settings;
  }

  @override
  Future<EmailSettingsV1> setSettings(
      String correlationId, EmailSettingsV1 settings) async {
    settings.verified = false;
    settings.subscriptions = settings.subscriptions ?? {};

    var old_settings = _settings;
    _settings = old_settings.where((s) => s.id != settings.id).toList();
    _settings.add(settings);
    return settings;
  }

  @override
  Future<EmailSettingsV1> setVerifiedSettings(
      String correlationId, EmailSettingsV1 settings) async {
    settings.verified = true;
    settings.subscriptions = settings.subscriptions ?? {};

    var old_settings = _settings;
    _settings = old_settings.where((s) => s.id != settings.id).toList();
    _settings.add(settings);
    return settings;
  }

  @override
  Future<EmailSettingsV1> setRecipient(String correlationId, String recipientId,
      String name, String email, String language) async {
    var settings = _settings.isNotEmpty
        ? _settings.firstWhere((s) => s.id == recipientId)
        : null;

    if (settings != null) {
      settings.name = name;
      settings.email = email;
      settings.language = language;
    } else {
      settings = EmailSettingsV1(
          id: recipientId,
          name: name,
          email: email,
          language: language,
          verified: false,
          subscriptions: {});
      _settings.add(settings);
    }

    return settings;
  }

  @override
  Future<EmailSettingsV1> setSubscriptions(
      String correlationId, String recipientId, dynamic subscriptions) async {
    var settings = _settings.isNotEmpty
        ? _settings.firstWhere((s) => s.id == recipientId)
        : null;

    if (settings != null) {
      settings.subscriptions = subscriptions;
    } else {
      settings = EmailSettingsV1(
          id: recipientId,
          name: null,
          email: null,
          language: null,
          subscriptions: subscriptions);
      _settings.add(settings);
    }

    return settings;
  }

  @override
  Future<EmailSettingsV1> deleteSettingsById(
      String correlationId, String recipientId) async {
    var old_settings = _settings;
    var settings = _settings.isNotEmpty
        ? _settings.firstWhere((s) => s.id == recipientId)
        : null;
    _settings = old_settings.where((s) => s.id != recipientId).toList();
    return settings;
  }

  @override
  Future<void> resendVerification(
      String correlationId, String recipientId) async {
    return null;
  }

  @override
  Future<void> verifyEmail(
      String correlationId, String recipientId, String code) async {
    var settings = _settings.isNotEmpty
        ? _settings.firstWhere((s) => s.id == recipientId)
        : null;

    if (settings != null && settings.ver_code == code) {
      settings.verified = true;
      settings.ver_code = null;
    }

    return null;
  }
}
