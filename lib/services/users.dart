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

Future<UserModel?> firebaseSignIn({
  required String email,
  required String password,
}) async {
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

Future<UserModel?> firebaseSignUp({
  required String name,
  required String email,
  required String password,
}) async {
  User? user;
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    user = userCredential.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
      });
      return _userFromFirebase(user);
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw Exception('A senha fornecida é muito fraca.');
    } else if (e.code == 'email-already-in-use') {
      throw Exception('Já existe uma conta com o e-mail fornecido.');
    } else {
      throw Exception('Ocorreu um erro: $e');
    }
  } on FirebaseException catch (e) {
    if (e.code == 'permission-denied') {
      throw Exception(
          'O usuário não tem permissões suficientes para escrever neste documento.');
    } else if (e.code == 'unavailable') {
      throw Exception('O serviço Firestore está atualmente indisponível.');
    } else {
      throw Exception('Falha ao salvar dados: $e');
    }
  }
  return user as UserModel;
}
