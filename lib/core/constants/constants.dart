import 'package:to_do_app/env/env.dart';

const String noteAPIBaseURL = 'https://firestore.googleapis.com/v1beta1/';

const String notesCollection =
    'projects/to-do-app-7c9ee/databases/(default)/documents/notes';

const String databaseVersionId = '!_database_version_id';

const String databaseVersionCollection =
    'projects/to-do-app-7c9ee/databases/(default)/documents/db_version';

/// works without this apiKey
const String apiKey = Env.firebaseApiKey;
