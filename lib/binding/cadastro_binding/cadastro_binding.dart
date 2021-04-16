import 'package:amigos_online/controller/cadastro_controller/cadastro_controller.dart';
import 'package:amigos_online/data/provider/cadastro_providers/cadastro_provider.dart';
import 'package:amigos_online/data/provider/cadastro_providers/nickname_firebase_provider.dart';
import 'package:amigos_online/data/provider/cadastro_providers/user_avatar_provider.dart';
import 'package:amigos_online/data/repository/cadastro_repository/cadastro_repository.dart';
import 'package:amigos_online/data/repository/cadastro_repository/nick_name_firebase_repository.dart';
import 'package:amigos_online/data/repository/cadastro_repository/user_avatar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class CadastroBinding implements Bindings {
  @override
  void dependencies() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseFirestore firebaseFirestoreToImage = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    Get.lazyPut<CadastroController>(() => CadastroController(
        userAvatarRepository: UserAvatarRepository(
            provider: UserAvatarProvider(
                firestore: firebaseFirestoreToImage, storage: storage)),
        nickNameFirebaseRepository: NickNameFirebaseRepository(
            provider: NickNameProvider(firestore: firebaseFirestore)),
        cadastroRepository:
            CadastroRepository(provider: CadastroProvider(auth: auth))));
  }
}
