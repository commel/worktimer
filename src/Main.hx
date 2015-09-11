package;

class Main {

  static function main() {
    new Main();
  }

  function new() {
    if (Sys.args().length != 2) {
      Sys.println("Usage: startzeit endzeit");
      Sys.exit(1);
    }

    var args = Sys.args();

    var startDate = Date.fromString(args[0] + ":00");
    var endDate = Date.fromString(args[1] + ":00");

    var workTime = round((endDate.getTime() - startDate.getTime()) / 1000 / 60 / 60);
    var pause = calculatePause(workTime);
    var workingTime = round(subtractPause(workTime));
    var overtime = calculateOvertime(workingTime);

    Sys.println('Arbeitszeit von ${startDate} bis ${endDate}');
    Sys.println('Arbeitszeitdauer: ${workTime}h (${ct(workTime)})');
    Sys.println('Pause           : ${pause}h (${ct(pause)})');
    Sys.println('Arbeitszeit     : ${workingTime}h (${ct(workingTime)})');
    Sys.println('Bilanz          : ${overtime}h (${ct(overtime)})');
  }

  private function round(v: Float, ?precision:Int = 2):Float {
    return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
  }

  private function ct(time: Float):String {
    var hours = Std.int(time);
    var minutes = (time - hours) * 60;

    return '${hours}h ${minutes}m';
  }

  private function calculatePause(time: Float) {
    return switch time {
      case _ if (time > 9): 0.75;
      case _ if (time > 6): 0.5;
      default: 0;
      }
  }

  private function subtractPause(time: Float) {
    return time - calculatePause(time);
  }

  private function calculateOvertime(time: Float) {
    return time - 8;
  }

}