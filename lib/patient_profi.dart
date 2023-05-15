import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:healthcare/authentication/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 200;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Profile"),
        backgroundColor: Color.fromARGB(255, 3, 34, 66),
      ),
      backgroundColor: Color.fromARGB(255, 150, 148, 197),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/h6.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage('assets/h2.jpg'),
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 9),
          Text('Anuska Dangal',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 9),
          Text(
            'Flutter App Developer',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 16),
          Divider(),
          const SizedBox(height: 16),
          buildAbout(),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcon(FontAwesomeIcons.instagram),
              const SizedBox(width: 20),
              buildSocialIcon(FontAwesomeIcons.twitter),
              const SizedBox(width: 20),
              buildSocialIcon(FontAwesomeIcons.linkedin),
              const SizedBox(width: 20),
            ],
          ),
        ],
      );

  Widget buildAbout() => Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 17),
          Text(
              'Flutter is an open-source software development kit which enables smooth and easy cross-platform mobile app development. You can build high quality natively compiled apps for iOS and Android quickly, without having to write the code for the two apps separately. All you need is one codebase for both platforms.'),
          Divider(),
          const SizedBox(height: 16),
          Text('Contact',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 17),
          Text('Email: anuskadangal@gmail.com\n\nPhone number: 9808127399'),
          Divider(),
          const SizedBox(height: 16),
          // Text('Find me on:',
          //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Divider(),
          const SizedBox(height: 16),
          ElevatedButton.icon(
              icon: Icon(
                Icons.arrow_back,
                size: 32,
              ),
              label: Text(
                'sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              }
              //=> FirebaseAuth.instance.signOut()
              ),
        ],
      ));

  Widget buildSocialIcon(IconData icon) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final url = 'https://www.instagram.com/';
            },
            child: Center(child: Icon(icon, size: 36)),
          ),
        ),
      );
}
