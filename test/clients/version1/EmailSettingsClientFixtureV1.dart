import 'package:test/test.dart';
import 'package:pip_services_emailsettings/pip_services_emailsettings.dart';
import 'package:pip_clients_emailsettings/pip_clients_emailsettings.dart';

final SETTINGS = EmailSettingsV1(
    id: '1',
    name: 'User 1',
    email: 'user1@conceptual.vision',
    language: 'en',
    verified: false);

class EmailSettingsClientFixtureV1 {
  IEmailSettingsClientV1 _client;

  EmailSettingsClientFixtureV1(IEmailSettingsClientV1 client) {
    expect(client, isNotNull);
    _client = client;
  }

  void testCrudOperations() async {
    EmailSettingsV1 settings1;

    // Create email settings
    var settings = await _client.setSettings(null, SETTINGS);
    expect(settings, isNotNull);
    expect(SETTINGS.id, settings.id);
    expect(SETTINGS.email, settings.email);
    expect(settings.verified, isFalse);

    settings1 = settings;

    // Update verified email settings
    settings = await _client.setVerifiedSettings(null, settings1);
    expect(settings, isNotNull);
    expect(settings1.id, settings.id);
    expect(settings1.email, settings.email);
    expect(settings.verified, isTrue);

    // Update the settings
    settings1.subscriptions = {'engagement': true};

    settings = await _client.setSettings(null, settings1);
    expect(settings, isNotNull);
    expect(settings1.id, settings.id);
    expect(settings.subscriptions['engagement'], isTrue);

    // Get settings
    var list = await _client.getSettingsByIds(null, [settings1.id]);
    expect(list, isNotNull);
    expect(list.length, 1);

    // Delete the settings
    settings = await _client.deleteSettingsById(null, settings1.id);
    expect(settings, isNotNull);
    expect(settings1.id, settings.id);

    // Try to get deleted settings
    settings = await _client.getSettingsById(null, settings1.id);
    expect(settings, isNull);
  }
}
