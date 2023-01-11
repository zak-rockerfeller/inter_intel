import 'package:animate_gradient/animate_gradient.dart';
import 'package:inter_intel/screens/screens.dart';
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
      backgroundColor: Colors.grey,
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
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      ToDo popular = userList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                        child: Container(
                          //height: 80,
                          padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                             color: Colors.black12,
                             borderRadius: BorderRadius.circular(20.0),
                             border: Border.all(width: 1.5, color: Colors.white.withOpacity(0.2))
                                    ),
                          child: ListTile(
                            minVerticalPadding: 5,
                            contentPadding: const EdgeInsets.all(10),
                            leading: const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage("assets/images/logo.png"),
                            ),
                            title: Text(popular.title.toString(),style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500,letterSpacing: 0.3,),),
                            trailing: Text(popular.completed.toString(),style: const TextStyle(fontSize: 15.0,fontWeight: FontWeight.w400,letterSpacing: 0.5,),),
                          ),
                        ),
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
