import 'dart:async';

import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPCarouselSlider extends StatefulWidget {
  final List<ADPCarouselSliderItem> data;
  final Duration animationDuration;

  const ADPCarouselSlider({
    super.key,
    required this.animationDuration,
    required this.data,
  });

  @override
  State<ADPCarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<ADPCarouselSlider>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late Timer _timer;
  late AnimationController _animationController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..forward();

    Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 1),
      ),
    );

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      widget.animationDuration,
      (_) => _slide(forward: true),
    );
  }

  void _animateToPage(int index) => _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
      );

  void _slide({bool forward = true}) {
    final size = widget.data.length;
    final lastIndex = widget.data.length - 1;

    forward ? _currentIndex++ : _currentIndex--;

    if (forward) {
      if (_currentIndex == size) {
        _animateToPage(_pageController.initialPage);
        _currentIndex = 0;
      } else {
        _animateToPage(_currentIndex);
      }
    } else {
      if (_currentIndex < 0) {
        _currentIndex = lastIndex;
        _animateToPage(_currentIndex);
      } else {
        _animateToPage(_currentIndex);
      }
    }

    if (size > 1) {
      _animationController
        ..reset()
        ..repeat();
    }
  }

  void _onTapItem(int index) {
    _timer.cancel();

    _currentIndex = index;

    _animateToPage(_currentIndex);

    _animationController
      ..reset()
      ..repeat();

    _startTimer();
  }

  void _onPageSlider({bool forward = true}) {
    _timer.cancel();
    _slide(forward: forward);
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return SizedBox(
      height: 200,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            return _onPageSlider(forward: false);
          }
          _onPageSlider();
        },
        child: PageView.builder(
          itemCount: widget.data.length,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final items = widget.data;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.width),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        ADPImageLoadable(
                          imageUrl: items[index].imageUrl,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          fit: BoxFit.fitWidth,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              tileMode: TileMode.clamp,
                              colors: [
                                design.neutral,
                                design.neutral.withOpacity(.75),
                                design.neutral.withOpacity(.50),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.height,
                      horizontal: 16.width,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index].description,
                          style: design
                              .labelM(color: design.neutral500)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 14.height),
                        Row(
                          children: List.generate(
                            items.length,
                            (index) => Expanded(
                              child: InkWell(
                                onTap: () => _onTapItem(index),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: index == items.length - 1
                                        ? 0.0
                                        : 8.0.width,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AnimatedBuilder(
                                      animation: _animationController,
                                      builder: (_, __) {
                                        final animationValue =
                                            _currentIndex == index
                                                ? _animationController.value
                                                : _currentIndex < index
                                                    ? 0.0
                                                    : 1.0;

                                        return LinearProgressIndicator(
                                          value: animationValue,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ADPCarouselSliderItem {
  final String imageUrl;
  final String description;

  const ADPCarouselSliderItem({
    required this.imageUrl,
    this.description = '',
  });
}
