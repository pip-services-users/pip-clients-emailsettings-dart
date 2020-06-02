import 'dart:async';
import 'dart:convert';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_emailsettings/pip_services_emailsettings.dart';
import './IEmailSettingsClientV1.dart';

class EmailSettingsHttpClientV1 extends CommandableHttpClient
    implements IEmailSettingsClientV1 {
  //ConfigParams _defaultParameters = ConfigParams();

  EmailSettingsHttpClientV1([config]) : super('v1/email_settings') {
    var thisConfig = ConfigParams.fromValue(config);
    //_defaultParameters = thisConfig.getSection('parameters');
    if (config != null) configure(thisConfig);
  }

  /// Gets a list of email settings retrieved by a ids.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [recipientIds]            a recipient ids to get settings
  /// Return         Future that receives a data list
  /// Throws error.
  @override
  Future<List<EmailSettingsV1>> getSettingsByIds(
      String correlationId, List<String> recipientIds) async {
    var result = await callCommand(
      'get_settings_by_ids',
      correlationId,
      {'recipient_ids': recipientIds},
    );
    return List<EmailSettingsV1>.from(json
        .decode(result)
        .map((itemsJson) => EmailSettingsV1.fromJson(itemsJson)));
  }

  /// Gets an email settings by recipient id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of settings to be retrieved.
  /// Return         Future that receives email settings or error.
  @override
  Future<EmailSettingsV1> getSettingsById(
      String correlationId, String recipientId) async {
    var result = await callCommand(
        'get_settings_by_id', correlationId, {'recipient_id': recipientId});
    if (result == null) return null;
    var item = EmailSettingsV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Gets an email settings by its email.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [email]                an email of email settings to be retrieved.
  /// Return         Future that receives email settings or error.
  @override
  Future<EmailSettingsV1> getSettingsByEmail(
      String correlationId, String email) async {
    var result = await callCommand(
        'get_settings_by_email', correlationId, {'email': email});
    if (result == null) return null;
    var item = EmailSettingsV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Sets an email settings.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [settings]              an email settings to be set.
  /// Return         (optional) Future that receives set email settings or error.
  @override
  Future<EmailSettingsV1> setSettings(
      String correlationId, EmailSettingsV1 settings) async {
    var result = await callCommand(
        'set_settings', correlationId, {'settings': settings});
    if (result == null) return null;
    var item = EmailSettingsV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Sets a verified email settings.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [settings]              an email settings to be set.
  /// Return         (optional) Future that receives set verified email settings or error.
  @override
  Future<EmailSettingsV1> setVerifiedSettings(
      String correlationId, EmailSettingsV1 settings) async {
    var result = await callCommand(
        'set_verified_settings', correlationId, {'settings': settings});
    if (result == null) return null;
    var item = EmailSettingsV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Sets a recipient info into email settings.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of settings to be retrieved.
  /// - [name]                a recipient name of settings to be set.
  /// - [email]                a recipient email of settings to be set.
  /// - [language]                a recipient language of settings to be set.
  /// Return         (optional) Future that receives updated email settings
  /// Throws error.
  @override
  Future<EmailSettingsV1> setRecipient(String correlationId, String recipientId,
      String name, String email, String language) async {
    var result = await callCommand('set_recipient', correlationId, {
      'recipient_id': recipientId,
      'name': name,
      'email': email,
      'language': language
    });
    if (result == null) return null;
    var item = EmailSettingsV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Sets a subscriptions into email settings.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of settings to be retrieved.
  /// - [subscriptions]                a subscriptions to be set.
  /// Return         (optional) Future that receives updated email settings
  /// Throws error.
  @override
  Future<EmailSettingsV1> setSubscriptions(
      String correlationId, String recipientId, subscriptions) async {
    var result = await callCommand('set_subscriptions', correlationId,
        {'recipient_id': recipientId, 'subscriptions': subscriptions});
    if (result == null) return null;
    var item = EmailSettingsV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Deleted an email settings by recipient id.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of the email settings to be deleted
  /// Return                Future that receives deleted email settings
  /// Throws error.
  @override
  Future<EmailSettingsV1> deleteSettingsById(
      String correlationId, String recipientId) async {
    var result = await callCommand(
        'delete_settings_by_id', correlationId, {'recipient_id': recipientId});
    if (result == null) return null;
    var item = EmailSettingsV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Resends verification.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of the email settings to be resend verification
  /// Return                Future that receives null for success.
  /// Throws error.
  @override
  Future resendVerification(String correlationId, String recipientId) {
    return callCommand(
        'resend_verification', correlationId, {'recipient_id': recipientId});
  }

  /// Verifies an email.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of the email settings to be verified email
  /// - [code]                a verification code for verifying email
  /// Return                Future that receives null for success.
  /// Throws error.
  @override
  Future verifyEmail(String correlationId, String recipientId, String code) {
    return callCommand('verify_email', correlationId,
        {'recipient_id': recipientId, 'code': code});
  }
}
