import 'package:finalloyal/Screens/SignedUp/Profile.dart';
import 'package:finalloyal/Screens/SignedUp/SignedUpHome.dart';
import 'package:finalloyal/Screens/SignedUp/offer.dart';
import 'package:finalloyal/Screens/SignedUp/offer_detail.dart';
import 'package:finalloyal/Screens/SignedUp/point_screen.dart';
import 'package:finalloyal/Screens/SignedUp/reward/rewardHome.dart';
import 'package:finalloyal/Screens/SignedUp/reward/rewardTabIndex.dart';
import 'package:finalloyal/Screens/SignedUp/transactions.dart';
import 'package:finalloyal/Screens/UnsignedUp/unsigned_home.dart';
import 'package:finalloyal/Screens/both/event.dart';
import 'package:finalloyal/Screens/both/event_detail.dart';
import 'package:finalloyal/Screens/both/feedback.dart';
import 'package:finalloyal/Screens/both/getting_started.dart';
import 'package:finalloyal/Screens/both/login.dart';
import 'package:finalloyal/Screens/both/service.dart';
import 'package:finalloyal/Screens/both/signup.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => GettingStarted());
        break;
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUp());
        break;
      case '/Login':
        if (args == null) return MaterialPageRoute(builder: (_) => Login());

        if (args is LoginScreenArguments) {
          LoginScreenArguments loginScreenArguments = args;
          return MaterialPageRoute(
              builder: (_) => Login(
                  phoneNumber: loginScreenArguments.phoneNumber,
                  isFirstTime: loginScreenArguments.isFirstTime));
        }
        break;
      case '/SignedUpHome':
        if (args is Client)
          return MaterialPageRoute(builder: (_) => SignedUpHome(args));
        return errorRoute();
      case '/UnsignedHome':
        return MaterialPageRoute(builder: (_) => UnsignedHome());
        break;
      case '/SignedUpHome':
        if (args is Client)
          return MaterialPageRoute(builder: (_) => SignedUpHome(args));
        return errorRoute();
        break;
      case '/Profile':
        if (args is Client)
          return MaterialPageRoute(builder: (_) => Profile(args));
        return errorRoute();
        break;
        case '/ServiceScreen':
      return MaterialPageRoute(builder: (_) => Service());
      break;
      case '/PointScreen':
        if (args is Client)
          return MaterialPageRoute(builder: (_) => PointScreen(args));
        return errorRoute();
        break;
      case '/Transactions':
        if (args is Client)
          return MaterialPageRoute(builder: (_) => Transactions(args));
        return errorRoute();
        break;
      case '/rewardTabIndex':
        if (args is RewardTabScreenArgument) {
          RewardTabScreenArgument rewardTabScreenArgument = args;
          return MaterialPageRoute(
              builder: (_) => RewardTabIndex(rewardTabScreenArgument.index,
                  rewardTabScreenArgument.client));
        }
        return errorRoute();
        break;
      case '/OfferDetail':
        if (args is OfferScreenArgument) {
          OfferScreenArgument offerScreenArgument = args;
          return MaterialPageRoute(
              builder: (_) => OfferDetail(
                  offerScreenArgument.index, offerScreenArgument.offersList));
        }
        return errorRoute();
        break;
      case '/EventDetail':
        if (args is EventScreenArgument) {
          EventScreenArgument eventScreenArgument = args;
          return MaterialPageRoute(
              builder: (_) => EventDetail(
                  eventScreenArgument.index, eventScreenArgument.eventsList));
        }
        return errorRoute();
        break;
      case '/FeedBack':
        if (args is Client)
          return MaterialPageRoute(builder: (_) => FeedBack(client: args));
        else if(args==null)
          return MaterialPageRoute(builder: (_) => FeedBack());
        return errorRoute();
        break;
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('Page Not Found'),
              ),
            ));
  }
}
