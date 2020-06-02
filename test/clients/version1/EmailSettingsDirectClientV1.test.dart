import 'dart:async';
import 'package:pip_clients_email/pip_clients_email.dart';
import 'package:test/test.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services_emailsettings/pip_services_emailsettings.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_emailsettings/pip_clients_emailsettings.dart';
import './EmailSettingsClientFixtureV1.dart';

void main() {
  group('EmailSettingsDirectClientV1', () {
    EmailSettingsDirectClientV1 client;
    EmailSettingsClientFixtureV1 fixture;
    EmailSettingsMemoryPersistence persistence;
    EmailSettingsController controller;

    setUp(() async {
      var logger = ConsoleLogger();
      persistence = EmailSettingsMemoryPersistence();
      controller = EmailSettingsController();
      var references = References.fromTuples([
        Descriptor('pip-services', 'logger', 'console', 'default', '1.0'),
        logger,
        Descriptor('pip-services-emailsettings', 'persistence', 'memory',
            'default', '1.0'),
        persistence,
        Descriptor('pip-services-emailsettings', 'controller', 'default',
            'default', '1.0'),
        controller,
        Descriptor('pip-services-email', 'client', 'null', 'default', '1.0'), EmailNullClientV1()
      ]);
      controller.setReferences(references);

      client = EmailSettingsDirectClientV1();
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
