import 'package:flutter/material.dart';
import 'package:task_flutter_app/components/skeleton.dart';


class ImageCustom extends StatefulWidget {
  final String image;
  final bool showProgressIndicator;
  final bool showProgressPercent;

  const ImageCustom({Key? key, required this.image, this.showProgressIndicator = true, this.showProgressPercent = true}) : super(key: key);

  @override
  createState() => ImageCustomState();
}

class ImageCustomState extends State<ImageCustom> with AutomaticKeepAliveClientMixin{
  bool loading = false;
  bool _isLoaded = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
      FlutterError.onError = (FlutterErrorDetails details) {
      if (details.library == 'image resource service') {
        return;
      }
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Visibility(
          maintainState: true,
          visible: loading && !_isLoaded,
          child: const Skeleton()),
        Container(
          constraints: const BoxConstraints.expand(),
          child: 
          Image.network(
            widget.image,
            fit: BoxFit.cover,
            errorBuilder: ((context, error, stackTrace) {
              if(!_isLoaded){
                // ignore: avoid_print
                print('\x1B[33m$error\x1B[0m');
                Future.delayed(Duration.zero, () async {
                  setState(() {
                    _isLoaded = true;
                    isError = true;
                  });
                });
              }
               return Container(
                decoration: const BoxDecoration(color: Color.fromARGB(255, 206, 204, 204)),
                child: Image.asset('assets/images/nophoto.png'));
            }),
            loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
               // print("loadingBuilder" + loadingProgress.toString());
                if (loadingProgress == null && _isLoaded) {
                  // The child (AnimatedOpacity) is build with loading == true, and then the setState will change loading to false, which trigger the animation
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Future.delayed(Duration.zero, () async {
                      if (mounted && loading) {
                        setState(() {
                          loading = false;
                        });
                      }
                    });
                  });
                  return child;
                }

              if(!loading){
                Future.delayed(Duration.zero, () async {
                  setState(() {
                    loading = true;
                  });
                });
              }
            
                return (widget.showProgressIndicator || widget.showProgressPercent) && loadingProgress != null?
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        widget.showProgressPercent ? 
                        Text(
                          ((loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!)*100).toStringAsFixed(0),
                          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 12),
                                ) : Container(),
                        widget.showProgressIndicator ? 
                        CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ) : Container()],
                    ),) : Container();
              },
            frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
              //print("framebuilder " + frame.toString());
              _isLoaded = frame != null;

              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                opacity: loading == true ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: child,
              );
            },
        ),
      ),
      ],
    ); 
  }
  
}