import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();
  // This holds a list of fiction users
  final List<Map<String, dynamic>> _allUsers = [
    {
      "name": "Chan Saw Lin",
      "phoneNo": "0152131113",
      "time": "2020-06-30 16:10:05"
    },
    {
      "name": "Lee Saw Loy",
      "phoneNo": "0161231346",
      "time": "2020-07-11 15:39:59"
    },
    {
      "name": "Khaw Tong Lin",
      "phoneNo": "0158398109",
      "time": "2020-08-19 11:10:18"
    },
    {
      "name": "Lim Kok Lin",
      "phoneNo": "0168279101",
      "time": "2020-08-19 11:11:35"
    },
    {
      "name": "Low Jun Wei",
      "phoneNo": "0112731912",
      "time": "2020-08-15 13:00:05"
    },
    {
      "name": "Yong Weng Kai",
      "phoneNo": "0172332743",
      "time": "2020-07-31 18:10:11"
    },
    {
      "name": "Jayden Lee",
      "phoneNo": "0191236439",
      "time": "2020-08-22 08:10:38"
    },
    {
      "name": "Kong Kah Yan",
      "phoneNo": "0111931233",
      "time": "2020-07-11 12:00:00"
    },
    {
      "name": "Jasmine Lau",
      "phoneNo": "0162879190",
      "time": "2020-08-01 12:10:05"
    },
    {
      "name": "Chan Saw Lin",
      "phoneNo": "016783239",
      "time": "2020-08-23 11:59:05"
    }
  ];

  bool isSort = false;
  void sort(List allUsers){
    _allUsers.sort((a, b) => a["time"].compareTo(b["time"]));
    isSort = !isSort;
  }

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels != 0) {
          const snackBar = SnackBar(
            content: Text('You have reached the end of the list!'),
            backgroundColor: Colors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    });
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space,display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      //use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance App'),
      ),
      floatingActionButton:Wrap(
        direction: Axis.horizontal,
        children:<Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: (() {
                Share.share("This is the attendance list:\n$_allUsers");
              }),
              child: const Icon(Icons.share),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: (() {
                sort(_allUsers);
              }),
              child: const Icon(Icons.sort),
            ),
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search name', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      controller: controller,
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(_foundUsers[index]["name"]),
                          subtitle: Text(
                              _foundUsers[index]["phoneNo"].toString()),
                          trailing: Text(_foundUsers[index]["time"]),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}