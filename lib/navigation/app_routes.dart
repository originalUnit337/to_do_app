enum AppRoutes {
  homeRoute(path: '/', name: 'home'),
  addNote(path: '/add_note', name: 'add_note'),
  infoNote(path: '/info_note?data', name: 'info_note');

  final String path;
  final String name;
  const AppRoutes({required this.path, required this.name});
}
