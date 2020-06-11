import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../version1/EmailSettingsNullClientV1.dart';
import '../version1/EmailSettingsDirectClientV1.dart';
import '../version1/EmailSettingsHttpClientV1.dart';
import '../version1/EmailSettingsMemoryClientV1.dart';

class EmailSettingsClientFactory extends Factory {
  static final NullClientDescriptor =
      Descriptor('pip-services-emailsettings', 'client', 'null', '*', '1.0');
  static final DirectClientDescriptor =
      Descriptor('pip-services-emailsettings', 'client', 'direct', '*', '1.0');
  static final HttpClientDescriptor =
      Descriptor('pip-services-emailsettings', 'client', 'http', '*', '1.0');
  static final MemoryClientDescriptor =
      Descriptor('pip-services-emailsettings', 'client', 'memory', '*', '1.0');      

  EmailSettingsClientFactory() : super() {
    registerAsType(EmailSettingsClientFactory.NullClientDescriptor,
        EmailSettingsNullClientV1);
    registerAsType(EmailSettingsClientFactory.DirectClientDescriptor,
        EmailSettingsDirectClientV1);
    registerAsType(EmailSettingsClientFactory.HttpClientDescriptor,
        EmailSettingsHttpClientV1);
    registerAsType(EmailSettingsClientFactory.MemoryClientDescriptor,
        EmailSettingsMemoryClientV1);        
  }
}
