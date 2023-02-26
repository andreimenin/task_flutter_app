import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomBackdrop {
  // Widget customdata;
  // CustomBackdrop(this.customdata);
  /*
  * Backdrop
  * @return void
  */
  double defaultBorderRadius = 8.0;
  void bottomSheet(BuildContext contextParent, Widget customdata,
      {bool showPan = true}) {
    Future<void> bottomSheetAwaitClose = showModalBottomSheet<void>(
        enableDrag: true,
        isDismissible: true,
        useRootNavigator: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.only(
            topLeft: Radius.circular(defaultBorderRadius),
            topRight: Radius.circular(defaultBorderRadius),
          ),
        ),
        context: contextParent,
        builder: (BuildContext context) => ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(contextParent).size.height - MediaQuery.of(contextParent).viewPadding.top,
          ),
          child: Padding(
                padding: EdgeInsets.only(
              bottom: MediaQuery.of(contextParent).viewInsets.bottom),
                child: 
                    Stack(
                      children: [
                        SizedBox(
                          height: 30.0,
                          child: showPan ? botomSheetPan() : const SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SingleChildScrollView(
                                    child: Wrap(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            customdata,
                                            const SizedBox(
                                              height: 40,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )],
                    )
                          ,
              ),
        ));

    bottomSheetAwaitClose.then((void value) => {});
  }

  /*
  * Backdrop pan
  * @return void
  */
  static botomSheetPan() {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 32,
              height: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                   //Border.all
                  /*** The BorderRadius widget  is here ***/
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ), //BorderRadius.all
                ), //BoxDecoration
              )),
        ],
      ),
    );
  }

  void drawCupertinoModalBottomSheet(
    context,
    Widget child,
    Function isClosedFunction, {
    bool isDismissible = true,
    bool bounce = true,
    bool enableDrag = true,
    bool expanded = true,
  }) {
    _showCupertinoModalBottomSheet(context, child, isDismissible, bounce,
        enableDrag, expanded, defaultBorderRadius, isClosedFunction);
  }

  /*
  * Cupertino Modal
  * @return showCupertinoModalBottomSheet
  */
  static _showCupertinoModalBottomSheet(
      context,
      Widget child,
      bool isDismissible,
      bool bounce,
      bool enableDrag,
      bool expanded,
      double topRadius,
      Function isClosedFunction) {
    showCupertinoModalBottomSheet(
      topRadius: Radius.circular(topRadius),
      isDismissible: isDismissible,
      bounce: bounce,
      expand: expanded,
      enableDrag: enableDrag,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return child;
      }),
    ).whenComplete(() {
      isClosedFunction();
    });
  }
}
