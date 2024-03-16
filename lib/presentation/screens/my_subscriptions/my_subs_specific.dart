import 'dart:math';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/presentation/screens/feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_icon/animated_icon.dart';

class MySpecificSubsPage extends StatelessWidget {
   MySpecificSubsPage({super.key,required this.state,required this.index});

  MySubscritpionsLoadedState state;
  int index;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(state.mySubsList[index].sub_photo),
            ),
            SizedBox(width: 8), // Add some space between CircleAvatar and Text
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    state.mySubsList[index].sub_title,
                    style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),   
          ],
        ),
      ),



      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
             (state.mySubsList[index].subscriptionDetails['videos']?.length > 0)?
              Container(
                height: screenHeight-(screenHeight/7),
                width: screenWidth-20,
                // color: Colors.amber,
                child: ListView.builder(
                  itemCount: state.mySubsList[index].subscriptionDetails['videos']?.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnyLinkPreview(
                                      link: state.mySubsList[index].subscriptionDetails['videos'][i],
                                      displayDirection: UIDirection.uiDirectionHorizontal, 
                                      cache: Duration(hours: 1),
                                      boxShadow: [],
                                      removeElevation: false,
                                      backgroundColor: Colors.grey[100], 
                                      errorWidget: Container(
                                      color: Colors.grey[300], 
                                      child: Text('404! Not Found'), 
                                      ),
                                      ),
                    );
                  },
                  ),
              ):Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight/6,),
                  // Text("Error loading playlist."),
                  CachedNetworkImage(imageUrl: "https://miro.medium.com/v2/resize:fit:1358/0*QOZm9X5er1Y0r5-t",
                  colorBlendMode: BlendMode.difference),
                  SizedBox(height: 30,),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FeedBackPage(),));
                  }, child: Text("Report issue !",style: TextStyle(fontSize: 15),))
                ],
              ))
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: state.mySubsList[index].guide_id != '0'
    ? FloatingActionButton(
      backgroundColor: Colors.blueGrey,
      splashColor: Colors.blue,
      onPressed: (){}, 
      // label: Text("Chat with mentor"),
      child: AnimateIcon(
        key: UniqueKey(),
        onTap: () {},
        iconType: IconType.continueAnimation,
        height: 40,
        width: 40,
        color: Color.fromARGB(255, 241, 241, 241),
        animateIcon: AnimateIcons.chatMessage,
    ))
    : FloatingActionButton.extended(
      backgroundColor: Colors.blueGrey,
      splashColor: Colors.blue,
      onPressed: (){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Sorry for the delay. Still searching for mentors apt for you.",
            style: GoogleFonts.poppins(fontSize: 15),),
          );
        },);
      }, 
      label: Text("Exploring mentors tailored for you !",style: TextStyle(color: Colors.white),),
      icon: AnimateIcon(
        key: UniqueKey(),
        onTap: () {},
        iconType: IconType.continueAnimation,
        height: 70,
        width: 70,
        color: Color.fromARGB(255, 110, 138, 185),
        animateIcon: AnimateIcons.clock,
    )
      ),

    );
  }
}