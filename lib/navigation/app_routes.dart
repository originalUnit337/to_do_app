enum AppRoutes {
  homeRoute(path: '/', name: 'home'),
  infoNote(path: '/info_note?data', name: 'info_note');

  final String path;
  final String name;
  const AppRoutes({required this.path, required this.name});
}
