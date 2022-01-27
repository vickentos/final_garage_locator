class OnBoarding {
  String description;
  String imagePath;

  OnBoarding({required this.description, required this.imagePath});
}

List<OnBoarding> onBoardingContents = [
  OnBoarding(
    description: 'HELLO \n Welcome To Garage Locator.', imagePath: 'lib/assets/happy.png'),
  OnBoarding(
      description:
          'Garage locator lets you easily search for nearby garages. ',
      imagePath: 'lib/assets/cartow.jpg'),
  OnBoarding(
      description: 'With our mapping system, you can get the exact location of any garage.',
      imagePath: 'lib/assets/garage.png'),
  OnBoarding(
      description:
          'Users have the opportunity to choose from a list of multiple garages.',
      imagePath: 'lib/assets/mechanic.jpg'),
  OnBoarding(
      description:
      'Get Started.',
      imagePath: 'lib/assets/mechanic.jpg'),
];
