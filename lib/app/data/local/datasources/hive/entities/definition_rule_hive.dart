/* import 'package:flutter_marvel_dev/app/data/local/datasources/hive/constant/hive_typeid_entity_constant.dart';
import 'package:flutter_siiesp_app/app/data/models/parameters/definition_rule_model.dart';
import 'package:hive/hive.dart';
part 'definition_rule_hive.g.dart';

/// Model that extend of `HiveObject` and allow store data definition rule
/// in the **hive**
@HiveType(
    adapterName: 'DefinitionRuleHiveAdapter',
    typeId: HiveTypeIdEntityConstant.TypeDefinitionRuleHive)
class DefinitionRuleHive extends HiveObject {
  DefinitionRuleHive(
      {this.ruleId,
      this.scopeId,
      this.moduleId,
      required this.variable,
      required this.logicalOperator,
      required this.initialValue,
      this.finalValue,
      this.formula,
      required this.status,
      required this.ruleCode,
      required this.moduleCode});
  factory DefinitionRuleHive.fromModel(DefinitionRuleModel model) {
    return DefinitionRuleHive(
        ruleId: model.ruleId,
        scopeId: model.scopeId,
        moduleId: model.moduleId,
        variable: model.variable,
        logicalOperator: model.logicalOperator,
        initialValue: model.initialValue,
        status: model.status,
        ruleCode: model.ruleCode,
        moduleCode: model.moduleCode);
  }

  @HiveField(0)
  int? ruleId;

  @HiveField(1)
  int? scopeId;

  @HiveField(3)
  int? moduleId;

  @HiveField(4)
  String variable;

  @HiveField(5)
  String logicalOperator;

  @HiveField(6)
  String initialValue;

  @HiveField(7)
  String? finalValue;

  @HiveField(8)
  String? formula;

  @HiveField(9)
  bool status;

  @HiveField(10)
  String ruleCode;

  @HiveField(11)
  String? moduleCode;

  static List<DefinitionRuleModel> toListModel(List<DefinitionRuleHive> list) {
    return list.map((DefinitionRuleHive e) => toModel(e)).toList();
  }

  static DefinitionRuleModel toModel(DefinitionRuleHive definitionRuleHive) {
    return DefinitionRuleModel(
        id: int.parse(definitionRuleHive.key.toString()),
        ruleId: definitionRuleHive.ruleId,
        scopeId: definitionRuleHive.scopeId,
        moduleId: definitionRuleHive.moduleId,
        variable: definitionRuleHive.variable,
        logicalOperator: definitionRuleHive.logicalOperator,
        initialValue: definitionRuleHive.initialValue,
        finalValue: definitionRuleHive.finalValue,
        formula: definitionRuleHive.formula,
        status: definitionRuleHive.status,
        ruleCode: definitionRuleHive.ruleCode,
        moduleCode: definitionRuleHive.moduleCode);
  }
}
 */