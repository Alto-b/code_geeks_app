import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/domain/booking_model.dart';
import 'package:code_geeks/domain/joined_subs_model.dart';
import 'package:code_geeks/domain/subscription_model.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubscriptionRepo{

  Future<List<SubscriptionModel>> getSubscriptions() async{

    List<SubscriptionModel> subscriptionList = [];

    try{
      final datas = await FirebaseFirestore.instance.collection("subscriptions")
      .orderBy('title')
      .get();

      datas.docs.forEach((element) {
        final data = element.data();
        final subscription = SubscriptionModel(
          subsId: data['SubsId'],
          title: data['title'], 
          language: data['language'], 
          description: data['description'], 
          photo: data['photo'], 
          amount: data['amount'],
          LangImg : data['LangImg'],
          LangDesc: data['LangDesc'],
          videos: data['videos']);

          subscriptionList.add(subscription);
      });
      return subscriptionList;
    }
   on FirebaseException catch(e){
      debugPrint("expection getting subscritpions. : ${e.message}");
    }
    return subscriptionList;
  }

  Future<List<SubscriptionModel>> getSpecificSubs(String subsId)async{
    List<SubscriptionModel> specSubsList = [];
    try{
      final datas = await FirebaseFirestore.instance.collection("subscriptions")
      .where('SubsId',isEqualTo: subsId)
       .get();

      datas.docs.forEach((element) {
        final data = element.data();
        final specSubs = SubscriptionModel(
          subsId: subsId, 
          title: data['title'], 
          language: data['language'], 
          description: data['description'], 
          photo: data['photo'], 
          amount: data['amount'],
          LangImg : data['LangImg'],
          LangDesc: data['LangDesc'],
          videos: data['videos']);

          specSubsList.add(specSubs);
      });
      return specSubsList;
    }
    on FirebaseException catch(e){
      debugPrint("expection getting specific subscritpions. : ${e.message}");
    }
    return specSubsList;
  }

  Future<List<SubscriptionModel>> searchSubscriptions(String keyword)async{
    List<SubscriptionModel> specSubsList = [];
    try{
      // final datas = await FirebaseFirestore.instance.collection("subscriptions")
      // .where('SubsId',isEqualTo: subsId).get();

      final datas = await FirebaseFirestore.instance.collection("subscriptions")
                    .where('title',isNotEqualTo: keyword)
                    .orderBy('title')
                    .startAt([keyword])
                    // .endAt([keyword + '\uf8ff'])
                    .get();
  //         final datas = await FirebaseFirestore.instance.collection("subscriptions")
  // .where('title', arrayContains: keyword)
  // .get();


      datas.docs.forEach((element) {
        final data = element.data();
        final specSubs = SubscriptionModel(
          subsId: data['SubsId'], 
          title: data['title'], 
          language: data['language'], 
          description: data['description'], 
          photo: data['photo'], 
          amount: data['amount'],
          LangImg : data['LangImg'],
          LangDesc: data['LangDesc'],
          videos : data['videos']);

          specSubsList.add(specSubs);
      });
      specSubsList.forEach((specSubs) {
  print(specSubs.subsId);
  print(specSubs.title);
  print(specSubs.language);
  // Print other fields as needed
});

      return specSubsList;
    }
    on FirebaseException catch(e){
      debugPrint("expection getting specific subscritpions. : ${e.message}");
    }
    return specSubsList;
  }

  Future<List<BookingModel>> mySubscriptions(String uid)async{
    List<BookingModel> mySubsList = [];
    try{
      final subsdatas = await FirebaseFirestore.instance.collection("bookings")
                    .where('user_id',isEqualTo: uid)
                    .where('status', whereIn: ['pending', 'ongoing'])
                    // .orderBy('date')
                    .get();
      // for(var doc in subsdatas.docs){
      //   final data = doc.data();
      //   final subId = data['sub_id'];
      //   final subsSnapShot = await FirebaseFirestore.instance.collection("subscritpions")
      //                       .doc(subId).get();
      //   final subscritpionData = subsSnapShot.data();
      // }

      subsdatas.docs.forEach((element) {
          final data = element.data();
          final mySubs = BookingModel(
          sub_id: data['sub_id'], 
          sub_title: data['sub_title'],
          sub_lang: data['sub_lang'],
          sub_photo: data['sub_photo'],
          booking_amount: data['booking_amount'], 
          booking_id: data['booking_id'], 
          date: data['date'].toString(), 
          expiry: data['expiry'].toString(),
          guide_id: data['guide_id'], 
          status: data['status'], 
          user_id: data['user_id'],
          subscriptionDetails: data['subscriptionDetails'],
          guide_name: data['guide_name'],
          guide_photo: data['guide_photo']
          );

        mySubsList.add(mySubs);
      });
      
    }
    on FirebaseException catch(e){
      debugPrint("expection getting my subscritpions. : ${e.message}");
    }
    return mySubsList;
  }

  Future<List<BookingModel>> mySubsHistory(String uid)async{
    List<BookingModel> historylist = [];
    try{
      final subsdatas = await FirebaseFirestore.instance.collection("bookings")
                    .where('user_id',isEqualTo: uid)
                    // .where('status', whereIn: ['pending', 'ongoing'])
                    .orderBy('date')
                    .get();
      subsdatas.docs.forEach((element) {
          final data = element.data();
          final mySubs = BookingModel(
          sub_id: data['sub_id'], 
          sub_title: data['sub_title'],
          sub_lang: data['sub_lang'],
          sub_photo: data['sub_photo'],
          booking_amount: data['booking_amount'], 
          booking_id: data['booking_id'], 
          date: data['date'].toString(), 
          expiry: data['expiry'].toString(),
          guide_id: data['guide_id'], 
          status: data['status'], 
          user_id: data['user_id'],
          subscriptionDetails: data['subscriptionDetails'],
          guide_name: data['guide_name'],
          guide_photo: data['guide_photo']
          );

        historylist.add(mySubs);
      });
      return historylist;
    }
    on FirebaseException catch(e){
      debugPrint("expection getting my subscritpions. : ${e.message}");
    }
    return historylist;
  }

  Future<void> updateSubsStats()async{
    final subs = await FirebaseFirestore.instance.collection("bookings").get();
    // final currDate =DateFormat('dd-MM-yyyy').format(DateTime.now());
    final currDate = DateTime.now();
    subs.docs.forEach((element) {
      // final expiryDate = DateTime.parse(element['expiry']);
      final expiryDate = DateFormat('dd-MM-yyyy').parse(element['expiry']);
      final currStatus = element['status'];

      if(currDate.isAfter(expiryDate) && (currStatus == "ongoing" || currStatus == "pending")){
        FirebaseFirestore.instance.collection("bookings").doc(element.id).update(
          {
            "status" : 'completed'
          }
        ).then((value){
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Subscription status updated")));
        });
      }
    });
  }
}