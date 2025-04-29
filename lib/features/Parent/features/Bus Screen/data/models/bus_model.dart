
import 'package:intl/intl.dart';

class Bus {
  final int id;
  final String number;
  final String driverName;
  final DateTime arrivalTime;
  final DateTime departureTime;

  Bus({
    required this.id,
    required this.number,
    required this.driverName,
    required this.arrivalTime,
    required this.departureTime,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'] as int,
      number: json['number'] as String,
      driverName: json['driverName'] as String,
      arrivalTime: DateTime.parse(json['arrivalTime'] as String),
        // .toLocal(),            // convert UTC → local
    departureTime: DateTime.parse(json['departureTime'] as String),
        // .toLocal(),
    );
  }

  // In your Bus model class
String get formattedArrivalTime {
  return DateFormat('h:mm a').format(arrivalTime);
}

String get formattedDepartureTime {
  return DateFormat('h:mm a').format(departureTime);
}
}
