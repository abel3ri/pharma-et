import 'package:pharma_et/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/controllers/FormValidator.dart';
import 'package:pharma_et/providers/SignUpFormProvider.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';
import 'package:pharma_et/widgets/FormInputField.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpFormProvider = Provider.of<SignUpFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
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
            mainAxisSize: MainAxisSize.min,
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
                context.localizations.signup,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    child: FormInputField(
                      controller: _firstNameController,
                      label: context.localizations.firstName,
                      hintText: context.localizations.enterFirstName,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.nameValidator,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: FormInputField(
                      label: context.localizations.lastName,
                      controller: _lastNameController,
                      hintText: context.localizations.enterLastName,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.nameValidator,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              FormInputField(
                label: context.localizations.phone,
                controller: _phoneController,
                hintText: context.localizations.enterPhone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: FormValidator.phoneValidator,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              FormInputField(
                label: context.localizations.email,
                controller: _emailController,
                hintText: context.localizations.enterEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) => null,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              FormInputField(
                label: context.localizations.password,
                controller: _passwordController,
                hintText: context.localizations.enterPassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: !signUpFormProvider.showPassword,
                validator: FormValidator.passwordValidator,
                suffix: IconButton(
                  onPressed: () {
                    signUpFormProvider.toggleShowPassword();
                  },
                  icon: FaIcon(
                    signUpFormProvider.showPassword
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              FormInputField(
                label: context.localizations.rePassword,
                controller: _rePasswordController,
                hintText: context.localizations.reEnterPassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: !signUpFormProvider.showPassword,
                validator: (value) {
                  if (value!.isEmpty) return "Please provide a password";
                  if (value != _passwordController.text) {
                    return "Password do not match";
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    authProvider.toggleIsLoading();
                    authProvider.setUserFields(
                      phoneNumber: _phoneController.text,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      password: _passwordController.text,
                      email: _emailController.text,
                    );

                    final res = await authProvider.sendOTP(
                      context: context,
                    );

                    authProvider.toggleIsLoading();

                    res.fold((l) {
                      l.showError(context);
                    }, (r) {});
                  }
                },
                child: authProvider.isLoading
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(context.localizations.signup),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.localizations.alreadyHaveAccount),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushReplacementNamed("login");
                    },
                    child: Text(context.localizations.login),
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
