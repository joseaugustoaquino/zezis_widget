import 'package:flutter/material.dart';
import 'package:zezis_widget/src/components/credit_card/z_card_type_enum.dart';

class CreditCardBrand {
  CreditCardBrand(
    this.brandName
  );

  CardType? brandName;
}

class CreditCardModel {
  CreditCardModel(
    this.cardNumber, 
    this.expiryDate, 
    this.cardHolderName,
    this.cvvCode, 
    this.isCvvFocused
  );

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
}

class CustomCardTypeIcon {
  CustomCardTypeIcon({
    required this.cardType,
    required this.cardImage,
  });

  CardType cardType;
  Widget cardImage;
}
