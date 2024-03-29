import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:konvo_app/models/user_model.dart';
import 'package:konvo_app/screens/edit_profile_screen.dart';
import 'package:konvo_app/utilities/constants.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  ProfileScreen({this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Konvo',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Billabong',
                fontSize: 35.0,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: usersRef.document(widget.userId).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              User user = User.fromDoc(snapshot.data);

              return ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 250.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT9gdc9ZMBuiiBoUKhVNtDpsvzCz78qRlV2zUZ4HtdrYD1tfVdG'))),
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              top: 200.0,
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: user.profileImageUrl.isEmpty
                                        ? AssetImage('assets/images/user_placeholder.jpg')
                                        : CachedNetworkImageProvider(user.profileImageUrl),
                                  ),
                                ],


                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 50.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '12',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Moments',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '386',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'Fanbase',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '345',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'Fan',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 200.0,
                                child: FlatButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EditProfileScreen(
                                        user: user,
                                      ),
                                    ),
                                  ),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.name,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          height: 80.0,
                          child: Text(
                            user.bio,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  )
                ],
              );
            }));
  }
}
