import 'dart:io';

// import 'package:flutter_marvel_dev/app/data/local/datasources/hive/constant/hive_box_constant.dart';
// import 'package:flutter_marvel_dev/app/data/local/datasources/hive/constant/hive_typeid_entity_constant.dart';
// import 'package:flutter_marvel_dev/app/data/local/datasources/hive/entities/definition_rule_hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

@Injectable()
class DataSourceHiveInstance {
  factory DataSourceHiveInstance() {
    _instance ??= DataSourceHiveInstance._internal();
    return _instance!;
  }
  DataSourceHiveInstance._internal();
  static DataSourceHiveInstance? _instance;
  Future<void> initDb() async {
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    //Register adapters - Here
    /* if (!Hive.isAdapterRegistered(
        HiveTypeIdEntityConstant.TypeDefinitionRuleHive)) {
      Hive.registerAdapter(DefinitionRuleHiveAdapter());
    } */
    //Open Box - Here
    /* if (!Hive.isBoxOpen(HiveBoxConstant.kDefinitionRuleBoxName)) {
      await Hive.openBox<DefinitionRuleHive>(
          HiveBoxConstant.kDefinitionRuleBoxName);
    } */
  }
}
