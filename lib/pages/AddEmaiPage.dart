import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/controllers/FormValidator.dart';
import 'package:pharma_et/providers/AuthProvider.dart';
import 'package:pharma_et/providers/EmailVerificationProvider.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';
import 'package:pharma_et/widgets/FormInputField.dart';
import 'package:provider/provider.dart';

class AddEmailAddress extends StatefulWidget {
  const AddEmailAddress({super.key});

  @override
  State<AddEmailAddress> createState() => _AddEmailAddressState();
}

class _AddEmailAddressState extends State<AddEmailAddress> {
  TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: FaIcon(FontAwesomeIcons.xmark),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.localizations.addEmailAddress,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                FormInputField(
                  controller: _emailController,
                  hintText: context.localizations.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: FormValidator.emailValidator,
                  label: context.localizations.email,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<EmailVerificationProvider>(
                        context,
                        listen: false,
                      ).toggleIsLoading();
                      final res = await Provider.of<EmailVerificationProvider>(
                        context,
                        listen: false,
                      ).addEmailAddress(
                        email: _emailController.text,
                        password:
                            Provider.of<AuthProvider>(context, listen: false)
                                .password,
                      );
                      Provider.of<EmailVerificationProvider>(
                        context,
                        listen: false,
                      ).toggleIsLoading();
                      res.fold((l) {
                        l.showError(context);
                      }, (r) {
                        GoRouter.of(context).pushReplacementNamed("home");
                      });
                    }
                  },
                  child:
                      Provider.of<EmailVerificationProvider>(context).isLoading
                          ? SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(context.localizations.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
