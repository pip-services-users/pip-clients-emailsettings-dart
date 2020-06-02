import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_emailsettings/pip_services_emailsettings.dart';
import './IEmailSettingsClientV1.dart';

class EmailSettingsDirectClientV1 extends DirectClient<dynamic>
    implements IEmailSettingsClientV1 {
  //ConfigParams _defaultParameters = ConfigParams();

  EmailSettingsDirectClientV1([config]) : super() {
    dependencyResolver.put(
        'controller',
        Descriptor(
            'pip-services-emailsettings', 'controller', '*', '*', '1.0'));
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
    var timing =
        instrument(correlationId, 'email_settings.get_settings_by_ids');
    var list = await controller.getSettingsByIds(correlationId, recipientIds);
    timing.endTiming();
    return list;
  }

  /// Gets an email settings by recipient id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of settings to be retrieved.
  /// Return         Future that receives email settings or error.
  @override
  Future<EmailSettingsV1> getSettingsById(
      String correlationId, String recipientId) async {
    var timing = instrument(correlationId, 'email_settings.get_settings_by_id');
    var settings = await controller.getSettingsById(correlationId, recipientId);
    timing.endTiming();
    return settings;
  }

  /// Gets an email settings by its email.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [email]                an email of email settings to be retrieved.
  /// Return         Future that receives email settings or error.
  @override
  Future<EmailSettingsV1> getSettingsByEmail(
      String correlationId, String email) async {
    var timing =
        instrument(correlationId, 'email_settings.get_settings_by_email');
    var settings = await controller.getSettingsByEmail(correlationId, email);
    timing.endTiming();
    return settings;
  }

  /// Sets an email settings.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [settings]              an email settings to be set.
  /// Return         (optional) Future that receives set email settings or error.
  @override
  Future<EmailSettingsV1> setSettings(
      String correlationId, EmailSettingsV1 settings) async {
    var timing = instrument(correlationId, 'email_settings.set_settings');
    var result = await controller.setSettings(correlationId, settings);
    timing.endTiming();
    return result;
  }

  /// Sets a verified email settings.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [settings]              an email settings to be set.
  /// Return         (optional) Future that receives set verified email settings or error.
  @override
  Future<EmailSettingsV1> setVerifiedSettings(
      String correlationId, EmailSettingsV1 settings) async {
    var timing =
        instrument(correlationId, 'email_settings.set_verified_settings');
    var result = await controller.setVerifiedSettings(correlationId, settings);
    timing.endTiming();
    return result;
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
    var timing = instrument(correlationId, 'email_settings.set_recipient');
    var result = await controller.setRecipient(
        correlationId, recipientId, name, email, language);
    timing.endTiming();
    return result;
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
    var timing = instrument(correlationId, 'email_settings.set_subscriptions');
    var result = await controller.setSubscriptions(
        correlationId, recipientId, subscriptions);
    timing.endTiming();
    return result;
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
    var timing =
        instrument(correlationId, 'email_settings.delete_settings_by_id');
    var settings =
        await controller.deleteSettingsById(correlationId, recipientId);
    timing.endTiming();
    return settings;
  }

  /// Resends verification.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of the email settings to be resend verification
  /// Return                Future that receives null for success.
  /// Throws error.
  @override
  Future resendVerification(String correlationId, String recipientId) async {
    var timing =
        instrument(correlationId, 'email_settings.resend_verification');
    var result =
        await controller.resendVerification(correlationId, recipientId);
    timing.endTiming();
    return result;
  }

  /// Verifies an email.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipientId]                a recipient id of the email settings to be verified email
  /// - [code]                a verification code for verifying email
  /// Return                Future that receives null for success.
  /// Throws error.
  @override
  Future verifyEmail(
      String correlationId, String recipientId, String code) async {
    var timing = instrument(correlationId, 'email_settings.verify_email');
    var result = await controller.verifyEmail(correlationId, recipientId, code);
    timing.endTiming();
    return result;
  }
}
