import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_emailsettings/pip_clients_emailsettings.dart';
import './EmailSettingsClientFixtureV1.dart';

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  8080
]);

void main() {
  group('EmailSettingsMemoryClientV1', () {
    EmailSettingsMemoryClientV1 client;
    EmailSettingsClientFixtureV1 fixture;

    setUp(() async {
      client = EmailSettingsMemoryClientV1();
      fixture = EmailSettingsClientFixtureV1(client);
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });
  });
}
