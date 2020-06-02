import 'dart:async';

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
  group('EmailSettingsHttpClientV1', () {
    EmailSettingsHttpClientV1 client;
    EmailSettingsClientFixtureV1 fixture;

    setUp(() async {
      client = EmailSettingsHttpClientV1();
      client.configure(httpConfig);
      var references = References.fromTuples([
        Descriptor(
            'pip-services-emailsettings', 'client', 'http', 'default', '1.0'),
        client
      ]);
      client.setReferences(references);
      fixture = EmailSettingsClientFixtureV1(client);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
      await Future.delayed(Duration(milliseconds: 2000));
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });
  });
}
