import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:code_geeks/presentation/screens/my_subscriptions/my_subs_specific.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MySubscriptionsPage extends StatelessWidget {
  const MySubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    context.read<SubscriptionBloc>().add(MySubscritpionLoadEvent(uid: currentUser));
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Subscriptions"),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<SubscriptionBloc, SubscriptionState>(
                  builder: (context, state) {
                    if(state is MySubscritpionsLoadedState){
                      return Container(
                                  height: screenHeight-screenHeight/7,
                                  width: screenWidth-40,
                                  child: ListView.builder(
                                    itemCount: state.mySubsList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          shape: ContinuousRectangleBorder(
                                            borderRadius: BorderRadius.circular(40)
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MySpecificSubsPage(state: MySubscritpionsLoadedState(mySubsList: state.mySubsList, userList:state.userList),index: index),));
                                            },
                                            child: Stack(
                                                children: [
                                                  Container(
                                                    height: screenHeight / 4,
                                                    width: screenWidth - 20,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(state.mySubsList[index].sub_photo),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0.2,
                                                    left: 0, 
                                                    right: 0, 
                                                    child: Container(
                                                      color: Colors.black87,
                                                      child: ListTile(
                                                        tileColor: Colors.white70,
                                                        title: RichText(
                                                                text: TextSpan(
                                                                  text: "",
                                                                  style: DefaultTextStyle.of(context).style,
                                                                  children:  <TextSpan>[
                                                                    TextSpan(text: "${state.mySubsList[index].sub_title}", style:GoogleFonts.poppins(
                                                                    fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white
                                                                  ),),
                                                                    TextSpan(text: " / ${state.mySubsList[index].sub_lang}", style:GoogleFonts.poppins(
                                                                    fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white
                                                                  ),),
                                                                  ],
                                                                ),
                                                              ),
                                                        subtitle: Text("expires on ${state.mySubsList[index].expiry}",
                                                        style: TextStyle(color: Colors.white),),
                                                        trailing: IconButton(onPressed: (){
                                                            _subsInfoDialog(context,state,index);
                                                        }, icon: Icon(Icons.info_outline,color: Colors.white,size: 25,))
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ),
                                        )

                                      );
                                    },),
                                );
                    }
                    else if(state is MySubscriptionErrorState){
                      return Text("No subscriptions");
                    }
                    return  Center(child: Lottie.asset('lib/assets/loader.json',height: 100,width: 100));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _subsInfoDialog(BuildContext context,MySubscritpionsLoadedState  state,int index) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Card(
              elevation: 5,
              color: Colors.black12,shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: Colors.white,
                height: (MediaQuery.of(context).size.height)/2.5,
                width: MediaQuery.of(context).size.width-30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Container(
                        height: (MediaQuery.of(context).size.height)/6,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(state.mySubsList[index].sub_photo),fit: BoxFit.cover)
                        ),
                      ),
                      Text("Subscritpion : ${state.mySubsList[index].sub_title}",style: cardTextStyle(),),
                      Text("Language : ${state.mySubsList[index].sub_lang}",style: cardTextStyle(),),
                      Text("Status : ${state.mySubsList[index].status}",style: cardTextStyle(),),
                      Text("Guide : ${state.mySubsList[index].guide_id}",style: cardTextStyle(),),
                      Text("Duration : ${state.mySubsList[index].date} -> ${state.mySubsList[index].expiry}",style: cardTextStyle(),),
                      Text("Amount : ${state.mySubsList[index].booking_amount}",style: cardTextStyle(),),
                      SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle cardTextStyle() => GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black);

}