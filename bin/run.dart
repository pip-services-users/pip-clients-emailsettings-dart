import 'package:pip_clients_emailsettings/pip_clients_emailsettings.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_emailsettings/pip_services_emailsettings.dart';

Future<void> main(List<String> argument) async {
  try {
    var correlationId = '123';
    var config = ConfigParams.fromTuples([
      'connection.type',
      'http',
      'connection.host',
      'localhost',
      'connection.port',
      8080
    ]);
    var client = EmailSettingsHttpClientV1();
    client.configure(config);
    final SETTINGS = EmailSettingsV1(
        id: '1',
        name: 'User 1',
        email: 'user1@conceptual.vision',
        language: 'en',
        verified: false);
    await client.open(correlationId);
    // Create new settings
    await client.setSettings(correlationId, SETTINGS);
    var list = await client.getSettingsByIds(correlationId, [SETTINGS.id]);
    if (list.length == 1) {
      print('Get settings length: ' +
          list.length.toString() +
          '! Everything works well!');
    } else {
      print('Get settings length: ' +
          list.length.toString() +
          ' is not equal! Something was wrong!');
    }
    // Delete settings
    print('Remove settings with id = 1...');
    await client.deleteSettingsById(correlationId, '1');
    list = await client.getSettingsByIds(correlationId, [SETTINGS.id]);
    if (list.isEmpty) {
      print('Get settings length: ' +
          list.length.toString() +
          '! Everything works well!');
    } else {
      print('Get settings length: ' +
          list.length.toString() +
          ' is not equal! Something was wrong!');
    }
    await client.close(correlationId);
  } catch (ex) {
    print(ex);
  }
}
