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
      shape: RoundedRectangleBorder(),
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
              Divider(),
              ListTile(
                title: Text(context.localizations.theme),
                trailing: DropdownButton(
                  elevation: 0,
                  underline: SizedBox.shrink(),
                  value: Provider.of<ThemeProvider>(context).theme,
                  items: [
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
                  elevation: 0,
                  underline: SizedBox.shrink(),
                  value: Provider.of<LocaleProvider>(context).locale,
                  items: [
                    DropdownMenuItem(
                      value: "en",
                      child: Text("English"),
                    ),
                    DropdownMenuItem(
                      value: "am",
                      child: Text("አማርኛ"),
                    ),
                  ],
                  onChanged: (value) {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .updateLocale(value!);
                  },
                ),
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: FilledButton(
                  onPressed: () async {
                    await auth.signOut();
                    GoRouter.of(context).pushReplacementNamed("splash");
                  },
                  child: Text(context.localizations.logout),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("version 1.0.0"),
              ),
            ],
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
    );
  }
}
