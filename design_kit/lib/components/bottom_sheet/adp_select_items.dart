import 'package:flutter/material.dart';

import '../../design_kit.dart';

class ADPSelectItems {
  static void show({
    required BuildContext context,
    required String title,
    required List<ADPSelectItem> content,
    required Function(ADPSelectItem) onValue,
    bool searchBar = true,
    String hintTextSearchBar = '',
    String textItemNotFound = '',
  }) {
    final design = DesignSystem.of(context);

    final maxHeight = MediaQuery.sizeOf(context).height * .87;

    List<ADPSelectItem> filteredData = content;

    ADPBottomSheet.showContent(
      context: context,
      content: SizedBox(
        height: maxHeight,
        child: StatefulBuilder(
          builder: (_, setState) {
            return Padding(
              padding: EdgeInsets.only(
                right: 24.width,
                left: 24.width,
                bottom: 40.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: design
                        .labelM(color: design.neutral200)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16.height),
                  Visibility(
                    visible: searchBar,
                    child: Column(
                      children: [
                        ADPTextFormField(
                          context,
                          label: hintTextSearchBar,
                          prefixIcon: const Icon(Icons.search_rounded),
                          onChanged: (search) {
                            setState(() {
                              filteredData = _filterByName(
                                data: content,
                                search: search,
                              );
                            });
                          },
                        ),
                        SizedBox(height: 16.height),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: filteredData.isNotEmpty,
                    replacement: Padding(
                      padding: EdgeInsets.only(top: 16.height),
                      child: Text(
                        textAlign: TextAlign.center,
                        textItemNotFound,
                        style: design.labelM(color: design.neutral400),
                      ),
                    ),
                    child: Expanded(
                      child: ListView.separated(
                        itemCount: filteredData.length,
                        itemBuilder: (_, index) {
                          final item = filteredData[index];

                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pop(onValue(item));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.height,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.label,
                                    style: design
                                        .labelS(color: design.neutral)
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 17.fontSize,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => Divider(
                          height: 0,
                          thickness: .12,
                          color: design.neutral,
                        ),
                      ),
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

  static List<ADPSelectItem> _filterByName({
    required List<ADPSelectItem> data,
    required String search,
  }) {
    if (search.isEmpty) return data;

    return data
        .where(
          (element) =>
              element.label.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  }
}

class ADPSelectItem {
  final int id;
  final String label;

  const ADPSelectItem({
    required this.id,
    required this.label,
  });
}
