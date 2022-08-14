import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streetwear_events/models/user_data.dart';
import 'package:streetwear_events/screens/home/events/EventList.dart';
import 'package:streetwear_events/utilities/constants.dart';

class UserProfileScreen extends StatefulWidget {

  final UserData user;
  UserProfileScreen({required this.user});
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  Widget _listViewTab(BuildContext context){
    return EventList(Axis.horizontal, 10, 0);
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => print('Login with Facebook'),
            AssetImage(
              'assets/images/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
                () => print('Login with Google'),
            AssetImage(
              'assets/images/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  ///TODO Create edit form screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeDarkColor,
      ), ///TODO add logic to edit icon button
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                      Container(
                      margin: const EdgeInsets.only(right: 20),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: new DecorationImage(
                            image: backgroundImage,
                            fit: BoxFit.cover, //BoxFit.fitWidth,
                          ),
                        )
                    ),
                    Text(widget.user.name as String),
                    SizedBox(width: 50), ///TODO refactoring
                    ElevatedButton(
                        onPressed: () async {
                          ///TODO add followed collection for current user
                        },
                        child: Text("Edit") //TODO add follow button if not current user
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Jak zwykle na Jestem Vintage! bądźcie gotowi nie tylko na zakupy. Warszawskie Muzeum Komputerów i Gier w ramach Jestem Vintage! #6 zbuduje interaktywną strefę grania oraz sklepik, w którym będzie można kupić gadżety związane z dawnymi komputerami.",
                style: TextStyle(color: Colors.black54),
                softWrap: true,
              ),
              _buildSocialBtnRow(),
              Container(
                //margin: const EdgeInsets.only(left: 20),
                width: double.maxFinite,
                height: 237,
                child: _listViewTab(context),
              ),
            ],
          ),
        )
      ),
    );
  }
}
