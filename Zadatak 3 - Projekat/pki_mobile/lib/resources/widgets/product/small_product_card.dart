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

class SmallProductCard extends StatelessWidget {
  final Product product;
  final Function onTap;

  const SmallProductCard({
    Key key,
    @required this.product,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color_white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 130.0,
              height: 130.0,
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
                child: Image.memory(base64Decode(product.image)),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    product.name,
                    minFontSize: 24,
                    style: GoogleFonts.pacifico(
                      color: color_black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AutoSizeText(
                    "Cena: ${product.price} din",
                    minFontSize: 24,
                    style: GoogleFonts.pacifico(
                      color: color_black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
