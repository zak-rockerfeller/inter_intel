import 'dart:ui';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inter_intel/models/models.dart';
import 'package:inter_intel/services/services.dart';


class ResponseScreen extends StatefulWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  List<dynamic> userList = [];
  int userId = 0;
  bool _loading = true;

  Future<void> retrieveCards() async{
    ApiResponse response = await getTodo();

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
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.pink,
          Colors.grey,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.white,
          Colors.amber,
          Colors.blue,
        ],
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Response', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
              pinned: true,
              leading: IconButton(
                icon: const Icon(FontAwesomeIcons.arrowLeftLong, color: Colors.blue,),
                onPressed: () {},
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
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      ToDo popular = userList[index];
                      return Stack(
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
                                  //height: 90,
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(width: 1.5, color: Colors.white.withOpacity(0.2))
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(popular.title!,style: const TextStyle(
                                        color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.bold,letterSpacing: 0.7,),),
                                      const SizedBox(height: 5,),
                                      Text(popular.completed.toString()!,style: const TextStyle(
                                        color: Colors.white, fontSize: 14.0,fontWeight: FontWeight.w500,letterSpacing: 0.5,),),

                                    ],),
                                ),
                              ),

                            ),
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
    );
  }
}
