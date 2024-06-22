import 'package:pharma_et/providers/AuthProvider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/models/Error.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 96),
        child: Center(
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
                  context.localizations.verification,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text("Enter the OTP sent to your phone number"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Pinput(
                  controller: _otpController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter OTP sent to your device";
                    }
                    if (value.length < 6) {
                      return "OTP must be at least 6 chars long";
                    }
                    return null;
                  },
                  length: 6,
                  showCursor: true,
                  errorTextStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                  autofocus: true,
                  defaultPinTheme: PinTheme(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDarkMode
                          ? Theme.of(context)
                              .scaffoldBackgroundColor
                              .lighten(10)
                          : Theme.of(context)
                              .scaffoldBackgroundColor
                              .darken(10),
                    ),
                  ),
                  onSubmitted: (value) async {
                    if (_formKey.currentState!.validate()) {
                      authProvider.toggleIsLoading();
                      final res = await authProvider.verifyOTP(
                          otp: _otpController.text);
                      authProvider.toggleIsLoading();
                      res.fold((l) {
                        l.showError(context);
                      }, (r) {
                        GoRouter.of(context).pushReplacementNamed("home");
                      });
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                FilledButton(
                  onPressed: () async {
                    if (_otpController.text.isEmpty) {
                      ErrorMessage(body: "Please enter OTP").showError(context);
                    } else if (_otpController.text.length < 6) {
                      ErrorMessage(body: "OTP must be 6 characters long")
                          .showError(context);
                    } else {
                      authProvider.toggleIsLoading();
                      final res = await Provider.of<AuthProvider>(context,
                              listen: false)
                          .verifyOTP(
                        otp: _otpController.text,
                      );
                      authProvider.toggleIsLoading();
                      res.fold((l) {
                        l.showError(context);
                      }, (r) {
                        GoRouter.of(context).pushReplacementNamed("home");
                      });
                    }
                  },
                  child: authProvider.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(context.localizations.verify),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(context.localizations.didntRecieveCode),
                TextButton(
                  onPressed: authProvider.resendEnabled
                      ? () {
                          authProvider.sendOTP(context: context);
                        }
                      : null,
                  child: Text(authProvider.resendEnabled
                      ? 'Resend Code'
                      : 'Resend in ${authProvider.resendCountDown} seconds'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
