import 'package:filmoteca_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<UserModel?> _getUserData(String uid) async {
  try {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      return UserModel(
        uid: uid,
        email: userData['email'],
        name: userData['name'],
        photoUrl: userData['photoUrl'],
      );
    }
    return null;
  } catch (e) {
    print('Erro ao obter dados do usuário: $e');
    return null;
  }
}

Future<void> _saveUserData(UserModel user) async {
  return _firestore.collection('users').doc(user.uid).set({
    'email': user.email,
    'name': user.name,
  });
}

Future<UserModel?> _userFromFirebase(User? user) async {
  if (user == null) {
    return null;
  }
  UserModel? usarModel = await _getUserData(user.uid);
  return usarModel;
}

Future<UserModel?> firebaseSignIn(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(userCredential.user);
  } catch (e) {
    throw Exception(e);
  }
}

Future<UserModel?> firebaseSignUp(
  String name,
  String email,
  String password,
) async {
  User? user;
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    user = userCredential.user;
    if (user != null) {
      print('Usuário registrado com sucesso: ${user.email}');
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
      });
      return _userFromFirebase(user);
    }
  } on FirebaseAuthException catch (e) {
    print('Falha ao criar usuário: $e');
    throw Exception(e);
  } on FirebaseException catch (e) {
    print('Falha ao salvar dados: $e');
  }
  return user as UserModel;
}
