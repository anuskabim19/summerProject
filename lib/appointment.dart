import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Appointment {
  int id;
  String time;
  bool isAvailable;

  Appointment(
      {required this.id, required this.time, required this.isAvailable});
}

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late Database _database;
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    _fetchAppointments();
  }

  Future<void> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'appointments.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE appointments (id INTEGER PRIMARY KEY, time TEXT, isAvailable INTEGER)',
        );
      },
    );
  }

  Future<void> _fetchAppointments() async {
    final List<Map<String, dynamic>> appointmentData =
        await _database.query('appointments');
    _appointments = appointmentData
        .map((data) => Appointment(
              id: data['id'],
              time: data['time'],
              isAvailable: data['isAvailable'] == 1,
            ))
        .toList();
    setState(() {});
  }

  Future<void> _bookAppointment(Appointment appointment) async {
    await _database.update(
      'appointments',
      {'isAvailable': 0},
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
    await _fetchAppointments();
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Booked'),
          content: Text('Your appointment has been booked successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Appointment System'),
        ),
        body: ListView.builder(
            itemCount: _appointments.length,
            itemBuilder: (BuildContext context, int index) {
              var appointment = _appointments[index];

              return ListTile(
                  title: Text(appointment.time),
                  subtitle:
                      Text(appointment.isAvailable ? 'Available' : 'Booked'),
                  onTap: () {
                    if (appointment.isAvailable) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text('Confirm Appointment'),
                                content: Text(
                                    'Do you want to book this appointment?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                      child: Text('Book'),
                                      onPressed: () {
                                        _bookAppointment(appointment);
                                      })
                                ]);
                          });
                    }
                  });
            }));
  }
}
