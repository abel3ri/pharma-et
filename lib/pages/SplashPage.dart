import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:pharma_et/providers/LocaleProvider.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    final headlines = [
      context.localizations.headline1,
      context.localizations.headline2,
      context.localizations.headline3
    ];
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          DropdownButton(
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 12),
            value: Provider.of<LocaleProvider>(context).locale,
            underline: SizedBox.shrink(),
            borderRadius: BorderRadius.circular(8),
            items: [
              DropdownMenuItem(
                child: Text("English"),
                value: "en",
              ),
              DropdownMenuItem(
                child: Text("አማርኛ"),
                value: "am",
              ),
            ],
            onChanged: (language) {
              Provider.of<LocaleProvider>(context, listen: false)
                  .updateLocale(language!);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.pills,
              color: Theme.of(context).colorScheme.primary,
              size: 96,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "Pharma ET".toUpperCase(),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Expanded(
              flex: 2,
              child: PageView(
                controller: _controller,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Theme.of(context).scaffoldBackgroundColor.lighten(5)
                          : Theme.of(context).scaffoldBackgroundColor.darken(5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/img${index + 1}.png",
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            headlines[index],
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SmoothPageIndicator(
              controller: _controller,
              onDotClicked: (index) {
                _controller.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              effect: ExpandingDotsEffect(
                dotHeight: 12,
                activeDotColor: Theme.of(context).colorScheme.primary,
              ),
              count: 3,
            ),
            Spacer(),
            FilledButton(
              onPressed: () {},
              child: Text(context.localizations.getStarted),
            ),
          ],
        ),
      ),
    );
  }
}
