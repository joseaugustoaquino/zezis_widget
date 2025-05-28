// ignore_for_file: constant_identifier_names, deprecated_member_use, library_private_types_in_public_api
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:zezis_widget/src/components/credit_card/glassmorphism_config.dart';
import 'package:zezis_widget/src/components/credit_card/z_card_type_enum.dart';
import 'package:zezis_widget/src/components/credit_card/z_credit_model.dart';

const Map<CardType, String> CardTypeIconAsset = <CardType, String>{
  CardType.visa: 'assets/icons/credit_card/visa.png',
  CardType.americanExpress: 'assets/icons/credit_card/amex.png',
  CardType.mastercard: 'assets/icons/credit_card/mastercard.png',
  CardType.discover: 'assets/icons/credit_card/discover.png',
};

class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget(
      {super.key,
      required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode,
      required this.showBackView,
      this.bankName,
      this.animationDuration = const Duration(milliseconds: 500),
      this.height,
      this.width,
      this.textStyle,
      this.cardBgColor = const Color(0xff1b447b),
      this.obscureCardNumber = true,
      this.obscureCardCvv = true,
      this.labelCardHolder = 'CARD HOLDER',
      this.labelExpiredDate = 'MM/YY',
      this.cardType,
      this.isHolderNameVisible = false,
      this.backgroundImage,
      this.backgroundNetworkImage,
      this.glassmorphismConfig,
      this.isChipVisible = true,
      this.isSwipeGestureEnabled = true,
      this.customCardTypeIcons = const <CustomCardTypeIcon>[],
      this.chipColor});

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final TextStyle? textStyle;
  final Color cardBgColor;
  final bool showBackView;
  final String? bankName;
  final Duration animationDuration;
  final double? height;
  final double? width;
  final bool obscureCardNumber;
  final bool obscureCardCvv;
  final bool isHolderNameVisible;
  final String? backgroundImage;
  final String? backgroundNetworkImage;
  final Color? chipColor;
  final bool isChipVisible;
  final Glassmorphism? glassmorphismConfig;
  final bool isSwipeGestureEnabled;

  final String labelCardHolder;
  final String labelExpiredDate;

  final CardType? cardType;
  final List<CustomCardTypeIcon> customCardTypeIcons;

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;
  late Gradient backgroundGradientColor;
  late bool isFrontVisible = true;
  late bool isGestureUpdate = false;

  bool isAmex = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _gradientSetup();
    _updateRotations(false);
  }

  void _gradientSetup() {
    backgroundGradientColor = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const <double>[0.1, 0.4, 0.7, 0.9],
      colors: <Color>[
        widget.cardBgColor.withOpacity(1),
        widget.cardBgColor.withOpacity(0.97),
        widget.cardBgColor.withOpacity(0.90),
        widget.cardBgColor.withOpacity(0.86),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isGestureUpdate) {
      _updateRotations(false);
      if (widget.showBackView) {
        controller.forward();
      } else {
        controller.reverse();
      }
    } else {
      isGestureUpdate = false;
    }

    return Stack(
      children: [
        _cardGesture(
          child: AnimationCard(
            animation: _frontRotation,
            child: _buildFrontContainer(),
          ),
        ),
        _cardGesture(
          child: AnimationCard(
            animation: _backRotation,
            child: _buildBackContainer(),
          ),
        ),
      ],
    );
  }

  void _leftRotation() => _toggleSide(false);

  void _rightRotation() => _toggleSide(true);

  void _toggleSide(bool isRightTap) {
    _updateRotations(!isRightTap);

    if (isFrontVisible) {
      controller.forward();
      isFrontVisible = false;
    } else {
      controller.reverse();
      isFrontVisible = true;
    }
  }

  void _updateRotations(bool isRightSwipe) {
    setState(() {
      final bool rotateToLeft =
        (isFrontVisible && !isRightSwipe) || !isFrontVisible && isRightSwipe;

      _frontRotation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            weight: 50.0,
            tween: Tween<double>(
              begin: 0.0, 
              end: rotateToLeft ? (pi / 2) : (-pi / 2)
            ).chain(CurveTween(curve: Curves.linear)),
          ),
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(rotateToLeft ? (-pi / 2) : (pi / 2)),
            weight: 50.0,
          ),
        ],
      ).animate(controller);

      _backRotation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(rotateToLeft ? (pi / 2) : (-pi / 2)),
            weight: 50.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: rotateToLeft ? (-pi / 2) : (pi / 2), 
              end: 0.0
            ).chain(
              CurveTween(curve: Curves.linear),
            ),
            weight: 50.0,
          ),
        ],
      ).animate(controller);
    });
  }

  Widget _buildFrontContainer() {
    final TextStyle defaultTextStyle =
    Theme.of(context).textTheme.headlineMedium!.merge(
      const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );

    String number = widget.cardNumber;
    
    if (widget.obscureCardNumber) {
      final String stripped = number.replaceAll(RegExp(r'[^\d]'), '');
      if (stripped.length > 8) {
        final String middle = number
            .substring(4, number.length - 5)
            .trim()
            .replaceAll(RegExp(r'\d'), '*');
        number = '${stripped.substring(0, 4)} $middle ${stripped.substring(stripped.length - 4)}';
      }
    }
   
    return CardBackground(
      backgroundImage: widget.backgroundImage,
      backgroundNetworkImage: widget.backgroundNetworkImage,
      backgroundGradientColor: backgroundGradientColor,
      glassmorphismConfig: widget.glassmorphismConfig,
      height: widget.height,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.bankName != null && widget.bankName!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                widget.bankName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: defaultTextStyle,
              ),
            ),
          
          Expanded(
            flex: widget.isChipVisible ? 1 : 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (widget.isChipVisible)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.asset(
                      'assets/icons/credit_card/chip.png',
                      color: widget.chipColor,
                      scale: 1,
                    ),
                  ),
                
                const Spacer(),
                
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: widget.cardType != null
                        ? getCardTypeImage(widget.cardType)
                        : getCardTypeIcon(widget.cardNumber),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 10),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                widget.cardNumber.isEmpty ? 'XXXX XXXX XXXX XXXX' : number,
                style: widget.textStyle ?? defaultTextStyle,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Válido\naté',
                    style: widget.textStyle ?? defaultTextStyle.copyWith(fontSize: 7),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(width: 5),
                  
                  Text(
                    widget.expiryDate.isEmpty
                        ? widget.labelExpiredDate
                        : widget.expiryDate,
                    style: widget.textStyle ?? defaultTextStyle,
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: widget.isHolderNameVisible,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(
                  widget.cardHolderName.isEmpty
                      ? widget.labelCardHolder
                      : widget.cardHolderName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: widget.textStyle ?? defaultTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackContainer() {
    final TextStyle defaultTextStyle =
    Theme.of(context).textTheme.titleLarge!.merge(
      const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );

    final String cvv = widget.obscureCardCvv
        ? widget.cvvCode.replaceAll(RegExp(r'\d'), '*')
        : widget.cvvCode;

    return CardBackground(
      backgroundImage: widget.backgroundImage,
      backgroundNetworkImage: widget.backgroundNetworkImage,
      backgroundGradientColor: backgroundGradientColor,
      glassmorphismConfig: widget.glassmorphismConfig,
      height: widget.height,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              height: 48,
              color: Colors.black,
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      height: 48,
                      color: Colors.white70,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          widget.cvvCode.isEmpty
                              ? isAmex
                                  ? 'XXXX'
                                  : 'XXX'
                              : cvv,
                          maxLines: 1,
                          style: widget.textStyle ?? defaultTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: widget.cardType != null
                    ? getCardTypeImage(widget.cardType)
                    : getCardTypeIcon(widget.cardNumber),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardGesture({required Widget child}) {
    bool isRightSwipe = true;
    return widget.isSwipeGestureEnabled
        ? GestureDetector(
            onPanEnd: (_) {
              isGestureUpdate = true;
              if (isRightSwipe) {
                _leftRotation();
              } else {
                _rightRotation();
              }
            },
            onPanUpdate: (DragUpdateDetails details) {
              if (details.delta.dx > 0) {
                isRightSwipe = true;
              }

              if (details.delta.dx < 0) {
                isRightSwipe = false;
              }
            },
            child: child,
          )
        : child;
  }

  Map<CardType, Set<List<String>>> cardNumPatterns =
      <CardType, Set<List<String>>>{
    CardType.visa: <List<String>>{
      <String>['4'],
    },
    CardType.americanExpress: <List<String>>{
      <String>['34'],
      <String>['37'],
    },
    CardType.discover: <List<String>>{
      <String>['6011'],
      <String>['622126', '622925'],
      <String>['644', '649'],
      <String>['65']
    },
    CardType.mastercard: <List<String>>{
      <String>['51', '55'],
      <String>['2221', '2229'],
      <String>['223', '229'],
      <String>['23', '26'],
      <String>['270', '271'],
      <String>['2720'],
    },
  };

  CardType detectCCType(String cardNumber) {
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          String ccPatternStr = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;

          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt && ccPrefixAsInt <= endPatternPrefixAsInt) {
              cardType = type;
              break;
            }
          } 
          else {
            if (ccPatternStr == patternRange[0]) {
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }

  Widget getCardTypeImage(CardType? cardType) {
    final List<CustomCardTypeIcon> customCardTypeIcon = getCustomCardTypeIcon(cardType!);
    if (customCardTypeIcon.isNotEmpty) {
      return customCardTypeIcon.first.cardImage;
    } else {
      return Image.asset(
        CardTypeIconAsset[cardType]!,
        width: 48,
        height: 48,
      );
    }
  }

  Widget getCardTypeIcon(String cardNumber) {
    Widget icon;
    final CardType ccType = detectCCType(cardNumber);
    final List<CustomCardTypeIcon> customCardTypeIcon = getCustomCardTypeIcon(ccType);
   
    if (customCardTypeIcon.isNotEmpty) {
      icon = customCardTypeIcon.first.cardImage;
      isAmex = ccType == CardType.americanExpress;
    } 
    else {
      switch (ccType) {
        case CardType.visa:
          icon = Image.asset(
            CardTypeIconAsset[ccType]!,
            height: 48,
            width: 48,
          );
          isAmex = false;
          break;

        case CardType.americanExpress:
          icon = Image.asset(
            CardTypeIconAsset[ccType]!,
            height: 48,
            width: 48,
          );
          isAmex = true;
          break;

        case CardType.mastercard:
          icon = Image.asset(
            CardTypeIconAsset[ccType]!,
            height: 48,
            width: 48,
          );
          isAmex = false;
          break;

        case CardType.discover:
          icon = Image.asset(
            CardTypeIconAsset[ccType]!,
            height: 48,
            width: 48,
          );
          isAmex = false;
          break;

        default:
          icon = const SizedBox(
            height: 48,
            width: 48,
          );
          isAmex = false;
          break;
      }
    }

    return icon;
  }

  List<CustomCardTypeIcon> getCustomCardTypeIcon(CardType currentCardType) =>
    widget.customCardTypeIcons
      .where((CustomCardTypeIcon element) => element.cardType == currentCardType)
      .toList();
}

class MaskedTextController extends TextEditingController {
  MaskedTextController({super.text, required this.mask, Map<String, RegExp>? translator}) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    addListener(() {
      final String previous = _lastUpdatedText;
      
      if (beforeChange(previous, text)) {
        updateText(text);
        afterChange(previous, text);
      } 
      else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(text);
  }

  String mask;
  String _lastUpdatedText = '';
  late Map<String, RegExp> translator;
  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) => true;


  void updateText(String text) {
    if (text.isNotEmpty) {
      this.text = _applyMask(mask, text);
    } 
    else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    final String text = _lastUpdatedText;
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return <String, RegExp>{
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  String _applyMask(String? mask, String value) {
    String result = '';

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      if (maskCharIndex == mask!.length) {
        break;
      }

      if (valueCharIndex == value.length) {
        break;
      }

      final String maskChar = mask[maskCharIndex];
      final String valueChar = value[valueCharIndex];

      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      if (translator.containsKey(maskChar)) {
        if (translator[maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}


class AnimationCard extends StatelessWidget {
  const AnimationCard({super.key, 
    required this.child,
    required this.animation,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final Matrix4 transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        transform.rotateY(animation.value);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}

class CardBackground extends StatelessWidget {
  const CardBackground({
    super.key,
    required this.backgroundGradientColor,
    this.backgroundImage,
    this.backgroundNetworkImage,
    required this.child,
    this.width,
    this.height,
    this.glassmorphismConfig,
  })  
  : assert(
    (backgroundImage == null && backgroundNetworkImage == null) ||
    (backgroundImage == null && backgroundNetworkImage != null) ||
    (backgroundImage != null && backgroundNetworkImage == null),
    "Você não pode usar imagem de rede e imagem de ativo ao mesmo tempo para plano de fundo do cartão.");

  final String? backgroundImage;
  final String? backgroundNetworkImage;
  final Widget child;
  final Gradient backgroundGradientColor;
  final Glassmorphism? glassmorphismConfig;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
      
      final double screenWidth = constraints.maxWidth.isInfinite
          ? MediaQuery.of(context).size.width
          : constraints.maxWidth;
      final double screenHeight = MediaQuery.of(context).size.height;
      
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(AppConstants.creditCardPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: glassmorphismConfig != null
                  ? glassmorphismConfig!.gradient
                  : backgroundGradientColor,
              image: backgroundImage != null && backgroundImage!.isNotEmpty
                  ? DecorationImage(
                      image: ExactAssetImage(
                        backgroundImage!,
                      ),
                      fit: BoxFit.fill,
                    )
                  : backgroundNetworkImage != null && backgroundNetworkImage!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(
                            backgroundNetworkImage!,
                          ),
                          fit: BoxFit.fill,
                        )
                      : null,
            ),
            width: width ?? screenWidth,
            height: height ??
                (orientation == Orientation.portrait
                    ? (((width ?? screenWidth) -
                            (AppConstants.creditCardPadding * 2)) *
                        AppConstants.creditCardAspectRatio)
                    : screenHeight / 2),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                child: glassmorphismConfig != null
                    ? BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: glassmorphismConfig?.blurX ?? 0.0,
                          sigmaY: glassmorphismConfig?.blurY ?? 0.0,
                        ),
                        child: child,
                      )
                    : child,
              ),
            ),
          ),
          if (glassmorphismConfig != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: _GlassmorphicBorder(
                width: width ?? screenWidth,
                height: height ??
                    (orientation == Orientation.portrait
                        ? ((screenWidth - 32) * 0.5714)
                        : screenHeight / 2),
              ),
            ),
        ],
      );
    });
  }
}

