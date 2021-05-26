String timeFormatter(String time) {
  var timeOfDay = time.split(' ')[0];
  var amOrPM = time.split(' ')[1];

  if (amOrPM == 'PM') {
    var hour = timeOfDay.split(':')[0];
    var minutes = timeOfDay.split(':')[1];
    var newHours = int.parse(hour) + 12;
    return [newHours.toString(), minutes].join(':');
  }
  
  return timeOfDay;
}
