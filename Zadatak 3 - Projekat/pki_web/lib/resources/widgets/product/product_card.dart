import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/data/beans/product.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/data/beans/order.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_orange_button.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_incrementer/hexagon_incrementer.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onTap;
  final Function addInBasket;
  final int quantity;
  final Function onPressedUp;
  final Function onPressedDown;

  const ProductCard({
    Key key,
    @required this.product,
    @required this.onTap,
    @required this.addInBasket,
    @required this.quantity,
    @required this.onPressedUp,
    @required this.onPressedDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: AutoSizeText(
            product.name,
            minFontSize: 40,
            style: GoogleFonts.pacifico(
              color: color_black,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(top: 15, bottom: 50),
        ),
        Container(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 250,
                    height: 250,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: color_black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: color_black,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        base64Decode(product.image),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "Cena: ${product.price} din",
                          minFontSize: 24,
                          style: GoogleFonts.pacifico(
                            color: color_black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                        ),
                        AutoSizeText(
                          "Opis: ${product.description}",
                          minFontSize: 24,
                          style: GoogleFonts.pacifico(
                            color: color_black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                        ),
                        AutoSizeText(
                          "Način korišćenja: ${product.manual}",
                          minFontSize: 24,
                          style: GoogleFonts.pacifico(
                            color: color_black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          width: 500,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: HexagonIncrementer(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: HexagonButton(
                  text: "Dodajte u korpu",
                  onPressed: addInBasket,
                  width: 250,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
