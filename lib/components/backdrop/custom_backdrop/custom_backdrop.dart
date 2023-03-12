import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:ui';

class CustomBackdrop {
  /*
  * Backdrop
  * @return void
  */
  double defaultBorderRadius = 8.0;
  void bottomSheet(BuildContext contextParent, Widget customdata,
      {bool showPan = true}) {
    
    late final GlobalKey globalKeyColumn = GlobalKey();
    
    double parentHeight = 0;
    double childHeight = 0.0001;
    bool isScrollEnd = false;

    double maxExtent = 0;
    double extent = 0;

    DraggableScrollableController dragControl = DraggableScrollableController();

    Future<void> bottomSheetAwaitClose = showModalBottomSheet<void>(
        isDismissible: true,
        useRootNavigator: true,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: contextParent,
          builder: (BuildContext contextBuilder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
            double headerHeight = 30;
            MediaQueryData mediaQueryData = MediaQuery.of(context);

            double heightOfDevice = mediaQueryData.size.height;
            double notificationBarSize = MediaQueryData.fromWindow(window).padding.top;
            double paddingBottom = mediaQueryData.viewInsets.bottom;

            SchedulerBinding.instance.addPostFrameCallback((_) async {
              // ignore: prefer_typing_uninitialized_variables
              var renderBox;
              if (globalKeyColumn.currentContext?.findRenderObject() != null) {
                renderBox = globalKeyColumn.currentContext!.findRenderObject() as RenderBox;
              }
              setState((){
                parentHeight = (renderBox?.size.height + headerHeight + paddingBottom);
              });
              
              if(isScrollEnd && (extent - ((headerHeight + paddingBottom) /heightOfDevice)) > childHeight){
                await dragControl.animateTo(
                    maxExtent,
                    curve: Curves.easeOut,
                    duration: Duration(milliseconds: (parentHeight/7).round()),
                );
              }
              else if(isScrollEnd && (double.parse(dragControl.size.toStringAsFixed(1))  == extent)){
                Navigator.of(contextBuilder).maybePop();
              }
            });

            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: heightOfDevice - notificationBarSize),
              child: AnimatedContainer(
                //curve: Curves.bounceIn,
                height: parentHeight,
                duration: Duration(milliseconds: (parentHeight/7).round()),
                child: NotificationListener<DraggableScrollableNotification>(
                
                  onNotification: (notification) {
                    //identify drag down to not stop and close the bottomSheet directly
                    maxExtent = notification.maxExtent;
                    extent = double.parse(notification.extent.toStringAsFixed(1));
                    
                    return true;
                  },
                  child: DraggableScrollableSheet(
                    controller: dragControl,
                    initialChildSize: 1,
                    maxChildSize: 1,
                    minChildSize: childHeight,
                    expand: true,
                    builder: (context, scrollController) {
                    return
                      Container(
                        decoration: BoxDecoration(color: Colors.white,
                          borderRadius:
                          BorderRadius.only(
                            topLeft: Radius.circular(defaultBorderRadius),
                            topRight: Radius.circular(defaultBorderRadius),
                          ),),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: paddingBottom),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: headerHeight,
                                child: showPan ? botomSheetPan() : const SizedBox(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: NotificationListener<ScrollNotification>(
                                  onNotification: (notification){
                                    if (notification is ScrollStartNotification) {
                                     
                                        isScrollEnd = false;
                                    } else if (notification is ScrollUpdateNotification) {
                                        isScrollEnd = false;
                                    } else if (notification is ScrollEndNotification) {
                                        isScrollEnd = true;
                                    }
                                    return true;
                                  },
                                  child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    key: globalKeyColumn,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      customdata,
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),),
                                ))]),
                        ),
                      );
                    }),
                ),
              ),
            );
            });
          },
        );

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
