// class AppRoutes {
//   static const String homeRouteName = 'home';
//   static const String addNoteName = 'add_note';
// }

enum AppRoutes {
  homeRoute(path: '/', name: 'home'),
  addNote(path: '/add_note', name: 'add_note');

  final String path;
  final String name;
  const AppRoutes({required this.path, required this.name});
}
