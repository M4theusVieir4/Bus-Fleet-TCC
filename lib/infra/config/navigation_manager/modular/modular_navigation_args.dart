import 'package:busbr/infra/config/navigation_manager/navigation_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModularNavigationArguments implements INavigationArguments {
  @override
  dynamic get data => Modular.args.data;

  @override
  Map<String, dynamic> get params => Modular.args.params;

  @override
  Map<String, String> get queryParams => Modular.args.queryParams;

  @override
  Map<String, List<String>> get queryParamsAll => Modular.args.queryParamsAll;

  @override
  Uri get uri => Modular.args.uri;
}
