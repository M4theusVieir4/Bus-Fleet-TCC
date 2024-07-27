import 'package:busbr/modules/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final String _notificationService;

  HomeCubit(this._notificationService) : super(HomeInitialState());
}
