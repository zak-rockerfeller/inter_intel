import 'dart:ui';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inter_intel/models/models.dart';
import 'package:inter_intel/services/services.dart';
import 'package:flutter_switch_clipper/flutter_switch_clipper.dart';
import 'package:inter_intel/screens/screens.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({Key? key}) : super(key: key);

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> with SingleTickerProviderStateMixin{
  Color baseColor = const Color(0xFFf2f2f2);
  double firstDepth = 50;
  double secondDepth = 50;
  double thirdDepth = 50;
  double fourthDepth = 50;
  late AnimationController _animationController;
  List<dynamic> userList = [];
  int userId = 0;
  bool _loading = true;
  final FillAlignment _alignment = FillAlignment.left;

  Future<void> retrieveCards() async{
    ApiResponse response = await getCards();

    if(response.error == null){
      setState(() {
        userList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });

    }
    else{
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.error),));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  void initState() {
    retrieveCards();
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? stagger(value, progress, delay) {
      progress = progress - (1 - delay);
      if (progress < 0) progress = 0;
      return value * (progress / delay);
    }

    double calculatedFirstDepth =
    stagger(firstDepth, _animationController.value, 0.25)!;
    double calculatedSecondDepth =
    stagger(secondDepth, _animationController.value, 0.5)!;
    double calculatedThirdDepth =
    stagger(thirdDepth, _animationController.value, 0.75)!;
    return RefreshIndicator(
      onRefresh: (){
        return retrieveCards();
      },
      child: Scaffold(
        body: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomLeft,
          secondaryEnd: Alignment.topRight,
          primaryColors: const [
            Colors.pink,
            Colors.pinkAccent,
            Colors.white,
          ],
          secondaryColors: const [
            Colors.white,
            Colors.blueAccent,
            Colors.blue,
          ],
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Design', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                pinned: true,
                leading: IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeftLong, color: Colors.blue,),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => NavScreen(selectedIndex: 1,),),);
                  },
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),

              SliverPadding(
                padding: const EdgeInsets.all(2),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            offset: const Offset(0.0, 1.0),
                            blurRadius: 6.0)
                      ],
                    ),
                    child: userList.isEmpty ?
                    const Center(child: CircularProgressIndicator()) :
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      scrollDirection: Axis.vertical,
                      itemCount: userList.length,
                      itemBuilder: (BuildContext context, int index) {
                        User popular = userList[index];
                        return Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child:BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 33,
                                        sigmaY: 65,
                                      ),
                                      child: Container(
                                        height: 90,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.black45,
                                            borderRadius: BorderRadius.circular(20.0),
                                            border: Border.all(width: 1.5, color: Colors.white.withOpacity(0.2))
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(popular.name!,style: const TextStyle(
                                              color: Colors.white, fontSize: 15.0,fontWeight: FontWeight.w500,letterSpacing: 0.5,),),
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.mail,
                                                  size: 15.0,
                                                  color: Colors.blue,
                                                ),
                                                const SizedBox(width: 3,),
                                                Flexible(
                                                  child: Text(popular.email!,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(color: Colors.white, fontSize: 14.0,fontWeight: FontWeight.w400,letterSpacing: 0.3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                                children: [
                                                  const Icon(
                                                    FontAwesomeIcons.phone,
                                                    size: 12.0,
                                                    color: Colors.blue,
                                                  ),
                                                  const SizedBox(width: 3,),
                                                  Text(popular.phone!,
                                                    style: const TextStyle(color: Colors.white, fontSize: 12.0,fontWeight: FontWeight.w400,letterSpacing: 0.6),)

                                                ]
                                            ),

                                          ],),
                                      ),
                                    ),

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child:BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 33,
                                        sigmaY: 65,
                                      ),
                                      child: Container(
                                        color: baseColor,
                                        child: Center(
                                          child: ClayContainer(
                                            color: baseColor,
                                            height: 70,
                                            width: 70,
                                            borderRadius: 50,
                                            curveType: CurveType.concave,
                                            spread: 30,
                                            depth: calculatedFirstDepth.toInt(),
                                            child: Center(
                                              child: ClayContainer(
                                                height: 50,
                                                width: 50,
                                                borderRadius: 30,
                                                depth: calculatedSecondDepth.toInt(),
                                                curveType: CurveType.convex,
                                                color: baseColor,
                                                child: Center(
                                                  child: ClayContainer(
                                                    height: 40,
                                                    width: 40,
                                                    borderRadius: 20,
                                                    color: baseColor,
                                                    depth: calculatedThirdDepth.toInt(),
                                                    curveType: CurveType.concave,
                                                    child: SwitchCipper(
                                                      background: const Icon(Icons.favorite, size: 20, color: Colors.blue),
                                                      curve: Curves.ease,
                                                      duration: const Duration(milliseconds: 2000),
                                                      customCipperBuilder: (Animation<double> animation) => FillClipper(
                                                        animation: animation,
                                                        fillAlignment: _alignment,
                                                        fillOffset: 50,
                                                      ),
                                                      child: const Icon(Icons.favorite, size: 20, color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),),

            ],
          ),
        ),
      ),
    );
  }
}
