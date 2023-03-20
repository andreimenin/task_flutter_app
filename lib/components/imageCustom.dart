// ignore: file_names
import 'package:flutter/material.dart';
import 'package:task_flutter_app/components/skeleton.dart';

class ImageCustom extends StatefulWidget {
  final String image;
  final bool isWithProgressIndicator;

  const ImageCustom({Key? key, required this.image, this.isWithProgressIndicator = false}) : super(key: key);

  @override
  createState() => ImageCustomState();
}

class ImageCustomState extends State<ImageCustom> {

  bool loading = true;
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Visibility(
          maintainState: true,
          visible: loading == true,
          child: const Skeleton()),
        Container(
          constraints: const BoxConstraints.expand(),
          child: 
          Image.network(
            widget.image,
            fit: BoxFit.cover,
            errorBuilder: ((context, error, stackTrace) {
               return 
               Image(
                  image: const AssetImage('assets/images/nophoto.png'),
                  frameBuilder: (BuildContext? context, Widget? child, int? frame, bool wasSynchronouslyLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: child,
                    );
                  },
                );
            }),
            loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  // The child (AnimatedOpacity) is build with loading == true, and then the setState will change loading to false, which trigger the animation
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Future.delayed(Duration.zero, () async {
                    setState(() {
                        loading = false;
                      });
                    });
                  });
                  return child;
                }
                Future.delayed(Duration.zero, () async {
              setState(() {
                  loading = true;
                });
              });
            
                return widget.isWithProgressIndicator ?
                  Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),) : Container();
              },
            frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              // Future.delayed(Duration.zero, () async {
              // setState(() {
              //     loading = true;
              //   });
              // });
              return AnimatedOpacity(
                opacity: loading == true ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: child,
                onEnd: () {
                  print("aaaaaaaa");
                  return setState(() {
                        loading = false;
                      });
                    }
              );
            },
        ),
      )],
    ); 
  }
  
}