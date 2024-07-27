import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPNavigationBar extends StatelessWidget {
  final List<NavigationBarItem> items;

  const ADPNavigationBar({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 30,
            color: design.neutral.withOpacity(.1),
          ),
        ],
      ),
      child: BottomAppBar(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 0,
        ),
        surfaceTintColor: design.neutral900,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 5.height,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 5.height),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];

                    final isSelected = items[index].index == index;

                    return InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: item.onAction,
                      child: Ink(
                        width: MediaQuery.sizeOf(context).width / items.length,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.network(
                              isSelected ? item.icons.onn : item.icons.off,
                              colorFilter: isSelected
                                  ? ColorFilter.mode(
                                      design.primary300,
                                      BlendMode.srcIn,
                                    )
                                  : ColorFilter.mode(
                                      design.neutral400,
                                      BlendMode.srcIn,
                                    ),
                            ),
                            SizedBox(height: 5.height),
                            Text(
                              item.label,
                              style: design.caption().copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? design.primary300
                                        : design.neutral400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationBarItem {
  final String label;
  final ({String onn, String off}) icons;
  final int index;
  final VoidCallback onAction;

  const NavigationBarItem({
    required this.label,
    required this.icons,
    required this.index,
    required this.onAction,
  });
}
