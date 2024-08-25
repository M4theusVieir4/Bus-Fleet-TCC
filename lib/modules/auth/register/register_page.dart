import 'package:busbr/infra/core/routes/bus_br_routes.dart';
import 'package:busbr/infra/core/validators/validators.dart';
import 'package:busbr/modules/auth/register/cubit/register_controller.dart';
import 'package:busbr/modules/auth/register/cubit/register_state.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Color myColor;
  late Size mediaSize;
  late TextEditingController _userController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late GlobalKey<FormState> _formKey;
  late RegisterController _cubit;
  bool _isObscurePassword = true;
  bool rememberUser = false;

  @override
  void initState() {
    _userController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _cubit = Modular.get()..initialize();
    super.initState();
  }

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _cubit.register(
        user: _userController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    myColor = DesignSystem.of(context).primary;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<RegisterController, RegisterState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state is RegisterSucccessState) {
              _onSendRegister(design);
            }
            if (state is RegisterErrorState) {
              ADPBottomSheet.error(
                context: context,
                title: 'Erro ao Cadastrar',
                message: state.message,
                actionMessage: 'tente novamente',
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Container(
                height: mediaSize.height,
                width: mediaSize.width,
                child: Stack(alignment: Alignment.topCenter, children: [
                  Positioned(top: 0, child: _buildTop()),
                  Positioned(bottom: 0, child: _buildBottom()),
                ]),
              ),
            );
          }),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      height: mediaSize.height * 0.22, // Adicionando altura específica
      child: Container(
        decoration: BoxDecoration(
          color: myColor,
          image: DecorationImage(
            image: const AssetImage(AppIcons.logo),
            fit: BoxFit.none,
            colorFilter:
                ColorFilter.mode(myColor.withOpacity(1), BlendMode.lighten),
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    final design = DesignSystem.of(context);
    return SizedBox(
      width: mediaSize.width,
      height: mediaSize.height * 0.80,
      child: Card(
        margin: EdgeInsets.zero,
        color: design.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          side: BorderSide.none, // Remove a borda padrão
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: design.primary,
                width: 5.0,
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 24.0, bottom: 24.0, top: 10),
            child: SingleChildScrollView(
              child: loginAndPassword(design, context),
            ),
          ),
        ),
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
            height: 10,
          ),
          Text(
            'Cadastre-se',
            style: design.h1(color: design.primary),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Por favor realize o cadastro com suas informações',
            style: design.overline(color: design.primary),
          ),
          const SizedBox(
            height: 20,
          ),
          ADPTextFormField(
            fillColor: design.neutral600,
            context,
            controller: _emailController,
            prefixIcon: Container(
              margin: EdgeInsets.only(right: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: design.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8)),
              ),
              child: Image.asset(AppIcons.email),
            ),
            label: 'Endereço de email',
            // enable: !_accessWithBiometrics,
            validators: Validators.required('campo obrigatório'),
          ),
          SizedBox(
            height: 16.height,
          ),
          ADPTextFormField(
            fillColor: design.neutral600,
            context,
            controller: _userController,
            prefixIcon: Container(
              margin: EdgeInsets.only(right: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: design.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8)),
              ),
              child: Image.asset(AppIcons.userPNG),
            ),
            label: 'Nome de usuário',
            // enable: !_accessWithBiometrics,
            validators: Validators.required('campo obrigatório'),
          ),
          SizedBox(
            height: 16.height,
          ),
          Visibility(
            // // visible: !_accessWithBiometrics,
            replacement: GestureDetector(
              onTap: () async => _cubit, //_cubit.changeAccount(),
              child: Text(
                'change_account',
                style: design.labelS(color: design.info100),
              ),
            ),
            child: Column(
              children: [
                ADPTextFormField(
                  fillColor: design.neutral600,
                  context,
                  controller: _passwordController,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 30),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: design.primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8)),
                    ),
                    child: Image.asset(AppIcons.key),
                  ),
                  label: 'Senha',
                  obscureText: _isObscurePassword,
                  toggleObscureText: () {
                    setState(() {
                      _isObscurePassword = !_isObscurePassword;
                    });
                  },
                  formFieldType: TextInputType.text,
                  validators: Validators.required('campo obrigatório'),
                ),
                SizedBox(
                  height: 16.height,
                ),
                ADPTextFormField(
                  fillColor: design.neutral600,
                  context,
                  controller: _passwordConfirmController,
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 30),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: design.primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8)),
                    ),
                    child: Image.asset(AppIcons.key),
                  ),
                  label: 'Confirmar Senha',
                  obscureText: _isObscurePassword,
                  toggleObscureText: () {
                    setState(() {
                      _isObscurePassword = !_isObscurePassword;
                    });
                  },
                  formFieldType: TextInputType.text,
                  validators: Validators.compare(
                      _passwordController, 'As senhas são diferentes'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ADPDefaultButton(
            label: 'Cadastre-se', //!_accessWithBiometrics
            // ? 'login'.translate()
            // : "biometric_access".translate(),
            primaryColor: design.tertiary100,
            labelColor: design.neutral900,
            colorLoading: design.neutral900,
            onPressed: _onPressed,
            // !_accessWithBiometrics ? _onPressed : _onPressedBiometric,
            loading: _cubit.state is RegisterLoadingState,
            enablePressOnLoading: false,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'ou',
                  style: design.labelXS(color: design.neutral300),
                ),
                const SizedBox(height: 10),
                TextButton(
                  child: Text(
                    'Já possui um cadastro? Clique aqui para entrar >',
                    style: design.labelS(color: design.info100),
                  ),
                  onPressed: () {
                    Modular.to.pushNamed(Modular.initialRoute);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onSendRegister(AppDesign design) {
    ADPBottomSheet.show(
      type: ADPBottomSheetType.accept,
      context: context,
      title: 'Seu cadastro foi criado',
      actionMessage: 'Entre',
      backMessage: 'não',
      backgroundColor: design.neutral900,
      message: 'Entre com seu novo cadastro',
      icon: Image.asset(
        AppIcons.userName,
        color: design.primary,
        height: 40,
        width: 40,
      ),
      onAction: () {
        Modular.to.pushNamed(Modular.initialRoute);
      },
    );
  }
}
