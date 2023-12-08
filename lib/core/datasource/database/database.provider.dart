import 'package:fcar_lib/core/datasource/database/objectbox/objectbox_store.dart';
import 'package:fcar_lib/core/datasource/datasource.module.dart';

final IDatabase appDatabase = ObjectboxStore(databaseName: DatabaseName.appDb);
