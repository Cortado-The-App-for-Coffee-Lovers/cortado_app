import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:cortado_app/src/ui/widgets/loading_state_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class AccountPage extends DrawerPage {
  AccountPage(Widget drawer) : super(drawer);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AuthBloc _authBloc;
  User user;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context).user;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.dark),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: widget.drawer,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * .175,
            width: SizeConfig.blockSizeVertical * 1,
            child: Stack(
              children: <Widget>[
                Container(
                  width: SizeConfig.blockSizeHorizontal,
                ),
                Positioned(
                  top: SizeConfig.safeBlockVertical * .12,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    color: AppColors.dark,
                    height: 2.0,
                    width: SizeConfig.safeBlockVertical * .46,
                  ),
                ),
                Center(
                  child: Container(
                      width: SizeConfig.blockSizeVertical * .17,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/account.png')))),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              "Name:",
              style: TextStyles.kDefaultDarkTextStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.all(18.0),
            child: GestureDetector(
              child: Text(
                user.email,
                textAlign: TextAlign.center,
                style: TextStyles.kAccountTitleTextStyle,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            color: AppColors.dark,
            height: 2.0,
            width: SizeConfig.safeBlockHorizontal * .9,
          ),
          Container(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              "Subscription:",
              style: TextStyles.kDefaultDarkTextStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.all(18.0),
            child: GestureDetector(
              child: Text(
                "<Subscription Type>",
                textAlign: TextAlign.center,
                style: TextStyles.kAccountTitleTextStyle,
              ),
            ),
          ),
          Text(
            "Reloads on ${user.reloadDate}",
            style: TextStyles.kDefaultDarkTextStyle,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            color: AppColors.dark,
            height: 2.0,
            width: SizeConfig.safeBlockHorizontal * .9,
          ),
        ],
      )),
      floatingActionButton: Container(
          height: 150,
          child: Column(children: <Widget>[
            Center(
              child: LoadingStateButton<AuthLoadingState>(
                bloc: _authBloc,
                button: Container(
                  child: GestureDetector(
                      child: Text(
                        "Sign Out",
                        style: TextStyles.kContinueTextStyle,
                      ),
                      onTap: () {
                        _authBloc.add(SignOut());
                      }),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              color: AppColors.caramel,
              height: 1.0,
              width: SizeConfig.safeBlockHorizontal * .5,
            ),
          ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
