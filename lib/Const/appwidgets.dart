import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget placeholderWidget() => Image.asset('images/LikeButton/image/grey.jpg', fit: BoxFit.cover);

AppStore appStore = AppStore();

class AppStore {
  Color textPrimaryColor = const Color(0xFF212121);
  Color iconColorPrimaryDark = const Color(0xFF212121);
  Color scaffoldBackground = const Color(0xFFEBF2F7);
  Color backgroundColor = Colors.black;
  Color backgroundSecondaryColor = const Color(0xFF131d25);
  Color appColorPrimaryLightColor = const Color(0xFFF9FAFF);
  Color textSecondaryColor = const Color(0xFF5A5C5E);
  Color appBarColor = Colors.white;
  Color iconColor = const Color(0xFF212121);
  Color iconSecondaryColor = const Color(0xFFA8ABAD);
  Color cardColor = Colors.white;
  Color appColorPrimary = const Color(0xFF1157FA);
  Color scaffoldBackgroundColor = const Color(0xFFEFEFEF);

  AppStore();
}

Widget text(
  String? text, {
  var fontSize = 18.0,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: textColor ?? const Color(0xFF5A5C5E),
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? const Color(0xFFEBF2F7),
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: const Color(0x95E9EBF0))
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

Widget commonCacheImageWidget(String? url, double height,
    {double? width, BoxFit? fit}) {
  if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      placeholder: (context, url) => placeholderWidget(),
      imageUrl: '$url',
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      errorWidget: (_, __, ___) {
        return SizedBox(height: height, width: width);
      },
    );
  } else {
    return Image.asset(url!,
        height: height, width: width, fit: fit ?? BoxFit.cover);
  }
}

AppBar appBar(BuildContext context, String title,
    {List<Widget>? actions,
    bool showBack = true,
    Color? color,
    Color? iconColor,
    Color? textColor}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: color ?? appStore.appBarColor,
    leading: showBack
        ? IconButton(
            onPressed: () {
              finish(context);
            },
            icon: const Icon(Icons.arrow_back, color: white),
          )
        : null,
    title:
        appBarTitleWidget(context, title, textColor: textColor, color: color),
    actions: actions,
  );
}

Widget appBarTitleWidget(context, String title,
    {Color? color, Color? textColor}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    color: color ?? appStore.appBarColor,
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: boldTextStyle(
              color: color ?? appStore.textPrimaryColor, size: 20),
          maxLines: 1,
        ).expand(),
      ],
    ),
  );
}

Widget? Function(BuildContext, String) placeholderWidgetFn() => (_, s) => placeholderWidget();


class CustomTheme extends StatelessWidget {
  final Widget? child;

  const CustomTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: child!,
    );
  }
}
Widget divider() {
  return const Divider(
    height: 0.5,
    color: Color(0xFFeaeaea),
  );
}