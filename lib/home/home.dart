import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pulse_bay_task/app/app_provider.dart';
import 'package:pulse_bay_task/app/constants/assets.dart';
import 'package:pulse_bay_task/app/constants/theme.dart';
import 'package:pulse_bay_task/app/models/city.dart';
import 'package:pulse_bay_task/app/models/industry.dart';
import 'package:pulse_bay_task/app/widgets/primary_button.dart';
import 'package:pulse_bay_task/search-results/search_results.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    appProvider.randomSvg.shuffle();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: PulseBayTheme.transparent,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 37,
              height: 37,
              margin: const EdgeInsets.only(left: 25),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: PulseBayTheme.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SvgPicture.asset(
                Assets.hamburgerMenu,
                width: 21,
              ),
            ),
          ],
        ),
        title: Image.asset(
          Assets.pulsebayLogo,
          height: 66,
        ),
        leadingWidth: 105,
        centerTitle: true,
        toolbarHeight: 100,
      ),
      backgroundColor: PulseBayTheme.bgColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(Assets.topEllipse),
          FutureBuilder<List>(
            future: Future.wait(
                [appProvider.getIndustries(), appProvider.getCities()]),
            builder: (context, AsyncSnapshot<List> snapshot) {
              Widget children = const SizedBox();
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    if (appProvider.cities.isEmpty) {
                      children = const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            'Try again later',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      children = Column(
                        children: [
                          const SizedBox(height: 130),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 27.0,
                                vertical: 50,
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'LOOKING FOR',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff131212),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  const _CityAndIndustry(),
                                  const SizedBox(height: 32),
                                  Consumer(
                                    builder:
                                        (context, AppProvider value, child) =>
                                            PrimaryButton(
                                      enabled: value.selectedCity != null &&
                                          value.selectedIndustry != null,
                                      onTapFunction: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SearchResults(
                                              industry:
                                                  appProvider.selectedIndustry!,
                                            ),
                                          ),
                                        )
                                            .then((value) {
                                          // appProvider.resetSelection();
                                        });
                                      },
                                      buttonText: 'Search',
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  const _TopIndustries(count: 6),
                                  const SizedBox(height: 32),
                                  const Row(
                                    children: [
                                      Text(
                                        'Most viewed Services',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const _TopIndustries(count: 3),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (snapshot.hasError) {
                    children = const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Something went wrong, Try again after sometime.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  break;
                case ConnectionState.none:
                case ConnectionState.waiting:
                  children = const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                case ConnectionState.active:
                  break;
              }

              return children;
            },
          ),
        ],
      ),
    );
  }
}

class _CityAndIndustry extends StatelessWidget {
  const _CityAndIndustry();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    return Column(
      children: [
        SizedBox(
          height: 43,
          child: DropdownButtonFormField2<IndustrySchema>(
            decoration: PulseBayTheme.pbInputDecoration(
              prefix: SvgPicture.asset(Assets.magnifyGlass),
              hint: 'Plumber',
              fillColor: PulseBayTheme.white,
            ),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 5),
                child: SvgPicture.asset(Assets.downChevron),
              ),
              openMenuIcon: RotatedBox(
                quarterTurns: 90,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                  child: SvgPicture.asset(Assets.downChevron),
                ),
              ),
            ),
            isExpanded: true,
            items: appProvider.industries
                .map(
                  (IndustrySchema item) => DropdownMenuItem<IndustrySchema>(
                    value: item,
                    child: Text(
                      item.name ?? '-',
                      style: const TextStyle(
                        color: PulseBayTheme.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
            value: appProvider.selectedIndustry,
            onChanged: (IndustrySchema? value) {
              appProvider.selectedIndustry = value;
              appProvider.notify();
              // setState(() {
              //   selectedValue = value;
              // }
            },
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 43,
          child: DropdownButtonFormField2<CitySchema>(
            decoration: PulseBayTheme.pbInputDecoration(
              prefix: SvgPicture.asset(Assets.magnifyGlass),
              hint: 'City',
              fillColor: PulseBayTheme.white,
            ),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 5),
                child: SvgPicture.asset(Assets.downChevron),
              ),
              openMenuIcon: RotatedBox(
                quarterTurns: 90,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                  child: SvgPicture.asset(Assets.downChevron),
                ),
              ),
            ),
            isExpanded: true,
            items: appProvider.cities
                .map(
                  (CitySchema item) => DropdownMenuItem<CitySchema>(
                    value: item,
                    child: Text(
                      item.name ?? '-',
                      style: const TextStyle(
                        color: PulseBayTheme.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
            value: appProvider.selectedCity,
            onChanged: (CitySchema? value) {
              appProvider.selectedCity = value;
              appProvider.notify();
              // setState(() {
              //   selectedValue = value;
              // }
            },
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopIndustries extends StatelessWidget {
  const _TopIndustries({required this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    return Wrap(
      children: appProvider.industries
          .sublist(
              0,
              appProvider.industries.length > count - 1
                  ? count
                  : appProvider.industries.length)
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SearchResults(industry: e),
                  ),
                )
                    .then((value) {
                  // appProvider.resetSelection();
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 100,
                width: 98,
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF0F0F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      appProvider.randomSvg[appProvider.industries.indexOf(e)],
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      (e.name ?? '-').toUpperCase(),
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontFamily: PulseBayTheme.secondaryFontFamily,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
