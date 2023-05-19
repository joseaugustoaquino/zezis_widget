import 'package:flutter/material.dart';
import 'package:zezis_widget/z_notification/z_alert_custom_gif/z_alert_gif.dart';
import 'package:zezis_widget/z_notification/z_alert_custom_gif/z_alert_animation.dart';


class ZAlertCustomGif extends StatefulWidget {
  final String? title;
  final String? description;

  final String? gifPath;
  final double? animationType;
  final TextStyle? style;

  final String? oneButton;
  final Function? oneButtonFunction;
  final String? twoButton;
  final Function? twoButtonFunction;

  const ZAlertCustomGif({
    Key? key,
    required this.title,
    required this.description,

    this.gifPath = ZAlertGif.shareGif,
    this.animationType = ZAlertAnimaation.bottomTop,
    this.style,

    this.oneButton,
    this.oneButtonFunction,
    this.twoButton,
    this.twoButtonFunction,
  }) : super(key: key);

  @override
  ZAlertCustomGifState createState() => ZAlertCustomGifState();
}

class ZAlertCustomGifState extends State<ZAlertCustomGif> with TickerProviderStateMixin {
  AnimationController? ac;
  Animation? animation;
  var animationAxis = 0; 
  
  @override
  void initState() {
    var start = ZAlertAnimaation.leftRight;

    switch (widget.animationType) {
      case ZAlertAnimaation.leftRight: start = -1.0; break;
      case ZAlertAnimaation.rightLeft: start = 1.0; break;
      case ZAlertAnimaation.topBottom: start = -1.0; break;
      case ZAlertAnimaation.bottomTop: start = 1.0; break;
    }

    if (widget.animationType?.abs() == 2) animationAxis = 1;

    ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    animation = Tween(begin: start, end: 0.0).animate(CurvedAnimation(parent: ac!, curve: Curves.easeIn));
    animation?.addListener(() => setState(() {}));

    ac?.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),

      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        child: Container(
          width: 0.36 * MediaQuery.of(context).size.height,

          transform: Matrix4.translationValues(
            animationAxis == 0 ? animation!.value * MediaQuery.of(context).size.width : 0,
            animationAxis == 1 ? animation!.value * MediaQuery.of(context).size.width : 0,
            0,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.gifPath != null ? ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  widget.gifPath!,
                  fit: BoxFit.fill,
                ),
              ) : const SizedBox(),

              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  widget.title ?? "",
                  textAlign: TextAlign.center,
                  style: widget.style ?? const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  widget.description ?? "",
                  style: widget.style ?? const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                )
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  widget.oneButtonFunction == null ? const SizedBox() : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Text(
                      widget.oneButton ?? "",
                      style: widget.style ?? const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.oneButtonFunction!();
                    },
                  ),

                  widget.oneButtonFunction == null ? const SizedBox() : const SizedBox(width: 10),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Text(
                      widget.twoButton ?? "",
                      style: widget.style ?? const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      widget.twoButtonFunction!();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
