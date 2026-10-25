abstract class JeepneyService {
  String serviceDescription();
}

class Jeepney {
  String routeName;
  int capacity;
  int _passengerCount = 0;

  Jeepney(this.routeName, this.capacity);

  int get passengerCount => _passengerCount;

  void boardPassengers(int count) {
    if (count <= 0) {
      print('Please enter a valid number of passengers.');
    } else if (_passengerCount + count <= capacity) {
      _passengerCount += count;
      print(
        '$count passengers boarded $routeName. '
        'Current count: $_passengerCount',
      );
    } else {
      print(
        'Cannot board $count passengers on $routeName: '
        'Exceeds capacity of $capacity!',
      );
    }
  }

  String displayInfo() {
    return 'Route: $routeName | Capacity: $capacity '
        '| Passengers: $_passengerCount';
  }
}

class RegularJeepney extends Jeepney
    implements JeepneyService {
  RegularJeepney(String routeName, int capacity)
      : super(routeName, capacity);

  @override
  String serviceDescription() {
    return 'Regular jeepney service for everyday commuters.';
  }

  @override
  String displayInfo() {
    return '[REGULAR] ${super.displayInfo()} '
        '| Service: ${serviceDescription()}';
  }
}

class ModernJeepney extends Jeepney
    implements JeepneyService {
  ModernJeepney(String routeName, int capacity)
      : super(routeName, capacity);

  @override
  String serviceDescription() {
    return 'Modern jeepney service with a more comfortable ride.';
  }

  @override
  String displayInfo() {
    return '[MODERN] ${super.displayInfo()} '
        '| Service: ${serviceDescription()}';
  }
}

mixin FareCalculator {
  double calculateFare(int passengers) {
    return passengers * 13.0;
  }
}

class FleetReport with FareCalculator {
  void printFareEstimate(Jeepney jeepney) {
    final fare = calculateFare(jeepney.passengerCount);

    print(
      'Estimated fare collection for ${jeepney.routeName}: '
      'PHP ${fare.toStringAsFixed(2)}',
    );
  }
}

void main() {
  RegularJeepney jeepney1 =
      RegularJeepney('Katipunan - UP', 20);

  ModernJeepney jeepney2 =
      ModernJeepney('Cubao - Divisoria', 24);

  jeepney1.boardPassengers(12);
  jeepney2.boardPassengers(28);
  jeepney2.boardPassengers(15);

  List<Jeepney> fleet = [jeepney1, jeepney2];

  print('\n--- Fleet Status Summary ---');

  for (Jeepney jeepney in fleet) {
    print(jeepney.displayInfo());
  }

  print('\n--- Fare Estimates ---');

  FleetReport report = FleetReport();

  for (Jeepney jeepney in fleet) {
    report.printFareEstimate(jeepney);
  }
}