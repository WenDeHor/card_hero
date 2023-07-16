import 'package:card_hero/menu/2_mine_screan.dart';
import 'package:card_hero/utils/image_and_name_from_list_user.dart';
import 'package:flutter/material.dart';
import 'package:card_hero/utils/constants.dart';

import '../model/user_model.dart';

ImageAndNameFromListUser imageAndNameFromListUser = ImageAndNameFromListUser();

class BuildCardView {

  Center buildCardViewBack(dynamic height, dynamic width,Image image) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radiusBorderCardView),
          // Image border
          child: SizedBox.fromSize(
              size: Size.fromRadius(radiusImageCardView), // Image radius
              child: image),
        ),
      ),
    );
  }

  Center buildCardViewFrontByList(List userssss) {
    return Center(
      child: SizedBox(
//        height: heightCardView, //450
//        width: widthCardView, //300
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radiusBorderCardView),
          child: SizedBox.fromSize(
              size: Size.fromRadius(radiusImageCardView),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  imageAndNameFromListUser.getImageByUser(user),
                  imageAndNameFromListUser.getNameByUser(user),
                ],
              )), // Image radius
//                        child:  getImage(userssss)),
        ),
      ),
    );
  }

  Center buildCardViewFrontByUser(dynamic height, dynamic width, User user) {
    return Center(
      child: SizedBox(
        height: height, //450
        width: width, //300
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radiusBorderCardView),
          child: SizedBox.fromSize(
              size: Size.fromRadius(radiusImageCardView),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  imageAndNameFromListUser.getImageByUser(user),
                  imageAndNameFromListUser.getNameByUser(user),
                ],
              )), // Image radius
//                        child:  getImage(userssss)),
        ),
      ),
    );
  }
}
