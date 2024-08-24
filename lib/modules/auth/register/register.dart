import 'package:busbr/infra/core/validators/validators.dart';
import 'package:busbr/modules/auth/login/cubit/login_controller.dart';
import 'package:busbr/modules/auth/login/cubit/login_state.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;
  late LoginController _cubit;
  bool _isObscurePassword = true;
  bool rememberUser = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _cubit = Modular.get()..initialize();
    super.initState();
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
      _cubit.login(
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
      body: Center(
        child: Container(
          height: mediaSize.height,
          width: mediaSize.width,
          child: Stack(alignment: Alignment.topCenter, children: [
            Positioned(top: 0, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom()),
          ]),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      height: mediaSize.height * 0.37, // Adicionando altura específica
      child: Container(
        decoration: BoxDecoration(
          color: myColor,
          image: DecorationImage(
            image: const AssetImage(AppIcons.logo),
            fit: BoxFit.none,
            colorFilter:
                ColorFilter.mode(myColor.withOpacity(1), BlendMode.dstATop),
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    final design = DesignSystem.of(context);
    return SizedBox(
      width: mediaSize.width,
      height: mediaSize.height * 0.65,
      child: Card(
        color: design.secondary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: loginAndPassword(design, context),
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
            height: 38,
          ),
          Text(
            'Bem-vindo',
            style: design.h4(color: design.neutral),
          ),
          const SizedBox(
            height: 38,
          ),
          ADPTextFormField(
            context,
            controller: _emailController,
            hint: 'user',
            label: 'type_your_login',
            // enable: !_accessWithBiometrics,
            validators: Validators.required('required_field'),
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
            child: ADPTextFormField(
              context,
              controller: _passwordController,
              hint: 'password',
              label: 'type_your_password',
              obscureText: _isObscurePassword,
              toggleObscureText: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
              formFieldType: TextInputType.text,
              validators: Validators.required('required_field'),
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
                  'forgot_your_password',
                  style: design.labelXS(color: design.neutral300),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'click_to_recover',
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
          Center(
            child: Column(
              children: [
                _buildGreyText("Or Login with"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(AppIcons.facebookPNG, height: 40),
                    Image.asset(AppIcons.twitter, height: 40),
                    SvgPicture.asset(
                      AppIcons.google,
                      height: 40,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Please login with your information"),
        const SizedBox(height: 20),
        _buildGreyText("Email address"),
        _buildInputField(_emailController),
        const SizedBox(height: 20),
        _buildGreyText("Password"),
        _buildInputField(_passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("Remember me"),
          ],
        ),
        TextButton(
            onPressed: () {}, child: _buildGreyText("I forgot my password"))
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${_emailController.text}");
        debugPrint("Password : ${_passwordController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("ou entrar com"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(AppIcons.facebookPNG, height: 40),
              Image.asset(AppIcons.twitter, height: 40),
              SvgPicture.asset(
                AppIcons.google,
                height: 40,
              )
            ],
          ),
          _buildGreyText("Novo aqui? Clique aqui para se cadastrar")
        ],
      ),
    );
  }
}
