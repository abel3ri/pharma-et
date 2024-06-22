import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:pharma_et/providers/BannerCarouselProvider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key, required this.banners});

  final List<Widget> banners;

  @override
  Widget build(BuildContext context) {
    final sliderProvider = Provider.of<BannerCarouselProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            items: banners,
            options: CarouselOptions(
              height: 160,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                sliderProvider.changeCurrentIndex(index);
              },
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSmoothIndicator(
            activeIndex: sliderProvider.currentIndex,
            count: banners.length,
            onDotClicked: (index) {},
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              activeDotColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
