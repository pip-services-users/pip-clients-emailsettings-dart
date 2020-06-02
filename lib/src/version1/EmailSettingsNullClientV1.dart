import 'dart:async';
import 'package:pip_services_emailsettings/pip_services_emailsettings.dart';

import './IEmailSettingsClientV1.dart';

class EmailSettingsNullClientV1 implements IEmailSettingsClientV1 {
  @override
  Future<List<EmailSettingsV1>> getSettingsByIds(
      String correlationId, List<String> recipientIds) async {
    return List<EmailSettingsV1>(0);
  }

  @override
  Future<EmailSettingsV1> getSettingsById(
      String correlationId, String recipientId) async {
    return null;
  }

  @override
  Future<EmailSettingsV1> getSettingsByEmail(
      String correlationId, String email) async {
    return null;
  }

  @override
  Future<EmailSettingsV1> setSettings(
      String correlationId, EmailSettingsV1 settings) {
    return null;
  }

  @override
  Future<EmailSettingsV1> setVerifiedSettings(
      String correlationId, EmailSettingsV1 settings) {
    return null;
  }

  @override
  Future<EmailSettingsV1> setRecipient(String correlationId, String recipientId,
      String name, String email, String language) {
    return null;
  }

  @override
  Future<EmailSettingsV1> setSubscriptions(
      String correlationId, String recipientId, subscriptions) {
    return null;
  }

  @override
  Future<EmailSettingsV1> deleteSettingsById(
      String correlationId, String recipientId) {
    return null;
  }

  @override
  Future resendVerification(String correlationId, String recipientId) {
    return null;
  }

  @override
  Future verifyEmail(String correlationId, String recipientId, String code) {
    return null;
  }
}
