import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pulse_bay_task/app/app_provider.dart';
import 'package:pulse_bay_task/app/constants/assets.dart';
import 'package:pulse_bay_task/app/constants/theme.dart';
import 'package:pulse_bay_task/app/models/industry.dart';
import 'package:pulse_bay_task/app/models/trade.dart';
import 'package:pulse_bay_task/app/widgets/primary_button.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({
    super.key,
    required this.industry,
  });
  final IndustrySchema industry;
  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    return Scaffold(
      backgroundColor: PulseBayTheme.bgColor,
      appBar: AppBar(
        backgroundColor: PulseBayTheme.transparent,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.leftChevron),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: 0,
        title: Text(
          widget.industry.name ?? '-',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 65,
      ),
      floatingActionButton: PrimaryButton(
        margin: const EdgeInsets.all(23),
        onTapFunction: () {},
        buttonText: "Next",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: FutureBuilder<List<TradeSchema>>(
        future: appProvider.getSearchResults(),
        builder: (context, AsyncSnapshot<List<TradeSchema>> snapshot) {
          Widget children = const SizedBox();
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (appProvider.searchResults.isEmpty) {
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
                  children = SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                bgColor: Colors.transparent,
                                borderColor: const Color(0xff022A4A),
                                fontColor: const Color(0xff022A4A),
                                onTapFunction: () {},
                                buttonText: 'Advanced Search',
                                borderRadius: 5,
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                appProvider.sortTrade();
                              },
                              behavior: HitTestBehavior.opaque,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff022A4A),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 9,
                                  ),
                                  child: SvgPicture.asset(Assets.sort),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Consumer(
                          builder: (context, AppProvider appProvider, child) =>
                              Column(
                            children: [
                              ...appProvider.searchResults
                                  .map(
                                    (e) => _TradeCards(trade: e),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
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
    );
  }
}

class _TradeCards extends StatelessWidget {
  const _TradeCards({required this.trade});
  final TradeSchema trade;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: PulseBayTheme.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trade.businessName ?? '-',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff131212),
                    fontFamily: PulseBayTheme.secondaryFontFamily,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      for (int i = 0; i < (trade.rating ?? 0); i++)
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 247, 213, 21),
                          size: 12,
                        ),
                      for (int i = 0; i < 5 - (trade.rating ?? 0); i++)
                        const Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 12,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.location),
                    const SizedBox(width: 4),
                    Text(
                      '${trade.city ?? '-'}, ${trade.region ?? '-'}',
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Color(0xff9C9C9C),
                        fontFamily: PulseBayTheme.secondaryFontFamily,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
