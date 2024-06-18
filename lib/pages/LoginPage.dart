import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/controllers/FormValidator.dart';
import 'package:pharma_et/providers/LoginFormProvider.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';
import 'package:pharma_et/widgets/FormInputField.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.xmark),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Hero(
                tag: "logo",
                child: FaIcon(
                  FontAwesomeIcons.pills,
                  color: Theme.of(context).colorScheme.primary,
                  size: 96,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                context.localizations.login,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              FormInputField(
                label: context.localizations.emailOrPhone,
                controller: _emailOrPhoneController,
                hintText: context.localizations.enterEmailOrPhone,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: FormValidator.emailOrPhoneValidator,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              FormInputField(
                controller: _passwordController,
                label: context.localizations.password,
                hintText: context.localizations.enterPassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: !loginFormProvider.showPassword,
                validator: FormValidator.passwordValidator,
                suffix: IconButton(
                  onPressed: () {
                    loginFormProvider.toggleShowPassword();
                  },
                  icon: FaIcon(
                    loginFormProvider.showPassword
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Pass");
                  }
                },
                child: Text(context.localizations.login),
              ),
              TextButton(
                onPressed: () {},
                child: Text(context.localizations.forgotPassword),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.localizations.dontHaveAccount),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushReplacementNamed("signup");
                    },
                    child: Text(context.localizations.signup),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
