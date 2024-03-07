part of 'subscription_bloc.dart';

 class SubscriptionState extends Equatable {
  const SubscriptionState();
  
  @override
  List<Object> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoadingState extends SubscriptionState{}

class SubscriptionLoadedState extends SubscriptionState{
  final List<SubscriptionModel> subscritpionList;

  SubscriptionLoadedState({
    required this.subscritpionList
  });
}

class SpecificSubsLoadedState extends SubscriptionState{
  final List<SubscriptionModel> specSubsList;
  SpecificSubsLoadedState({
    required this.specSubsList
  });
  @override
  List<Object> get props => [specSubsList];
}

class SearchLoadedState extends SubscriptionState{
  final List<SubscriptionModel> searchSubsList;
  SearchLoadedState({
    required this.searchSubsList
  });
  @override
  List<Object> get props => [searchSubsList];
}
