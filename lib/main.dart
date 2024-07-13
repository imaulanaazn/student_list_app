import 'package:flutter/material.dart';

void main() {
  runApp(StudentListApp());
}

class StudentListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentListPage(),
    );
  }
}

class StudentListPage extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {
      'nim': 'STI202102123',
      'name': 'FEBRI NUR HIDAYAT',
      'color': const Color.fromARGB(255, 255, 255, 255)
    },
    {
      'nim': 'STI202102125',
      'name': 'INDES PRAFITRI',
      'color': const Color.fromARGB(255, 255, 237, 237)
    },
    {
      'nim': 'STI202102132',
      'name': 'ZAHWA NACA SYAFIKA',
      'color': const Color.fromARGB(255, 255, 225, 225)
    },
    {
      'nim': 'STI202102133',
      'name': 'RAHAYU DWI SETIOWATI',
      'color': const Color.fromARGB(255, 255, 200, 200)
    },
    {
      'nim': 'STI202102135',
      'name': 'MUARIF SUBEKHI',
      'color': const Color.fromARGB(255, 255, 180, 180)
    },
    {
      'nim': 'STI202102142',
      'name': 'TAMA ADI LUSIONO',
      'color': const Color.fromARGB(255, 255, 160, 160)
    }, // Your name
    {
      'nim': 'STI202102147',
      'name': 'ABDUL FAIZ',
      'color': const Color.fromARGB(255, 255, 180, 180)
    },
    {
      'nim': 'STI202102152',
      'name': 'ANGGORO MUSTIKA PUTRA',
      'color': const Color.fromARGB(255, 255, 200, 200)
    },
    {
      'nim': 'STI202102153',
      'name': 'MUHTARULLOH',
      'color': const Color.fromARGB(255, 255, 225, 225)
    },
    {
      'nim': 'STI202102159',
      'name': 'ADE SETIAWAN',
      'color': const Color.fromARGB(255, 255, 237, 237)
    },
    {'nim': 'STI202102161', 'name': 'SULISTIYO', 'color': Colors.white},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: InfiniteListView(students: students),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {},
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}

class InfiniteListView extends StatefulWidget {
  final List<Map<String, dynamic>> students;

  InfiniteListView({required this.students});

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  late ScrollController _controller;
  double _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.extentAfter < _scrollThreshold) {
      _controller.jumpTo(_controller.position.minScrollExtent);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: widget.students.length *
          2, // Duplicate the list to create infinite scroll effect
      itemBuilder: (context, index) {
        int actualIndex = index % widget.students.length;
        bool isMyName =
            widget.students[actualIndex]['name'] == 'TAMA ADI LUSIONO';
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: widget.students[actualIndex]['color'],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              widget.students[actualIndex]['name']!,
              style: TextStyle(
                fontWeight: isMyName ? FontWeight.bold : FontWeight.normal,
                color: isMyName ? Colors.black : Colors.black54,
              ),
            ),
            subtitle: Text(
              widget.students[actualIndex]['nim']!,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}
