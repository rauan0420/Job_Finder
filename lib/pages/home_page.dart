import 'package:dk/util/job_card.dart';
import 'package:dk/util/recent_job_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  Future addUserDetails(
    String firstName,
    String lastName,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  IconData personIcon = IconData(0xe7fd, fontFamily: 'MaterialIcons');

  final List jobsforyou = [
    ['Meta', 'UI Designer', 'assets/icons/meta.png', 1000000],
    ['Apple', 'Backend Developer', 'assets/icons/apple.png', 700000],
    ['Google', 'Mobile Developer', 'assets/icons/google.png', 900000],
  ];

  final List recentjobs = [
    ['Meta', 'UI Designer', 'assets/icons/meta.png', 1000000],
    ['Apple', 'Backend Developer', 'assets/icons/apple.png', 1300000],
    ['Google', 'Mobile Developer', 'assets/icons/google.png', 1500000],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          //app bar
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              height: 50,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200]),
              child: ElevatedButton(
                child: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                ),
              ),
              // Image.asset(
              //   'assets/icons/menu.png',
              //   color: Colors.grey[800],
              // ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //discover a new path
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Hello ' + user.email!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(height: 25),
          //search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 30,
                      child: Image.asset('assets/icons/search.png'),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          //for you job cards
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "For you",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            height: 170,
            child: ListView.builder(
              itemCount: jobsforyou.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return JobCard(
                    companyName: jobsforyou[index][0],
                    jobTitle: jobsforyou[index][1],
                    logoImagePath: jobsforyou[index][2],
                    monthlyRate: jobsforyou[index][3]);
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //recent job
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Recent jobs",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView.builder(
                  itemCount: recentjobs.length,
                  itemBuilder: (context, index) {
                    return RecentJobCard(
                      companyName: recentjobs[index][0],
                      jobTitle: recentjobs[index][1],
                      logoImagePath: recentjobs[index][2],
                      monthlyRate: recentjobs[index][3],
                    );
                  }),
            ),
          ),
          Center(
            child: MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepPurpleAccent,
              child: Text('Sign out!'),
            ),
          )
        ],
      ),
    );
  }
}
