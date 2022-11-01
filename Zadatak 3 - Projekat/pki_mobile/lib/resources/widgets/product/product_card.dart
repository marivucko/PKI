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
          child: Column(
            children: [
              Container(
                width: 230,
                height: 230,
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: color_black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: color_black,
                ),
                child: Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.memory(
                      base64Decode(product.image),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24),
                      ),
                      AutoSizeText(
                        "Cena: ${product.price} din",
                        minFontSize: 24,
                        style: GoogleFonts.pacifico(
                          color: color_black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 24),
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
                        margin: EdgeInsets.only(top: 24),
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
                      Container(
                        margin: EdgeInsets.only(top: 24),
                      ),
                      Center(
                        child: Column(
                          children: [
                            HexagonIncrementer(),
                            Container(
                              margin: EdgeInsets.only(top: 24),
                            ),
                            HexagonButton(
                              width: 250,
                              text: "Dodajte u korpu",
                              onPressed: addInBasket,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 24),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
