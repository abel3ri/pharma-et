import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/providers/LocaleProvider.dart';
import 'package:pharma_et/providers/ThemeProvider.dart';
import 'package:pharma_et/utils/Constants.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: FaIcon(
                  FontAwesomeIcons.pills,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "PHARMA ET",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(context.localizations.theme),
                trailing: DropdownButton(
                  alignment: Alignment.centerRight,
                  elevation: 0,
                  underline: const SizedBox.shrink(),
                  value: Provider.of<ThemeProvider>(context).theme,
                  items: const [
                    DropdownMenuItem(
                      value: "system",
                      child: Text("Device"),
                    ),
                    DropdownMenuItem(
                      value: "light",
                      child: Text("Light"),
                    ),
                    DropdownMenuItem(
                      value: "dark",
                      child: Text("Dark"),
                    ),
                  ],
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeThemeMode(value!);
                  },
                ),
              ),
              ListTile(
                title: Text(context.localizations.language),
                trailing: DropdownButton(
                  alignment: Alignment.centerRight,
                  elevation: 0,
                  underline: const SizedBox.shrink(),
                  value: Provider.of<LocaleProvider>(context).locale,
                  isDense: true,
                  items: const [
                    DropdownMenuItem(
                      value: "en",
                      child: Text("English"),
                    ),
                    DropdownMenuItem(
                      value: "am",
                      child: Text("አማርኛ"),
                    ),
                    DropdownMenuItem(
                      value: "or",
                      child: Text("Afaan Oromoo"),
                    ),
                  ],
                  onChanged: (value) {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .updateLocale(value!);
                  },
                ),
              ),
              ListTile(
                title: TextButton.icon(
                  onPressed: () {
                    GoRouter.of(context).pushNamed("prescriptions");
                  },
                  icon: const FaIcon(FontAwesomeIcons.upRightFromSquare),
                  label: const Text("Uploaded prescriptions"),
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: FilledButton(
                  onPressed: () async {
                    await auth.signOut();
                    GoRouter.of(context).pushReplacementNamed("splash");
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.error,
                    ),
                  ),
                  child: Text(context.localizations.logout),
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text("version 1.1.0"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
