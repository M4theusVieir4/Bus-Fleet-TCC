import 'package:busbr/infra/core/components/scroll/sliver_flexible_scroll.dart';
import 'package:busbr/infra/core/extensions/string/string_extension.dart';
import 'package:busbr/infra/core/validators/validators.dart';
import 'package:busbr/modules/auth/login/cubit/login_cubit.dart';
import 'package:busbr/modules/auth/login/cubit/login_state.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage2> {
  late LoginCubit _cubit;

  late GlobalKey<FormState> _formKey;

  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  bool _isObscurePassword = true;

  // late UsuarioEntity? _lastLoggedUser;
  // late BiometricsEntity _biometricsEntity = BiometricsEntity.empty();

  // bool get _accessWithBiometrics =>
  //     _biometricsEntity.useBiometrics &&
  //     !_biometricsEntity.isEmpty &&
  //     _lastLoggedUser != null;

  @override
  void initState() {
    super.initState();
    // _cubit = Modular.get()..initialize();
    _cubit = Modular.get();
    _formKey = GlobalKey<FormState>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // _cubit.login(
      //   email: _emailController.text,
      //   password: _passwordController.text,
      // );
    }
  }

  Future<void> _onPressedBiometric() async {
    // final bool authenticate = await Biometrics.authenticate();
    // if (authenticate) {
    //   if (_formKey.currentState?.validate() ?? false) {
    //     _cubit.login(
    //       email: _emailController.text,
    //       password: _biometricsEntity.password,
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is LoginSucccessState) {
            // if (state.biometricEntity.isEmpty &&
            //     Biometrics.isDeviceSupported &&
            //     Biometrics.canCheckBiometrics) {
            //   _displayBiometricsOption(
            //     navigateTo: () {
            //       Navigator.of(context).pop();
            //       Modular.to.pushNamed();
            //     },
            //   );
            // } else {
            //   Modular.to.pushNamed('');
            // }
          }

          // if (state is LoginInitializedState) {
          //   _lastLoggedUser = state.user;
          //   _biometricsEntity = state.biometricEntity;
          //   if (_accessWithBiometrics) {
          //     _emailController.text = _lastLoggedUser?.login ?? '';
          //   }
          // }

          if (state is LoginErrorState) {
            ADPBottomSheet.error(
              context: context,
              title: 'title_bottom_sheet_error'.translate(),
              message: 'description_login_bottom_sheet_error'.translate(),
              actionMessage: 'try_again'.translate(),
            );
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: design.primary300,
            ),
            child: SliverFlexibleScroll(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 160, 80, 80),
                    child: Image.network(
                      design.images.splashLogo,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: SafeArea(
                        bottom: true,
                        top: false,
                        child: loginAndPassword(
                          design,
                          context,
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Form loginAndPassword(AppDesign design, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 38,
          ),
          Text(
            'enter_account'.translate(),
            style: design.h4(color: design.neutral),
          ),
          const SizedBox(
            height: 38,
          ),
          ADPTextFormField(
            context,
            controller: _emailController,
            hint: 'user'.translate(),
            label: 'type_your_login'.translate(),
            // enable: !_accessWithBiometrics,
            validators: Validators.required('required_field'.translate()),
          ),
          SizedBox(
            height: 16.height,
          ),
          Visibility(
            // // visible: !_accessWithBiometrics,
            replacement: GestureDetector(
              onTap: () async => _cubit, //_cubit.changeAccount(),
              child: Text(
                'change_account'.translate(),
                style: design.labelS(color: design.info100),
              ),
            ),
            child: ADPTextFormField(
              context,
              controller: _passwordController,
              hint: 'password'.translate(),
              label: 'type_your_password'.translate(),
              obscureText: _isObscurePassword,
              toggleObscureText: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
              formFieldType: TextInputType.text,
              validators: Validators.required('required_field'.translate()),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Visibility(
            visible: false, //!_accessWithBiometrics,
            child: Column(
              children: [
                Text(
                  'forgot_your_password'.translate(),
                  style: design.labelXS(color: design.neutral300),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'click_to_recover'.translate(),
                  style: design.labelS(color: design.info100),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          ADPDefaultButton(
            label: 'login', //!_accessWithBiometrics
            // ? 'login'.translate()
            // : "biometric_access".translate(),
            primaryColor: design.secondary300,
            labelColor: design.neutral900,
            colorLoading: design.neutral900,
            onPressed: _onPressed,
            // !_accessWithBiometrics ? _onPressed : _onPressedBiometric,
            loading: _cubit.state is LoginLoadingState,
            enablePressOnLoading: false,
          ),
        ],
      ),
    );
  }

  void _displayBiometricsOption({required VoidCallback navigateTo}) {
    // final canCheck = Biometrics.canCheckBiometrics;
    // final isSupported = Biometrics.isDeviceSupported;

    // if (canCheck && isSupported) {
    //   final type = _getBiometricsLabelAndImage();

    //   if (type == null) {
    //     navigateTo();
    //     return;
    //   }

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) {
    //     ADPBottomSheet.show(
    //       context: context,
    //       isDismissible: false,
    //       enableDrag: false,
    //       type: ADPBottomSheetType.info,
    //       title: '${'enable_auth_login'.translate()} ${type.$1.translate()}',
    //       textAlign: TextAlign.center,
    //       actionMessage: 'enable'.translate(),
    //       fontSize: 18.0,
    //       content: Padding(
    //         padding: EdgeInsets.only(top: 12.0.height),
    //         child: Icon(
    //           type.$2,
    //           size: 64.fontSize,
    //         ),
    //       ),
    //       onAction: () { _cubit;
    //         // _cubit.saveBiometricsPref(
    //         //   _passwordController.text,
    //         //   true,
    //         // );
    //         navigateTo();
    //       },
    //       backMessage: 'do_not_enable'.translate(),
    //       onBack: () { _cubit;
    //         // _cubit.saveBiometricsPref(
    //         //   '',
    //         //   false,
    //         // );
    //         navigateTo();
    //       },
    //     );
    //   },
    // );
  }
}
