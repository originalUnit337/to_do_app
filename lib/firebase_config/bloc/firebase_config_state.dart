sealed class FirebaseConfigState {
  const FirebaseConfigState();
}

class FirebaseConfigInitial extends FirebaseConfigState {
  const FirebaseConfigInitial();
}

class FirebaseConfigRefreshing extends FirebaseConfigState {
  const FirebaseConfigRefreshing();
}

class FirebaseConfigRefreshed extends FirebaseConfigState {
  const FirebaseConfigRefreshed();
}