class _GlassmorphicBorder extends StatelessWidget {
  _GlassmorphicBorder({
    required this.height,
    required this.width,
  }) : _painter = _GradientPainter(strokeWidth: 2, radius: 10);
  final _GradientPainter _painter;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      size: MediaQuery.of(context).size,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: width,
        height: height,
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  _GradientPainter({required this.strokeWidth, required this.radius});

  final double radius;
  final double strokeWidth;
  final Paint paintObject = Paint();
  final Paint paintObject2 = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final LinearGradient gradient = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: <Color>[
          Colors.white.withAlpha(50),
          Colors.white.withAlpha(55),
          Colors.white.withAlpha(50),
        ],
        stops: const <double>[
          0.06,
          0.95,
          1
        ]);
    final RRect innerRect2 = RRect.fromRectAndRadius(
        Rect.fromLTRB(strokeWidth, strokeWidth, size.width - strokeWidth,
            size.height - strokeWidth),
        Radius.circular(radius - strokeWidth));

    final RRect outerRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(0, 0, size.width, size.height), Radius.circular(radius));
    paintObject.shader = gradient.createShader(Offset.zero & size);

    final Path outerRectPath = Path()..addRRect(outerRect);
    final Path innerRectPath2 = Path()..addRRect(innerRect2);
    canvas.drawPath(
        Path.combine(
            PathOperation.difference,
            outerRectPath,
            Path.combine(
                PathOperation.intersect, outerRectPath, innerRectPath2)),
        paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AppConstants {
  static const double webBreakPoint = 800;
  static const double creditCardAspectRatio = 0.5714;
  static const double creditCardPadding = 16;
}
