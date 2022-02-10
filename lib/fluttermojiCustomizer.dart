import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoji/custom_icon_icons.dart';
import './satinAlinanModel.dart';
import 'fluttermoji_assets/fluttermojimodel.dart';
import 'package:get/get.dart';
import 'fluttermojiController.dart';

class FluttermojiCustomizer extends StatefulWidget {
  List<SatinAlinanAvatarModel> satinAlinanList;

  FluttermojiCustomizer({
    Key? key,
    required this.satinAlinanList,
  }) : super(key: key);

  @override
  _FluttermojiCustomizerState createState() => _FluttermojiCustomizerState();
}

class _FluttermojiCustomizerState extends State<FluttermojiCustomizer>
    with SingleTickerProviderStateMixin {
  late FluttermojiController fluttermojiController;
  late TabController tabController;
  var heightFactor = 0.48;
  var widthFactor = 0.98;

  List<ExpandedFluttermojiCardItem> attributesListe = [
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Skin",
      key: "skinColor",
      icon: CustomIcon.beauty_treatment,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Hairstyle",
      key: "topType",
      icon: CustomIcon.hair_cutting,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Hair Colour",
      key: "hairColor",
      icon: CustomIcon.hair_dye,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Facial Hair",
      key: "facialHairType",
      icon: CustomIcon.mustache,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Facial Hair Colour",
      key: "facialHairColor",
      icon: CustomIcon.mustache,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Outfit",
      key: "clotheType",
      icon: CustomIcon.tshirt,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Outfit Colour",
      key: "clotheColor",
      icon: CustomIcon.t_shirt,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Eyes",
      key: "eyeType",
      icon: CustomIcon.visibility,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Eyebrows",
      key: "eyebrowType",
      icon: CustomIcon.eye_color,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Mouth",
      key: "mouthType",
      icon: CustomIcon.lips,
      color: Colors.black87,
    ),
    ExpandedFluttermojiCardItem(
      iconAsset: "attributeicons/skin_1.png",
      title: "Glasses",
      key: "accessoriesType",
      icon: CustomIcon.glasses,
      color: Colors.black87,
    ),
  ];

  String? seciliGiysiKategori = "skinColor";
  List<int> seciliGiysiDegerleri = [];

  @override
  void initState() {
    super.initState();
    var _fluttermojiController;
    Get.put(FluttermojiController());
    _fluttermojiController = Get.find<FluttermojiController>();
    seciliGiysiKategori = attributesListe[0].key;
    satinAlmalariDondur();
    setState(() {
      tabController = TabController(length: 11, vsync: this);
      fluttermojiController = _fluttermojiController;
    });

    tabController.addListener(() {
      setState(() {
        seciliGiysiKategori = attributesListe[tabController.index].key;
      });
      satinAlmalariDondur();
    });
  }

  void satinAlmalariDondur() {
    for (var i = 0; i < widget.satinAlinanList.length; i++) {
      String alinanString = widget.satinAlinanList[i].resimYol;

      if (alinanString.substring(0, 4) != "http" &&
          alinanString.substring(0, 4) != "asse") {
        var kategoriKey = alinanString.split(":").first.trim();
        var kategoriDeger = alinanString.split(":").last.trim();

        if (kategoriKey == seciliGiysiKategori) {
          try {
            setState(() {
              seciliGiysiDegerleri.add(int.parse(kategoriDeger));
            });
          } catch (e) {}
          print(seciliGiysiDegerleri);
        } else {
          setState(() {
            seciliGiysiDegerleri = [];
          });
        }
      }
    }
  }

  @override
  void dispose() {
    // This ensures that unsaved edits are reverted
    fluttermojiController.restoreState();
    super.dispose();
    tabController.dispose();
  }

  /// Widget that renders an expanded layout for customization
  /// Accepts a [cardTitle] and a [attributes].
  ///
  /// [attribute] is an object with the fields attributeName and attributeKey
  Widget expandedCard(
      {required String cardTitle,
      required List<ExpandedFluttermojiCardItem> attributes}) {
    var size = MediaQuery.of(context).size;

    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var iconColor = (!isDarkMode) ? Colors.grey[600] : Colors.white;
    //final double mediumfont = size.height * 0.038;
    var attributeRows = <Widget>[];
    var navbarWidgets = <Widget>[];
    var _appbarcolor = (!isDarkMode) ? Colors.white : Colors.grey[600];
    var _bgcolor = (!isDarkMode) ? Color(0xFFF1F1F1) : Colors.grey[800];

    attributes.forEach((attribute) {
      if (!fluttermojiController.selectedIndexes.containsKey(attribute.key)) {
        fluttermojiController.selectedIndexes[attribute.key] = 0;
      }
      var attributeListLength =
          fluttermojiProperties[attribute.key!]!.property!.length;
      var gridCrossAxisCount = 3;
      int? i = fluttermojiController.selectedIndexes[attribute.key];
      if (attributeListLength < 12)
        gridCrossAxisCount = 3;
      else if (attributeListLength < 9) gridCrossAxisCount = 2;
      // Widget bottomNavWidget = Padding(
      //   padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
      //   child: SvgPicture.asset(
      //     attribute.iconAsset!,
      //     package: 'fluttermoji',
      //     height: (attribute.iconsize == 0)
      //         ? size.height * 0.05 //0.03
      //         : attribute.iconsize,
      //     color: iconColor,
      //     semanticsLabel: attribute.title,
      //   ),
      // );
      Widget bottomNavWidget = Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
        child: Icon(
          attribute.icon!,
          color: attribute.color!,
          size: 35,
        ),
      );

      Widget _row = Column(
        children: [
          Expanded(
            // height: size.height*0.25,
            child: GridView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: attributeListLength,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCrossAxisCount,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                late bool isKilitli;
                var _kontrolEt = seciliGiysiDegerleri
                    .where(
                      (u) => (u.toString().toLowerCase().contains(
                            index.toString().toLowerCase(),
                          )),
                    )
                    .toList();

                if (_kontrolEt.length == 0) {
                  isKilitli = true;
                } else {
                  isKilitli = false;
                }

                if (index == i) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Colors.green,
                        width: 3.0,
                      ),
                    ),
                    child: SvgPicture.string(
                      fluttermojiController.getComponentSVG(attribute.key, i),
                      height: 20,
                      semanticsLabel: "Your Fluttermoji",
                      placeholderBuilder: (context) => Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                  );
                }

                return InkWell(
                  onTap: () {
                    fluttermojiController.selectedIndexes[attribute.key] =
                        index;
                    fluttermojiController.updatePreview();
                    setState(() {});
                  },
                  child: isKilitli != null
                      ? Stack(
                          alignment: AlignmentDirectional.center,
                          fit: StackFit.expand,
                          children: [
                            ColorFiltered(
                              colorFilter: isKilitli
                                  ? ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.multiply)
                                  : ColorFilter.mode(
                                      Colors.black.withOpacity(0.0),
                                      BlendMode.multiply,
                                    ),
                              child: Container(
                                color: Colors.grey.shade100,
                                child: SvgPicture.string(
                                  fluttermojiController.getComponentSVG(
                                      attribute.key, index),
                                  height: 20,
                                  semanticsLabel: 'Your Fluttermoji',
                                  placeholderBuilder: (context) => Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                ),
                              ),
                            ),
                            if (isKilitli)
                              Positioned(
                                top: 2,
                                right: 1,
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.yellow.shade600,
                                  size: 30,
                                ),
                              ),
                            if (isKilitli)
                              Positioned(
                                bottom: 1,
                                right: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: 25,
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "5",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        CustomIcon.diamond,
                                        color: Colors.blue.shade400,
                                        size: 19,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        )
                      : Container(),
                );
              },
            ),
          ),
        ],
      );
      attributeRows.add(_row);
      navbarWidgets.add(bottomNavWidget);
    });

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: size.width * widthFactor,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: DefaultTabController(
              length: attributeRows.length,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Scaffold(
                  key: ValueKey('FMojiCustomizer'),
                  backgroundColor: _bgcolor,
                  body: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        color: _appbarcolor, //Colors.grey[400],
                        child: TabBar(
                          controller: tabController,
                          isScrollable: true,
                          labelPadding: EdgeInsets.fromLTRB(0, 9, 0, 9),
                          indicatorColor: Colors.blue,
                          indicatorPadding: EdgeInsets.all(2),
                          tabs: navbarWidgets,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: ClampingScrollPhysics(),
                          controller: tabController,
                          children: attributeRows,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color? iconColor = (!isDarkMode) ? Colors.grey[700] : Colors.white;
    return Container(
      height: size.height * heightFactor,
      width: size.width,
      child: expandedCard(
        cardTitle: "Customize",
        attributes: attributesListe,
      ),
    );
  }
}
