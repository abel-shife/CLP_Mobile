import 'dart:convert';
import 'dart:io';

import 'file:///C:/abelProj/final_loyal/lib/widgets/ProfileSliverBuilder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/AppServices/NetworkHandler.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:finalloyal/widgets/profile_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final Client client;

  Profile(this.client);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PickedFile pickedImage;
  final ImagePicker imagePicker = ImagePicker();
  List<String> menu = ['Edit', 'Logout'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileSliverBuilder(
        expandedHeight: 200,
        floatingActionButton: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: pickedImage == null
                  ? CachedNetworkImageProvider(
                      'http://192.168.8.104/Users/biruk/Documents/VUE/CLP-master/server/profileImages/${widget.client.phoneNumber}.jpg',
                    )
                  : FileImage(File(pickedImage.path)),
              fit: BoxFit.fill,
            ),
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, gradient: getImageGradient()),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.camera,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                    barrierColor:
                        Theme.of(context).primaryColor.withOpacity(0.7),
                    context: context,
                    builder: ((build) => imagePickOptionsBuilder()));
              },
            ),
          ),
        ),
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            expandedHeight: 200.0,
            pinned: true,
            elevation: 0.0,
            actions: [
              PopupMenuButton(
                onSelected: selectMenu,
                itemBuilder: (BuildContext context) {
                  return menu.map((item) {
                    return PopupMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList();
                },
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.client.firstName+" "+widget.client.lastName,
                  style: TextStyle(color: Colors.white),
                ),
                background: pickedImage == null
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            'http://192.168.8.104/Users/biruk/Documents/VUE/CLP-master/server/profileImages/${widget.client.phoneNumber}.jpg',
                          ),
                          fit: BoxFit.fill,
                        )),
                        child: Container(
                          decoration:
                              BoxDecoration(gradient: getImageGradient()),
                        ))
                    : Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: FileImage(File(pickedImage.path)),
                          fit: BoxFit.cover,
                        )),
                        child: Container(
                          decoration:
                              BoxDecoration(gradient: getImageGradient()),
                        ))),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ExpansionTile(
                            title: Center(
                                child: Text(
                              'Points',
                              style: TextStyle(fontSize: 20.0),
                            )),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22.0),
                                      child: CircularProgressIndicator(
                                        value: 0.75,
                                        backgroundColor:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Earn 20 points to get next level',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Active Points: ',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              '150',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Redeemed Points: ',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              '160',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Divider(
                                      color: Theme.of(context).primaryColor,
                                      thickness: 2.0,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    Card(
                        child: Padding(
                            padding:
                                const EdgeInsets.only(top: 22.0, bottom: 10.0),
                            child: Column(
                              children: [
                                ProfileFormField(
                                  hintText: widget.client.phoneNumber,
                                  isPassword: false,
                                  isEditable: false,
                                ),
                                ProfileFormField(
                                  hintText: widget.client.email,
                                  isPassword: false,
                                  isEditable: false,
                                ),
                                ProfileFormField(
                                  hintText:  widget.client.firstName,
                                  isPassword: false,
                                  isEditable: false,
                                ),
                                ProfileFormField(
                                  hintText:  widget.client.lastName,
                                  isPassword: false,
                                  isEditable: false,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Divider(
                                  color: Theme.of(context).primaryColor,
                                  thickness: 2.0,
                                ),
                              ],
                            )),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    Card(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 22.0, bottom: 10.0),
                          child: Column(
                            children: <Widget>[
                              FlatButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 8.0),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text('Change Password'),
                                            content:
                                                Text('content of the dialog'),
                                          ));
                                },
                                label: Text(
                                  'Change Password',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                icon: Icon(Icons.enhanced_encryption),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              FlatButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 8.0),
                                onPressed: () {},
                                label: Text(
                                  'Save Changes',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                icon: Icon(Icons.save_alt),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Divider(
                                color: Theme.of(context).primaryColor,
                                thickness: 2.0,
                              ),
                            ],
                          ),
                        ),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Container imagePickOptionsBuilder() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            'Choose a profile picture',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera,
                    size: 45.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text('Camera',
                      style: TextStyle(color: Theme.of(context).primaryColor))),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    size: 45.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text('Gallery',
                      style: TextStyle(color: Theme.of(context).primaryColor))),
            ],
          )
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    final pickedFile = await imagePicker.getImage(source: source);
    setState(() {
      pickedImage = pickedFile;
    });
    uploadProfileImage();
  }

  void selectMenu(String value) {
    switch (value) {
      case 'Edit':
        break;
      case 'Logout':
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Are you sure to logout??'),
                  actions: [
                    FlatButton.icon(
                        onPressed: () async {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/');
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.remove('client');
                        },
                        icon: Icon(Icons.check_circle),
                        label: Text('Yes')),
                    FlatButton.icon(
                      icon: Icon(Icons.cancel),
                      label: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ));
        break;
    }
  }

  void uploadProfileImage() {
    String base64Image = base64Encode(File(pickedImage.path).readAsBytesSync());
    String fileName = widget.client.phoneNumber.toString();
    http.post('http://192.168.8.104:3000/uploadProfileImage',
        body: {'image': base64Image, 'name': fileName}).then((res) {
          setState(() {

          });
    }).catchError((err) {
      print(err);
    });
  }
}
