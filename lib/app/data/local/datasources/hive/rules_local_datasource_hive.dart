/* 
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Named(LocalDataSourceTypes.HIVE)
@Injectable(as: RulesLocalDatasource)
class RulesLocalDataSourceHive implements RulesLocalDatasource {
  RulesLocalDataSourceHive(this.dataSourceHiveInstance);
  final DataSourceHiveInstance dataSourceHiveInstance;

  Box<DefinitionRuleHive> get getRuleBox =>
      Hive.box<DefinitionRuleHive>(HiveBoxConstant.kDefinitionRuleBoxName);

  @override
  Future<List<DefinitionRuleModel>> getAllRules() async {
    final List<DefinitionRuleHive> rules = getRuleBox.values.toList();
    return DefinitionRuleHive.toListModel(rules);
  }

  @override
  Future<bool> saveAll(List<DefinitionRuleModel> list) async {
    if (list.isNotEmpty) {
      final Map<int, DefinitionRuleHive> mapDefinitionRule =
          <int, DefinitionRuleHive>{};
      for (final DefinitionRuleModel definitionRuleModel in list) {
        mapDefinitionRule[definitionRuleModel.id] =
            DefinitionRuleHive.fromModel(definitionRuleModel);
      }
      await getRuleBox.putAll(mapDefinitionRule);
    }
    return true;
  }

  @override
  Future<DefinitionRuleModel?> findRuleByCode(String codeRule) async {
    final DefinitionRuleHive? findRule = getRuleBox.values.firstWhereOrNull(
        (DefinitionRuleHive rule) =>
            rule.ruleCode.toLowerCase() == codeRule.toLowerCase());
    if (findRule != null) {
      return DefinitionRuleHive.toModel(findRule);
    }
    return null;
  }

  @override
  Future<bool> validateRuleIsActiveByCode(String codeRule) async {
    final DefinitionRuleModel? findRule = await findRuleByCode(codeRule);
    if (findRule != null) {
      return findRule.status;
    }
    return false;
  }

  @override
  Future<DefinitionRuleModel?> findRuleByCodeAndModuleCode(
      String codeRule, String moduleCode) async {
    final DefinitionRuleHive? findRule = getRuleBox.values.firstWhereOrNull(
        (DefinitionRuleHive rule) =>
            rule.ruleCode.toLowerCase() == codeRule.toLowerCase() &&
            rule.moduleCode?.toLowerCase() == moduleCode.toLowerCase());
    if (findRule != null) {
      return DefinitionRuleHive.toModel(findRule);
    } else {
      return null;
    }
  }

  @override
  Future<bool> validateRuleIsActiveByCodeModuleCode(
      String codeRule, String moduleCode) async {
    final DefinitionRuleModel? findRule =
        await findRuleByCodeAndModuleCode(codeRule, moduleCode);
    if (findRule != null) {
      return findRule.status;
    }
    return false;
  }

  @override
  Future<bool> deleteAll() async {
    await getRuleBox.clear();
    return true;
  }

  @override
  Future<bool> save(DefinitionRuleModel definitionRuleModel) async {
    await getRuleBox.put(definitionRuleModel.id,
        DefinitionRuleHive.fromModel(definitionRuleModel));
    return true;
  }
}
 */