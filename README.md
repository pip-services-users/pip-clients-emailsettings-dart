# <img src="https://github.com/pip-services/pip-services/raw/master/design/Logo.png" alt="Pip.Services Logo" style="max-width:30%"> <br> Email Settings Microservice Client SDK for Dart

This is a Dart client SDK for [pip-services-emailsettings](https://github.com/pip-services-users/pip-services-emailsettings-dart) microservice.

## Download

Right now the only way to get the microservice is to check it out directly from github repository
```bash
git clone git@github.com:pip-services-users/pip-clients-emailsettings-dart.git
```

Pip.Service team is working to implement packaging and make stable releases available for your 
as zip downloadable archieves.

## Contract

Logical contract of the microservice is presented below. For physical implementation (HTTP/REST),
please, refer to documentation of the specific protocol.

```dart
class EmailSettingsV1 implements IStringIdentifiable {
  /* Recipient information */
  String id;
  String name;
  String email;
  String language;

  /* EmailSettings management */
  dynamic subscriptions;
  bool verified;
  String ver_code;
  DateTime ver_expire_time;

  /* Custom fields */
  dynamic custom_hdr;
  dynamic custom_dat;
}

abstract class IEmailSettingsV1 {
  Future<List<EmailSettingsV1>> getSettingsByIds(
      String correlationId, List<String> recipientIds);

  Future<EmailSettingsV1> getSettingsById(String correlationId, String recipientId);

  Future<EmailSettingsV1> getSettingsByEmail(String correlationId, String email);

  Future<EmailSettingsV1> setSettings(String correlationId, EmailSettingsV1 settings);

  Future<EmailSettingsV1> setVerifiedSettings(String correlationId, EmailSettingsV1 settings);  

  Future<EmailSettingsV1> setRecipient(String correlationId, String recipientId, String name, String email, String language);

  Future<EmailSettingsV1> setSubscriptions(String correlationId, String recipientId, dynamic subscriptions);

  Future<EmailSettingsV1> deleteSettingsById(String correlationId, String recipientId);

  Future resendVerification(String correlationId, String recipientId);

  Future verifyEmail(String correlationId, String recipientId, String code);
}
```

## Use

The easiest way to work with the microservice is to use client SDK. 

Define client configuration parameters that match the configuration of the microservice's external API
```dart
// Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = EmailSettingsHttpClientV1(config);

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
```

Now the client is ready to perform operations
```dart
// Create a new settings
final SETTINGS = EmailSettingsV1(
    id: '1',
    name: 'User 1',
    email: 'somebody@somewhere.com',
    language: 'en',
    verified: false);

    // Create the settings
    try {
      var settings = await client.setSettings('123', SETTINGS);
      // Do something with the returned settings...
    } catch(err) {
      // Error handling...     
    }
```

```dart
// Get the settings
try {
var settings = await client.getSettingsByEmail(
    null,
    'somebody@somewhere.com');
    // Do something with settings...

    } catch(err) { // Error handling}
```

```dart
// Verify an email
try {
    settings1 = SETTINGS;
    settings1.ver_code = '123';  
    await controller.verifyEmail(null, '1', '123');

    var settings = await client.getSettingsById(
    null,
    '1');
    // Do something with settings...

    } catch(err) { // Error handling}
``` 

## Acknowledgements

This microservice was created and currently maintained by
- **Sergey Seroukhov**
- **Nuzhnykh Egor**.
