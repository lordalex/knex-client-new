import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'fr'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? frText = '',
  }) =>
      [enText, esText, frText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // LoginSignUp
  {
    'gydpx1i7': {
      'en': 'KNEX',
      'es': 'KNEX',
      'fr': 'KNEX',
    },
    'e5fx1gbw': {
      'en': 'Sign In',
      'es': 'Iniciar sesión',
      'fr': 'Se connecter',
    },
    'm5xxnq5j': {
      'en': 'Let\'s get started by filling out the form below.',
      'es': 'Comencemos rellenando el formulario que aparece a continuación.',
      'fr': 'Commençons par remplir le formulaire ci-dessous.',
    },
    '5b8p1h6c': {
      'en': 'Email',
      'es': 'Correo electrónico',
      'fr': 'E-mail',
    },
    'plwa9xl9': {
      'en': 'Password',
      'es': 'Contraseña',
      'fr': 'Mot de passe',
    },
    '9hg5fv4w': {
      'en': 'Sign In',
      'es': 'Iniciar sesión',
      'fr': 'Se connecter',
    },
    'xtxxwdgr': {
      'en': 'Forgot Password',
      'es': 'Has olvidado tu contraseña',
      'fr': 'Mot de passe oublié',
    },
    'ic4a7jk0': {
      'en': 'Or sign up with',
      'es': 'O regístrate con',
      'fr': 'Ou inscrivez-vous avec',
    },
    '18zicm6g': {
      'en': 'Continue with Google',
      'es': 'Continuar con Google',
      'fr': 'Continuer avec Google',
    },
    'ql2jxxgr': {
      'en': 'Continue with Apple',
      'es': 'Continuar con Apple',
      'fr': 'Continuer avec Apple',
    },
    'g5cubfid': {
      'en': 'Sign Up',
      'es': 'Inscribirse',
      'fr': 'S\'inscrire',
    },
    'eqpamj2a': {
      'en': 'Let\'s get started by filling out the form below.',
      'es': 'Comencemos rellenando el formulario que aparece a continuación.',
      'fr': 'Commençons par remplir le formulaire ci-dessous.',
    },
    'xee94snm': {
      'en': 'Email',
      'es': 'Correo electrónico',
      'fr': 'E-mail',
    },
    '1jrk1bac': {
      'en': 'Password',
      'es': 'Contraseña',
      'fr': 'Mot de passe',
    },
    'sto2bx1o': {
      'en': 'Confirm Password',
      'es': 'confirmar Contraseña',
      'fr': 'Confirmez le mot de passe',
    },
    '4j0kjj2n': {
      'en': 'Create Account',
      'es': 'Crear una cuenta',
      'fr': 'Créer un compte',
    },
    'cowy04t0': {
      'en': 'Or sign up with',
      'es': 'O regístrate con',
      'fr': 'Ou inscrivez-vous avec',
    },
    '90lzpfl7': {
      'en': 'Continue with Google',
      'es': 'Continuar con Google',
      'fr': 'Continuer avec Google',
    },
    'ivp4vque': {
      'en': 'Continue with Apple',
      'es': 'Continuar con Apple',
      'fr': 'Continuer avec Apple',
    },
    '5ah08p58': {
      'en': 'Login',
      'es': 'Acceso',
      'fr': 'Se connecter',
    },
    'dplick6l': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // Profile
  {
    'tumaxre3': {
      'en': 'My favorite sites',
      'es': 'Mis sitios favoritos',
      'fr': 'Mes sites favoris',
    },
    '2frd3yex': {
      'en': 'Profile Settings',
      'es': 'Configuración del perfil',
      'fr': 'Paramètres du profil',
    },
    'ce9rr44n': {
      'en': 'Language',
      'es': 'Idioma',
      'fr': 'Langue',
    },
    '08vrmgny': {
      'en': 'Help Center',
      'es': 'Centro de ayuda',
      'fr': 'Centre d\'aide',
    },
    'mvd4vtc0': {
      'en': 'Dark mode',
      'es': 'Modo oscuro',
      'fr': 'Mode sombre',
    },
    'ala6hx97': {
      'en': 'Notification Settings',
      'es': 'Configuración de notificaciones',
      'fr': 'Paramètres de notification',
    },
    'l4rurg9c': {
      'en': 'Log out of account',
      'es': 'Cerrar sesión en la cuenta',
      'fr': 'Se déconnecter du compte',
    },
    '86v3nnx6': {
      'en': 'Log Out?',
      'es': '¿Finalizar la sesión?',
      'fr': 'Se déconnecter ?',
    },
    'df9bom31': {
      'en': 'v1.0',
      'es': 'versión 0.0.5',
      'fr': 'v0.0.5',
    },
    '11p2u62d': {
      'en': 'Profile',
      'es': 'Perfil',
      'fr': 'Profil',
    },
    'ifja2loe': {
      'en': 'Profile',
      'es': 'Perfil',
      'fr': 'Profil',
    },
  },
  // AddCars
  {
    '738t6mw5': {
      'en': 'Please fill in your vehicle data:',
      'es':
          'Por favor, rellene los datos de su vehículo para poder recuperar su coche.',
      'fr':
          'Veuillez remplir les données de votre véhicule afin de récupérer votre voiture',
    },
    'z5i08g3j': {
      'en': 'Make and model',
      'es': 'Modelo',
      'fr': 'Modèle',
    },
    'xk7rgteb': {
      'en': 'Write the make and model of your car',
      'es': 'Escribe el modelo de tu coche',
      'fr': 'Tapez le modèle de votre voiture',
    },
    'wvgk240m': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'p6lm8xog': {
      'en': 'Color',
      'es': 'Color',
      'fr': 'Couleur',
    },
    '8l6q3m84': {
      'en': 'Write the color of your car',
      'es': 'Escribe el color de tu coche',
      'fr': 'Écrivez la couleur de votre voiture',
    },
    '16dnp8br': {
      'en': 'Plate',
      'es': 'Lámina',
      'fr': 'Plaque',
    },
    '9rreyoyz': {
      'en': 'Type the plate of your car',
      'es': 'Escribe la matrícula de tu coche',
      'fr': 'Tapez la plaque d\'immatriculation de votre voiture',
    },
    'a8znzsnv': {
      'en': 'Instructions for valet',
      'es': 'Añadir mensaje',
      'fr': 'Ajouter un message',
    },
    'obw1ojcy': {
      'en': 'Custom',
      'es': 'Costumbre',
      'fr': 'Coutume',
    },
    '640p2vgd': {
      'en': 'Type the message for your attendant',
      'es': 'Escriba el mensaje para su asistente',
      'fr': 'Tapez le message pour votre accompagnateur',
    },
    'bsbelixt': {
      'en': 'Save Info',
      'es': 'Guardar información',
      'fr': 'Enregistrer les informations',
    },
    'zsqpqguo': {
      'en': 'Vehicle Details',
      'es': 'Detalles del vehículo',
      'fr': 'Détails du véhicule',
    },
    'hk10tk51': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // History
  {
    'lb8pnuds': {
      'en': 'A summary of your account activity',
      'es': 'Un resumen de la actividad de su cuenta',
      'fr': 'Un résumé de l\'activité de votre compte',
    },
    'wmbg06ck': {
      'en': 'Recent',
      'es': 'Reciente',
      'fr': 'Récent',
    },
    'kglzduji': {
      'en': 'KNEX Main Parking Lot',
      'es': 'Estacionamiento principal de KNEX',
      'fr': 'Parking principal du KNEX',
    },
    '0pd42p9p': {
      'en':
          'Create a random launch request that needs to be fixed, this is very important for the success of your daily activities.',
      'es':
          'Crea una solicitud de lanzamiento aleatoria que necesite ser reparada, esto es muy importante para el éxito de tus actividades diarias.',
      'fr':
          'Créez une demande de lancement aléatoire qui doit être corrigée, c\'est très important pour le succès de vos activités quotidiennes.',
    },
    '5wmmhhd9': {
      'en': 'View Details',
      'es': 'Ver detalles',
      'fr': 'Voir les détails',
    },
    'vaxl0m6w': {
      'en': 'Fri, Jan 6',
      'es': 'Viernes 6 de enero',
      'fr': 'Ven. 6 janv.',
    },
    'r7qf422l': {
      'en': '||',
      'es': '||',
      'fr': '||',
    },
    'aqru2f08': {
      'en': '4:20pm',
      'es': '4:20 p. m.',
      'fr': '16h20',
    },
    'yokffdf3': {
      'en': 'KNEX Main Parking Lot',
      'es': 'Estacionamiento principal de KNEX',
      'fr': 'Parking principal du KNEX',
    },
    '0hu4c5x6': {
      'en':
          'Create a random launch request that needs to be fixed, this is very important for the success of your daily activities.',
      'es':
          'Crea una solicitud de lanzamiento aleatoria que necesite ser reparada, esto es muy importante para el éxito de tus actividades diarias.',
      'fr':
          'Créez une demande de lancement aléatoire qui doit être corrigée, c\'est très important pour le succès de vos activités quotidiennes.',
    },
    'i3por50e': {
      'en': 'View Details',
      'es': 'Ver detalles',
      'fr': 'Voir les détails',
    },
    'fy58mjfu': {
      'en': 'Fri, Jan 6',
      'es': 'Viernes 6 de enero',
      'fr': 'Ven. 6 janv.',
    },
    'jugfdde9': {
      'en': '||',
      'es': '||',
      'fr': '||',
    },
    'pituer1t': {
      'en': '4:20pm',
      'es': '4:20 p. m.',
      'fr': '16h20',
    },
    '3mh9g9w8': {
      'en': 'Pending',
      'es': 'Pendiente',
      'fr': 'En attente',
    },
    '1gfr3sca': {
      'en': 'Outstanding Tasks',
      'es': 'Tareas pendientes',
      'fr': 'Tâches en suspens',
    },
    'tebmvydl': {
      'en': 'Tasks that need to be completed',
      'es': 'Tareas que deben completarse',
      'fr': 'Tâches à accomplir',
    },
    'puij6gph': {
      'en': 'Task Type',
      'es': 'Tipo de tarea',
      'fr': 'Type de tâche',
    },
    'ktfs2m5m': {
      'en':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'es':
          'La descripción de la tarea es muy larga y se extiende más de dos líneas.',
      'fr':
          'Description de la tâche : celle-ci est vraiment longue et peut-être plus longue ? Et elle s\'étend sur deux lignes.',
    },
    '6uxo2eyu': {
      'en': 'Due:',
      'es': 'Pendiente:',
      'fr': 'Exigible:',
    },
    '5tpznwn2': {
      'en': 'Today, 6:20pm',
      'es': 'Hoy, 18:20 horas',
      'fr': 'Aujourd\'hui, 18h20',
    },
    'ss5woivj': {
      'en': 'Update',
      'es': 'Actualizar',
      'fr': 'Mise à jour',
    },
    '70y097da': {
      'en': '1',
      'es': '1',
      'fr': '1',
    },
    'macmowvm': {
      'en': 'Task Type',
      'es': 'Tipo de tarea',
      'fr': 'Type de tâche',
    },
    'k9mppsvl': {
      'en':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'es':
          'La descripción de la tarea es muy larga y se extiende más de dos líneas.',
      'fr':
          'Description de la tâche : celle-ci est vraiment longue et peut-être plus longue ? Et elle s\'étend sur deux lignes.',
    },
    '2kxldcxs': {
      'en': 'Due:',
      'es': 'Pendiente:',
      'fr': 'Exigible:',
    },
    '058gehkk': {
      'en': 'Today, 6:20pm',
      'es': 'Hoy, 18:20 horas',
      'fr': 'Aujourd\'hui, 18h20',
    },
    'hhnberc9': {
      'en': 'Update',
      'es': 'Actualizar',
      'fr': 'Mise à jour',
    },
    'ggwpk28x': {
      'en': '1',
      'es': '1',
      'fr': '1',
    },
    '16yefw6r': {
      'en': 'Completed',
      'es': 'Terminado',
      'fr': 'Complété',
    },
    'ec6nc5wg': {
      'en': 'Completed Tasks',
      'es': 'Tareas completadas',
      'fr': 'Tâches terminées',
    },
    'o1de87w6': {
      'en': 'Tasks that you have completed.',
      'es': 'Tareas que has completado.',
      'fr': 'Tâches que vous avez accomplies.',
    },
    'jhlm18uz': {
      'en': 'Task Type',
      'es': 'Tipo de tarea',
      'fr': 'Type de tâche',
    },
    '5b2bt2nl': {
      'en':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'es':
          'La descripción de la tarea es muy larga y se extiende más de dos líneas.',
      'fr':
          'Description de la tâche : celle-ci est vraiment longue et peut-être plus longue ? Et elle s\'étend sur deux lignes.',
    },
    'k1873525': {
      'en': 'Due:',
      'es': 'Pendiente:',
      'fr': 'Exigible:',
    },
    'nqetly20': {
      'en': 'Today, 6:20pm',
      'es': 'Hoy, 18:20 horas',
      'fr': 'Aujourd\'hui, 18h20',
    },
    'nx30e0ga': {
      'en': 'Update',
      'es': 'Actualizar',
      'fr': 'Mise à jour',
    },
    'zh03epun': {
      'en': '1',
      'es': '1',
      'fr': '1',
    },
    'hd52dtc1': {
      'en': 'Task Type',
      'es': 'Tipo de tarea',
      'fr': 'Type de tâche',
    },
    'i3apofb6': {
      'en':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'es':
          'La descripción de la tarea es muy larga y se extiende más de dos líneas.',
      'fr':
          'Description de la tâche : celle-ci est vraiment longue et peut-être plus longue ? Et elle s\'étend sur deux lignes.',
    },
    'mhvqbe1i': {
      'en': 'Due:',
      'es': 'Pendiente:',
      'fr': 'Exigible:',
    },
    'l4aqv1hh': {
      'en': 'Today, 6:20pm',
      'es': 'Hoy, 18:20 horas',
      'fr': 'Aujourd\'hui, 18h20',
    },
    'sv45uoan': {
      'en': 'Update',
      'es': 'Actualizar',
      'fr': 'Mise à jour',
    },
    'mxv9cg8j': {
      'en': '1',
      'es': '1',
      'fr': '1',
    },
    'vvq8w134': {
      'en': 'Activity',
      'es': 'Actividad',
      'fr': 'Activité',
    },
    'nod65w6q': {
      'en': 'Activity',
      'es': 'Actividad',
      'fr': 'Activité',
    },
  },
  // HomePageOld
  {
    'tlaulc5o': {
      'en': 'Valet location available near you:',
      'es': 'Ubicación de valet parking disponible cerca de usted:',
      'fr': 'Emplacement de voiturier disponible près de chez vous :',
    },
    'sxnt6yhc': {
      'en': 'Trulucks ',
      'es': 'Trulucks',
      'fr': 'Trulucks',
    },
    'h147xmxz': {
      'en': '5/Mi',
      'es': '5/Mi',
      'fr': '5/Mi',
    },
    'tjidf541': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'rzcc1n0p': {
      'en': 'McDonalds',
      'es': 'McDonald\'s',
      'fr': 'McDonald\'s',
    },
    'hebwvxka': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'u9lbkozi': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    '2463jxxq': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    'xt9fyp8v': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'ugdgrqwj': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    '8yykbca5': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    '9x9jmcmo': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    '2ppk3ed0': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'ubseur4w': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    'ktjccdwz': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'g365zn4g': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'kbdlojbx': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    's96qof48': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'gkve7dnv': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'ckyhb0xt': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    '07ey01e7': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'ls61wip4': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'u64y2jtc': {
      'en': 'Request valet?',
      'es': '¿Solicitar valet?',
      'fr': 'Demander un service de voiturier ?',
    },
    'zqqmoi2d': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // ProfileCreate
  {
    '8gdcoum8': {
      'en': 'Profile',
      'es': 'Perfil',
      'fr': 'Profil',
    },
    '7nzazu7a': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'sfzb2t1a': {
      'en': 'Name',
      'es': 'Nombre',
      'fr': 'Nom',
    },
    'sv46ruwl': {
      'en': 'Name',
      'es': 'Nombre',
      'fr': 'Nom',
    },
    'dr9iw7up': {
      'en': 'Last Name',
      'es': 'Apellido',
      'fr': 'Nom de famille',
    },
    'qey7s3ea': {
      'en': 'Last Name',
      'es': 'Apellido',
      'fr': 'Nom de famille',
    },
    '3cge9706': {
      'en': 'Phone Number',
      'es': 'Número de teléfono',
      'fr': 'Numéro de téléphone',
    },
    'homuayfm': {
      'en': 'Phone Number',
      'es': 'Número de teléfono',
      'fr': 'Numéro de téléphone',
    },
    'qz676q4v': {
      'en': 'Address',
      'es': 'DIRECCIÓN',
      'fr': 'Adresse',
    },
    'w68ab9g0': {
      'en': 'Address',
      'es': 'DIRECCIÓN',
      'fr': 'Adresse',
    },
    'fwu0dvtt': {
      'en': 'Zip code',
      'es': 'Código postal',
      'fr': 'Code postal',
    },
    'qeigpfpr': {
      'en': 'Zipcode',
      'es': 'Código postal',
      'fr': 'Code postal',
    },
    'id15h4we': {
      'en': 'State',
      'es': 'Estado',
      'fr': 'État',
    },
    '8hhb3v84': {
      'en': 'Search...',
      'es': 'Buscar...',
      'fr': 'Recherche...',
    },
    'cp5z7hju': {
      'en': '2323',
      'es': '2323',
      'fr': '2323',
    },
    '1mlj88xl': {
      'en': 'City',
      'es': 'Ciudad',
      'fr': 'Ville',
    },
    'ihaswhe1': {
      'en': 'City',
      'es': 'Ciudad',
      'fr': 'Ville',
    },
    '5mkat88g': {
      'en': 'Save Changes',
      'es': 'Guardar cambios',
      'fr': 'Enregistrer les modifications',
    },
    'e9y3wlgj': {
      'en': 'firstname is required',
      'es': 'El nombre es obligatorio',
      'fr': 'le prénom est obligatoire',
    },
    '1ej1gbto': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'fr': 'Veuillez choisir une option dans la liste déroulante',
    },
    '4q4zy28w': {
      'en': 'lastname is required',
      'es': 'El apellido es obligatorio',
      'fr': 'le nom de famille est obligatoire',
    },
    'fwk02d10': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'fr': 'Veuillez choisir une option dans la liste déroulante',
    },
    'youciqi8': {
      'en': 'phone is required',
      'es': 'Se requiere teléfono',
      'fr': 'le téléphone est requis',
    },
    'iuy5rygg': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'fr': 'Veuillez choisir une option dans la liste déroulante',
    },
    'shymfkul': {
      'en': 'Address is required',
      'es': 'La dirección es obligatoria',
      'fr': 'L\'adresse est requise',
    },
    'd9r7dst7': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'fr': 'Veuillez choisir une option dans la liste déroulante',
    },
    'xi4kkynl': {
      'en': 'Zip code is required',
      'es': '',
      'fr': '',
    },
    'mxqqkobo': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
      'fr': '',
    },
    'u51agwne': {
      'en': 'City is required',
      'es': 'Se requiere ciudad',
      'fr': 'La ville est requise',
    },
    '5hmg9hx1': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'fr': 'Veuillez choisir une option dans la liste déroulante',
    },
  },
  // MyCars
  {
    'ev08rqrd': {
      'en': 'My Cars',
      'es': 'Mis coches',
      'fr': 'Mes voitures',
    },
    'qrnxxrdf': {
      'en': 'Registered cars:',
      'es': 'Vehículos matriculados:',
      'fr': 'Voitures immatriculées :',
    },
    'iexs9hwh': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    'e08r5ho1': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'w2ghdmwr': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'yn166wxy': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    '8jv2noi0': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'g500zy6r': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    '9o2pf1z2': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    'o04pfdwb': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'u5ut3l1i': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'hg9zk1ca': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    '3jn15jz0': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'h9b1y9lw': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'fzgpx8hq': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    '2h41qr9o': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    'm1s2uskl': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    '829rgpuf': {
      'en': 'Title',
      'es': 'Título',
      'fr': 'Titre',
    },
    'eblr6vhd': {
      'en': 'Subtext',
      'es': 'Sentido solapado',
      'fr': 'Sous-texte',
    },
    '1dp0kx3w': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'ukkp93i5': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // ForgotPassword
  {
    's11qgj7l': {
      'en': 'Back',
      'es': 'Atrás',
      'fr': 'Dos',
    },
    '8dcd1cvo': {
      'en': 'Forgot Password',
      'es': 'Has olvidado tu contraseña',
      'fr': 'Mot de passe oublié',
    },
    'c6tbmlp3': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'es':
          'Le enviaremos un correo electrónico con un enlace para restablecer su contraseña, ingrese el correo electrónico asociado con su cuenta a continuación.',
      'fr':
          'Nous vous enverrons un e-mail avec un lien pour réinitialiser votre mot de passe, veuillez saisir l\'e-mail associé à votre compte ci-dessous.',
    },
    '3fyfq58d': {
      'en': 'Your email address...',
      'es': 'Su dirección de correo electrónico...',
      'fr': 'Votre adresse e-mail...',
    },
    '9etzw078': {
      'en': 'Enter your email...',
      'es': 'Introduce tu email...',
      'fr': 'Entrez votre email...',
    },
    'gbr2ej3t': {
      'en': 'Send Link',
      'es': 'Enviar enlace',
      'fr': 'Envoyer le lien',
    },
    'sbd74glj': {
      'en': 'Back',
      'es': 'Atrás',
      'fr': 'Dos',
    },
    'z19pphof': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // SiteDetails
  {
    'ukhpjb32': {
      'en': 'Primary Site',
      'es': 'Sitio principal',
      'fr': 'Site principal',
    },
    '691zx32k': {
      'en': 'Request Vallet',
      'es': 'Solicitud Vallet',
      'fr': 'Demande de voiturier',
    },
    'ikgmfq97': {
      'en': 'Call',
      'es': 'Llamar',
      'fr': 'Appel',
    },
    'o6ipanl1': {
      'en': 'Favorite Site',
      'es': 'Sitio favorito',
      'fr': 'Site préféré',
    },
    'rezxzsxc': {
      'en': 'Remove site from favorites',
      'es': 'Eliminar sitio de favoritos',
      'fr': 'Supprimer le site des favoris',
    },
    'tqhw2zbm': {
      'en': 'Details',
      'es': 'Detalles',
      'fr': 'Détails',
    },
    '2ctoat9v': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // AddCreditCard
  {
    'o8s2j0kr': {
      'en': 'Add Payment Method',
      'es': 'Agregar método de pago',
      'fr': 'Ajouter un mode de paiement',
    },
    '5050474q': {
      'en': 'VISA',
      'es': 'VISA',
      'fr': 'VISA',
    },
    'dr9kmm7q': {
      'en': '•••• •••• •••• ••••',
      'es': '•••• •••• •••• ••••',
      'fr': '•••• •••• •••• ••••',
    },
    'i9900y56': {
      'en': 'CARD HOLDER',
      'es': 'TITULAR DE LA TARJETA',
      'fr': 'PORTE-CARTES',
    },
    '9ecxe3u1': {
      'en': 'EXPIRES',
      'es': 'EXPIRA',
      'fr': 'EXPIRE',
    },
    'sxneohvt': {
      'en': 'YOUR NAME',
      'es': 'SU NOMBRE',
      'fr': 'VOTRE NOM',
    },
    'foz71wd1': {
      'en': 'MM/YY',
      'es': 'MM/AA',
      'fr': 'MM/AA',
    },
    'qvqp16me': {
      'en': 'Card Information',
      'es': 'Información de la tarjeta',
      'fr': 'Informations sur la carte',
    },
    'y905wknt': {
      'en': 'Card Number',
      'es': 'Número de tarjeta',
      'fr': 'Numéro de carte',
    },
    'h6e32dsp': {
      'en': '1234 5678 9012 3456',
      'es': '1234 5678 9012 3456',
      'fr': '1234 5678 9012 3456',
    },
    'u6mr7aih': {
      'en': 'Expiry Date',
      'es': 'Fecha de caducidad',
      'fr': 'Date d\'expiration',
    },
    'bj9rprt2': {
      'en': 'MM/YY',
      'es': 'MM/AA',
      'fr': 'MM/AA',
    },
    '3oy1ub8i': {
      'en': 'CVV',
      'es': 'CVV',
      'fr': 'CVV',
    },
    'giersa9k': {
      'en': '123',
      'es': '123',
      'fr': '123',
    },
    'jokqhqo4': {
      'en': 'Cardholder Name',
      'es': 'Nombre del titular de la tarjeta',
      'fr': 'Nom du titulaire de la carte',
    },
    'spyml4vt': {
      'en': 'Name on card',
      'es': 'Nombre en la tarjeta',
      'fr': 'Nom sur la carte',
    },
    'i1bpyqo8': {
      'en': 'Billing Address',
      'es': 'Dirección de Envio',
      'fr': 'adresse de facturation',
    },
    '3tlh2xbw': {
      'en': 'Street Address',
      'es': 'Dirección de la calle',
      'fr': 'Adresse de la rue',
    },
    'a9s8m65o': {
      'en': 'City',
      'es': 'Ciudad',
      'fr': 'Ville',
    },
    '4ke1sxtf': {
      'en': 'State',
      'es': 'Estado',
      'fr': 'État',
    },
    'v6cv442l': {
      'en': 'Zip Code',
      'es': 'Código postal',
      'fr': 'Code postal',
    },
    'wy9lf6k6': {
      'en': 'Add Card',
      'es': 'Agregar tarjeta',
      'fr': 'Ajouter une carte',
    },
  },
  // HomePage
  {
    'aljhde25': {
      'en': 'Find your nearest premium valet',
      'es': 'Encuentra tu valet premium más cercano',
      'fr': 'Trouvez votre voiturier premium le plus proche',
    },
    'asa375mf': {
      'en': 'Find your nearest premium valet',
      'es': 'Encuentra tu valet premium más cercano',
      'fr': 'Trouvez votre voiturier premium le plus proche',
    },
    'tonwutpq': {
      'en': 'Your time, \nour care',
      'es': 'Tu tiempo, nuestro cuidado',
      'fr': 'Votre temps, notre attention',
    },
    'fvvp7qgq': {
      'en': 'Valet location available near you:',
      'es': 'Ubicación de valet parking disponible cerca de usted:',
      'fr': 'Emplacement de voiturier disponible près de chez vous :',
    },
    'ytj20s0v': {
      'en': 'Request valet?',
      'es': '¿Solicitar valet?',
      'fr': 'Demander un service de voiturier ?',
    },
    '2hkwhck2': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // pay
  {
    'uiwfpr3u': {
      'en': 'Payment Confirmed!',
      'es': '¡Pago confirmado!',
      'fr': 'Paiement confirmé !',
    },
    'e9mf2u6v': {
      'en': '\$425.24',
      'es': '\$425.24',
      'fr': '425,24 \$',
    },
    '5z8sixf5': {
      'en':
          'Your payment has been confirmed, it may take 1-2 hours in order for your payment to go through and show up in your transation list.',
      'es':
          'Su pago ha sido confirmado, puede tomar 1-2 horas para que se procese y aparezca en su lista de transacciones.',
      'fr':
          'Votre paiement a été confirmé, cela peut prendre 1 à 2 heures pour que votre paiement soit effectué et apparaisse dans votre liste de transactions.',
    },
    'fxxy6b89': {
      'en': 'Mastercard Ending in 4021',
      'es': 'Mastercard que termina en 4021',
      'fr': 'Mastercard se terminant par 4021',
    },
    'bv4syiel': {
      'en': '\$425.24',
      'es': '\$425.24',
      'fr': '425,24 \$',
    },
    'ojlrrcdi': {
      'en': 'Go Home',
      'es': 'Ir a casa',
      'fr': 'Rentrer à la maison',
    },
    '3xkukzr9': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // changeLanguage
  {
    'fg21etlx': {
      'en': 'English',
      'es': 'Inglés',
      'fr': 'Anglais',
    },
    'oe1j1rfx': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'bh84sjbk': {
      'en': 'Spanish',
      'es': 'Español',
      'fr': 'Espagnol',
    },
    'iwhek3db': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '63mya96y': {
      'en': 'French',
      'es': 'Francés',
      'fr': 'Français',
    },
    'u2500ral': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'pmdgtp2d': {
      'en': 'Languages',
      'es': 'Idiomas',
      'fr': 'Langues',
    },
    '2yp26n1q': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // Ticket
  {
    '1i0mnclb': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'hdu9wi1r': {
      'en': 'Client\'s Requests: ',
      'es': 'Solicitudes del cliente:',
      'fr': 'Demandes du client :',
    },
    'jsnrwly6': {
      'en': 'N/A',
      'es': 'N / A',
      'fr': 'N / A',
    },
    'xitg74nn': {
      'en': 'Valet has been notified',
      'es': 'Se ha notificado al valet',
      'fr': 'Le voiturier a été prévenu',
    },
    'rtyn7dqt': {
      'en': 'Wait your valet is coming',
      'es': 'Espere, su valet viene.',
      'fr': 'Attendez, votre voiturier arrive',
    },
    'tntztfzp': {
      'en': 'Enjoy your KNEX experience',
      'es': 'Disfruta de tu experiencia KNEX',
      'fr': 'Profitez de votre expérience KNEX',
    },
    'gzz8c1il': {
      'en': 'Wait your attendant is picking your car',
      'es': 'Espere, su asistente está recogiendo su auto.',
      'fr': 'Attendez que votre préposé récupère votre voiture',
    },
    '402ocdvf': {
      'en': 'Please Drive Safely',
      'es': 'Por favor conduzca con seguridad',
      'fr': 'Veuillez conduire prudemment',
    },
    'epyqu0gs': {
      'en': 'Cancel ticket',
      'es': 'Cancelar ticket',
      'fr': 'Annuler le billet',
    },
    'swtih1fg': {
      'en': 'Request Pick Up',
      'es': 'Solicitar recogida',
      'fr': 'Demande de ramassage',
    },
    '4llbinoo': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
    'tnt3lbg5': {
      'en': 'Ticket',
      'es': 'Boleto',
      'fr': 'Billet',
    },
  },
  // TicketTimer
  {
    '5cfwqe1q': {
      'en': 'Pick your car',
      'es': 'Elige tu coche',
      'fr': 'Choisissez votre voiture',
    },
    '0ghljhzd': {
      'en': 'Pay vallet parking',
      'es': 'Estacionamiento de pago',
      'fr': 'Service voiturier payant',
    },
    'mirofhmx': {
      'en': 'Attendant did not appear?',
      'es': '¿El asistente no apareció?',
      'fr': 'L\'accompagnateur n\'est pas apparu ?',
    },
    'cou1vpcs': {
      'en': 'Powered by KNEX',
      'es': 'Desarrollado por KNEX',
      'fr': 'Propulsé par KNEX',
    },
    'vc5acnk8': {
      'en': 'Ticket',
      'es': 'Boleto',
      'fr': 'Billet',
    },
  },
  // favoritesSites
  {
    '4kdr2jh2': {
      'en': '\$11.00',
      'es': '\$11.00',
      'fr': '11,00 \$',
    },
    'j4am2pdu': {
      'en': 'My favorites sites',
      'es': 'Mis sitios favoritos',
      'fr': 'Mes sites favoris',
    },
    'kiwitxmv': {
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // ticketCompletedPage
  {
    'u4742u1p': {
      'en': 'Thank You!',
      'es': '',
      'fr': '',
    },
    'lxuctswy': {
      'en': 'Your vallet has been successfully completed',
      'es': '',
      'fr': '',
    },
    '6hu6n5jo': {
      'en': 'Valet Details',
      'es': '',
      'fr': '',
    },
    'uwnm9p6y': {
      'en': 'Ticket #A12345',
      'es': '',
      'fr': '',
    },
    'h6sgd31x': {
      'en': 'Completed',
      'es': '',
      'fr': '',
    },
    'sy8xzymd': {
      'en': 'Date Submitted',
      'es': '',
      'fr': '',
    },
    'gguyw9t7': {
      'en': 'October 15, 2023',
      'es': '',
      'fr': '',
    },
    'qwllrxdd': {
      'en': 'Date Completed',
      'es': '',
      'fr': '',
    },
    'edfpbs2t': {
      'en': 'October 18, 2023',
      'es': '',
      'fr': '',
    },
    'xkw1gh1z': {
      'en': 'Category',
      'es': '',
      'fr': '',
    },
    'ird7vz36': {
      'en': 'Technical Support',
      'es': '',
      'fr': '',
    },
    '4elh7u9q': {
      'en': 'Priority',
      'es': '',
      'fr': '',
    },
    'xp10tnf0': {
      'en': 'Medium',
      'es': '',
      'fr': '',
    },
    'p1woxeq9': {
      'en': 'Description',
      'es': '',
      'fr': '',
    },
    'a7itdiqb': {
      'en':
          'Login authentication issue with mobile application. User unable to access account after password reset.',
      'es': '',
      'fr': '',
    },
    'n10gq1gx': {
      'en': 'Resolution',
      'es': '',
      'fr': '',
    },
    '1ovuyv0w': {
      'en':
          'Reset user authentication token and cleared cached credentials. Verified successful login on multiple devices.',
      'es': '',
      'fr': '',
    },
    '4jxrjxda': {
      'en': 'Site detail',
      'es': '',
      'fr': '',
    },
    '24rcl2v1': {
      'en': 'Sarah Johnson',
      'es': '',
      'fr': '',
    },
    'mwp4ecmk': {
      'en': 'Technical Support Specialist',
      'es': '',
      'fr': '',
    },
    's4ih0v2r': {
      'en': 'Return to Dashboard',
      'es': '',
      'fr': '',
    },
  },
  // listconfig
  {
    'coh0kfga': {
      'en': 'Unit of Distance',
      'es': 'Un resumen de la actividad de su cuenta',
      'fr': 'Un résumé de l\'activité de votre compte',
    },
    'yccdixp5': {
      'en': 'Select...',
      'es': '',
      'fr': '',
    },
    'gs70q5h2': {
      'en': 'Search...',
      'es': '',
      'fr': '',
    },
    'a0tol1dv': {
      'en': 'imperial',
      'es': 'imperial',
      'fr': 'imperial',
    },
    '8k608ypr': {
      'en': 'metric',
      'es': 'metrico',
      'fr': 'metric',
    },
    '3qz66l8r': {
      'en': 'Sort By',
      'es': 'Un resumen de la actividad de su cuenta',
      'fr': 'Un résumé de l\'activité de votre compte',
    },
    '6ex1abhv': {
      'en': 'Select...',
      'es': '',
      'fr': '',
    },
    'd9ehep04': {
      'en': 'Search...',
      'es': '',
      'fr': '',
    },
    '15smxs97': {
      'en': 'name',
      'es': 'name',
      'fr': 'name',
    },
    '6efcmd6w': {
      'en': 'distance',
      'es': 'distance',
      'fr': 'distance',
    },
    '6tpczcee': {
      'en': 'value',
      'es': 'value',
      'fr': 'value',
    },
    'yz0zq76o': {
      'en': 'Order',
      'es': 'Un resumen de la actividad de su cuenta',
      'fr': 'Un résumé de l\'activité de votre compte',
    },
    'rz37kdse': {
      'en': 'Select...',
      'es': '',
      'fr': '',
    },
    '4t9h9h4d': {
      'en': 'Search...',
      'es': '',
      'fr': '',
    },
    'cqe8y6on': {
      'en': 'ascending',
      'es': 'ascending',
      'fr': 'ascending',
    },
    'cgle5cy0': {
      'en': 'descending',
      'es': 'descending',
      'fr': 'descending',
    },
    'r5705w0b': {
      'en': 'List Config',
      'es': 'Actividad',
      'fr': 'Activité',
    },
    '0vb7h5gq': {
      'en': 'Activity',
      'es': 'Actividad',
      'fr': 'Activité',
    },
  },
  // CardListComponent
  {
    '50flunob': {
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // cityDropdown
  {
    'u5m4bvti': {
      'en': 'City',
      'es': 'Ciudad',
      'fr': 'Ville',
    },
    'rbh6s671': {
      'en': 'Search...',
      'es': 'Buscar...',
      'fr': 'Recherche...',
    },
    'y1ip6snx': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'fr': 'Option 1',
    },
    't2jy3vwq': {
      'en': 'Option 2',
      'es': 'Opción 2',
      'fr': 'Option 2',
    },
    '0iqpoetz': {
      'en': 'Option 3',
      'es': 'Opción 3',
      'fr': 'Option 3',
    },
  },
  // cardItem
  {
    'oxid6zc5': {
      'en': 'KNEX MAIN PARKING LOT',
      'es': 'ESTACIONAMIENTO PRINCIPAL DE KNEX',
      'fr': 'PARKING PRINCIPAL DE KNEX',
    },
  },
  // tipBottomSheet
  {
    'iy0pqa78': {
      'en': 'Tip Amount',
      'es': 'Monto de la propina',
      'fr': 'Montant du pourboire',
    },
    'fpuokxaa': {
      'en': 'How much would you like to tip to your attendant?',
      'es': '¿Cuánto le gustaría darle de propina a su asistente?',
      'fr': 'Combien aimeriez-vous donner en pourboire à votre préposé ?',
    },
    'sndcjbpu': {
      'en': '18%',
      'es': '18%',
      'fr': '18%',
    },
    'vehzhm95': {
      'en': '20%',
      'es': '20%',
      'fr': '20%',
    },
    'm12xv4px': {
      'en': 'Custom',
      'es': 'Costumbre',
      'fr': 'Coutume',
    },
    'w6g075l7': {
      'en': 'Tip Amount',
      'es': 'Monto de la propina',
      'fr': 'Montant du pourboire',
    },
    'qvqt2dlk': {
      'en': '\$',
      'es': '\$',
      'fr': '\$',
    },
    'w682zszt': {
      'en': 'Add tip',
      'es': 'Añadir propina',
      'fr': 'Ajouter un pourboire',
    },
    'vian3red': {
      'en': 'Total Amount',
      'es': 'Importe total',
      'fr': 'Montant total',
    },
    'nzlw45t6': {
      'en': 'Add Tip',
      'es': 'Añadir propina',
      'fr': 'Ajouter un pourboire',
    },
  },
  // successTicket
  {
    '8j7cy3di': {
      'en': 'Success!',
      'es': '¡Éxito!',
      'fr': 'Succès!',
    },
    '2ydn7dci': {
      'en':
          'Your ticket has been successfully booked. You will receive a confirmation email shortly.',
      'es':
          'Tu billete se ha reservado correctamente. Recibirás un correo electrónico de confirmación en breve.',
      'fr':
          'Votre billet a bien été réservé. Vous recevrez prochainement un e-mail de confirmation.',
    },
    'a7ii96x7': {
      'en': 'Ticket Details',
      'es': 'Detalles de las entradas',
      'fr': 'Détails du billet',
    },
    'd19xozqx': {
      'en': 'Site: ',
      'es': 'Evento:',
      'fr': 'Événement:',
    },
    'k5xspbd6': {
      'en': 'Date:',
      'es': 'Fecha:',
      'fr': 'Date:',
    },
    '3opf2pap': {
      'en': 'Ticket ID:',
      'es': 'ID del ticket:',
      'fr': 'ID du billet :',
    },
    'n7vw0h3g': {
      'en': 'Done',
      'es': 'Ver boleto',
      'fr': 'Voir le billet',
    },
  },
  // emptyWidget
  {
    'o268r0yh': {
      'en': 'No favorite sites saved yet',
      'es': '',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    'kpygqvwt': {
      'en': 'We need camera permissions for your prifuler and car photos',
      'es':
          'Necesitamos permisos de cámara para tus fotos privadas y del auto.',
      'fr':
          'Nous avons besoin d\'autorisations pour vos photos de voiture et de prifuler',
    },
    'x0lz8xxi': {
      'en':
          'We need access to your library for photos about your car and profile',
      'es': 'Necesitamos acceso a tu biblioteca de fotos de tu coche y perfil.',
      'fr':
          'Nous avons besoin d\'accéder à votre bibliothèque pour des photos de votre voiture et de votre profil',
    },
    'xjrezccf': {
      'en': 'We need your camera for photo proifles and car images',
      'es':
          'Necesitamos tu cámara para fotos de perfiles e imágenes de coches.',
      'fr':
          'Nous avons besoin de votre appareil photo pour les profils photo et les images de voiture',
    },
    'uzr1l50e': {
      'en': 'We need your location to alert you of KNEX enabled paces',
      'es':
          'Necesitamos tu ubicación para avisarte de los espacios habilitados para KNEX',
      'fr':
          'Nous avons besoin de votre localisation pour vous alerter des pas activés par KNEX',
    },
    'ede84qgz': {
      'en': 'We need to notify when you are in a knex anebaled location',
      'es':
          'Necesitamos notificarte cuando estés en una ubicación anexada a Knex',
      'fr':
          'Nous devons vous avertir lorsque vous vous trouvez dans un endroit où Knex est anéanti.',
    },
    'zjf4ino9': {
      'en': 'We need access to photos for you profile and car images',
      'es': 'Necesitamos acceso a fotos de tu perfil e imágenes de tu auto.',
      'fr':
          'Nous avons besoin d\'accéder aux photos de votre profil et aux images de votre voiture',
    },
    'x7lon6x8': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '5pr4klco': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '8a6umrdz': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'el9qyiec': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'r1p2a80b': {
      'en': '',
      'es': '',
      'fr': '',
    },
    's1mvpdbv': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'fm76kwox': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'vfg6na4t': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '1t6vw4h5': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '2mrnnjde': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '55zplt1s': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'ba9escvd': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'mrjv8c85': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'xyctnq3t': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'c5cdksa7': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'c0utddn9': {
      'en': '',
      'es': '',
      'fr': '',
    },
    't5fgpf9i': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '0u4u44ce': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '9c9ysbi1': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'u69csr9r': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'j07hpk1p': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'yhmng0vs': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'p41qoph1': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'r64weizj': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'rk6gq62s': {
      'en': '',
      'es': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
