import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/curved_appbar.dart';
import 'package:maple_byte/Component/round_textfield.dart';
import 'package:maple_byte/Model/service_model.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/data/services_data.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController searchController = TextEditingController();
  late List<ServiceModel> allServices;
  late List<ServiceModel> filteredServices;
  String searchQuery = '';
  String selectedSort = 'A to Z';

  @override
  void initState() {
    super.initState();
    allServices = ServiceModel.fromMapList(services);
    filteredServices = List.from(allServices);
    applySortingAndFiltering();
  }

  void applySortingAndFiltering() {
    List<ServiceModel> tempList = allServices
        .where(
          (service) =>
              service.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    switch (selectedSort) {
      case 'A to Z':
        tempList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Z to A':
        tempList.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Price Low-High':
        tempList.sort(
          (a, b) => parsePrice(a.price).compareTo(parsePrice(b.price)),
        );
        break;
      case 'Price High-Low':
        tempList.sort(
          (a, b) => parsePrice(b.price).compareTo(parsePrice(a.price)),
        );
        break;
    }

    setState(() => filteredServices = tempList);
  }

  double parsePrice(String priceString) {
    return double.tryParse(priceString.replaceAll('€', '').trim()) ?? 0;
  }

  void filterUserList(String query) {
    searchQuery = query;
    applySortingAndFiltering();
  }

  void onSortChanged(String? value) {
    if (value != null) {
      selectedSort = value;
      applySortingAndFiltering();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CurvedAppBar(),
        body: Column(
          children: [
            Text(
              "Services",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: RoundTextField(
                label: 'Search',
                hint: 'Search',
                borderRadius: 30,
                bgColor: const Color(0xffEDF0FF),
                enabledBorderColor: const Color(0xffF8F9FE),
                focusedBorderColor: AppColors.greyColor,
                inputType: TextInputType.text,
                prefixIcon: Icons.search,
                textEditingController: searchController,
                onChange: filterUserList,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: DropdownButtonHideUnderline(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton<String>(
                      value: selectedSort,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items:
                          [
                            'A to Z',
                            'Z to A',
                            'Price Low-High',
                            'Price High-Low',
                          ].map((sortOption) {
                            return DropdownMenuItem(
                              value: sortOption,
                              child: Row(
                                children: [
                                  const Icon(Icons.sort, size: 18),
                                  const SizedBox(width: 6),
                                  Text(sortOption),
                                ],
                              ),
                            );
                          }).toList(),
                      onChanged: onSortChanged,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: filteredServices.isEmpty
                    ? const Center(
                        child: Text(
                          "No service found.",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.darkBlueColor,
                          ),
                        ),
                      )
                    : GridView.builder(
                        itemCount: filteredServices.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 18,
                              childAspectRatio: 0.8,
                            ),
                        itemBuilder: (context, index) {
                          final service = filteredServices[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffF1F5FF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      service.imagePath,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                              ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.lightBlueColor,
                                          AppColors.darkBlueColor,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(16),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          service.name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          service.price,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
