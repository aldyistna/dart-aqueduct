import 'package:tas_mobile_api/controller/controller.dart';

import 'tas_mobile_api.dart';

class TasMobileApiChannel extends ApplicationChannel {
  ManagedContext context;

  

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = ReadConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint => Router()
    ..route("/inbox/[:id]").link(() => InboxController(context))
    //
    ..route("/order/[:id]").link(() => OrderController(context))
    //
    ..route("/event/[:id]").link(() => EventController(context))
    //
    ..route("/upload").link(() => UploadController())
    //
    ..route("/").linkFunction((request) async {
      final client = await File('client.html').readAsString();
      return Response.ok(client)..contentType = ContentType.html;
    });
  
}

class ReadConfig extends Configuration {
  ReadConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
