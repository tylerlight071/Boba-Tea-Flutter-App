class Drink {
  String name;
  String imagePath;
  String price;
  double sweetValue;
  double iceValue;
  double pearlValue;

  Drink({
    required this.name,
    required this.imagePath,
    required this.price,
    this.sweetValue = 0.5,
    this.iceValue = 0.75,
    this.pearlValue = 0.25,
  });

  List<String> sweetLabels = [
    'Sugar? No way!',
    'Just a sprinkle!',
    'Sweet enough!',
    'Sugar rush!',
    'Sweet tooth!',
  ];

  List<String> iceLabels = [
    'Not a chance!',
    'Just a chill!',
    'Ice ice baby!',
    'Winter is coming!',
    'Iceberg ahead!',
  ];

  List<String> pearlLabels = [
    'Maybe next time!',
    'Just a few!',
    'Pearl jam!',
    'Pearl party!',
    'Pearl explosion!',
  ];

  String getSweetLabel() {
    int index = (sweetValue * (sweetLabels.length - 1)).round();
    return sweetLabels[index];
  }

  String getIceLabel() {
    int index = (iceValue * (iceLabels.length - 1)).round();
    return iceLabels[index];
  }

  String getPearlLabel() {
    int index = (pearlValue * (pearlLabels.length - 1)).round();
    return pearlLabels[index];
  }
}
