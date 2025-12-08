import 'dart:math';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Florida-themed, comedic error and status messages for the app.
/// Supports English, Spanish, and French translations.
/// Safe for all audiences while keeping that sunshine state vibe!
class FloridaMessages {
  static final _random = Random();

  /// Pick a random message from a list based on current language
  static String _randomFromLocalized(
      BuildContext context, List<Map<String, String>> messages) {
    final msg = messages[_random.nextInt(messages.length)];
    final lang = FFLocalizations.of(context).languageCode;

    // Return message in current language, fallback to English
    if (lang.startsWith('es')) return msg['es'] ?? msg['en']!;
    if (lang.startsWith('fr')) return msg['fr'] ?? msg['en']!;
    return msg['en']!;
  }

  /// Pick a random message without context (uses English)
  static String _randomFrom(List<String> messages) {
    return messages[_random.nextInt(messages.length)];
  }

  // ============================================
  // ERROR MESSAGES - MULTILINGUAL
  // ============================================

  /// Server error (500) messages - localized
  static String serverError(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Our servers took a beach day without asking. We're calling them back!",
          'es': "Nuestros servidores se fueron a la playa sin avisar. Los estamos llamando!",
          'fr': "Nos serveurs sont partis a la plage sans demander. On les rappelle!",
        },
        {
          'en': "Looks like our server caught a case of Florida Man syndrome. Stand by!",
          'es': "Parece que el servidor tiene sindrome de hombre de Florida. Espera un momento!",
          'fr': "On dirait que notre serveur a attrape le syndrome Florida Man. Patience!",
        },
        {
          'en': "The servers are stuck in I-95 traffic. Please hold tight!",
          'es': "Los servidores estan atrapados en el trafico de la I-95. Aguanta!",
          'fr': "Les serveurs sont coinces dans le trafic de l'I-95. Patience!",
        },
        {
          'en': "Our hamsters powering the servers escaped to Key West. Rounding them up!",
          'es': "Nuestros hamsters se escaparon a Key West. Los estamos buscando!",
          'fr': "Nos hamsters se sont echappes a Key West. On les rattrape!",
        },
        {
          'en': "Server's out getting a cafecito. Be right back!",
          'es': "El servidor salio por un cafecito. Ya vuelve!",
          'fr': "Le serveur est parti chercher un cafe. Il revient!",
        },
        {
          'en': "Even our servers need AC breaks in this heat. Cooling down...",
          'es': "Hasta nuestros servidores necesitan aire acondicionado. Enfriando...",
          'fr': "Meme nos serveurs ont besoin de clim. Refroidissement en cours...",
        },
        {
          'en': "The server went to grab some pastelitos. Should be back soon!",
          'es': "El servidor fue por unos pastelitos. Vuelve pronto!",
          'fr': "Le serveur est parti chercher des viennoiseries. Il revient vite!",
        },
        {
          'en': "Our tech team is wrestling an alligator. Figuratively. Maybe.",
          'es': "Nuestro equipo esta luchando con un caiman. Figurativamente. Quizas.",
          'fr': "Notre equipe lutte avec un alligator. Au sens figure. Peut-etre.",
        },
      ]);

  /// No internet connection messages - localized
  static String noInternet(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "No internet? Did a hurricane take out the WiFi again?",
          'es': "Sin internet? Un huracan tumbo el WiFi otra vez?",
          'fr': "Pas d'internet? Un ouragan a coupe le WiFi?",
        },
        {
          'en': "Looks like you're more disconnected than a snowbird in July.",
          'es': "Estas mas desconectado que un turista en julio.",
          'fr': "Tu es plus deconnecte qu'un touriste en juillet.",
        },
        {
          'en': "No signal! Are you in the Everglades or something?",
          'es': "Sin senal! Estas en los Everglades o que?",
          'fr': "Pas de signal! Tu es dans les Everglades ou quoi?",
        },
        {
          'en': "Internet's gone fishing. Check your connection!",
          'es': "El internet se fue a pescar. Revisa tu conexion!",
          'fr': "Internet est parti pecher. Verifie ta connexion!",
        },
        {
          'en': "Your WiFi is taking a siesta. Wake it up!",
          'es': "Tu WiFi esta tomando una siesta. Despiertalo!",
          'fr': "Ton WiFi fait la sieste. Reveille-le!",
        },
        {
          'en': "Connection lost! Even Florida Man has better signal.",
          'es': "Conexion perdida! Hasta Florida Man tiene mejor senal.",
          'fr': "Connexion perdue! Meme Florida Man a un meilleur signal.",
        },
      ]);

  /// Timeout messages - localized
  static String timeout(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "This is taking longer than the line at Publix on Sunday.",
          'es': "Esto esta tardando mas que la cola del Publix el domingo.",
          'fr': "Ca prend plus de temps que la file au supermarche le dimanche.",
        },
        {
          'en': "Request timed out. Slower than a manatee in January!",
          'es': "Tiempo agotado. Mas lento que un manati en enero!",
          'fr': "Delai expire. Plus lent qu'un lamantin en janvier!",
        },
        {
          'en': "We're moving slower than beach traffic on a holiday weekend.",
          'es': "Vamos mas lento que el trafico a la playa en fin de semana.",
          'fr': "On avance plus lentement que le trafic vers la plage le week-end.",
        },
        {
          'en': "Timed out! Our server's on island time apparently.",
          'es': "Tiempo agotado! El servidor esta en hora de isla.",
          'fr': "Delai depasse! Notre serveur est a l'heure des iles.",
        },
        {
          'en': "This is taking longer than waiting for your Cuban sandwich.",
          'es': "Esto tarda mas que esperar un sandwich cubano.",
          'fr': "Ca prend plus de temps qu'attendre un sandwich cubain.",
        },
      ]);

  /// Session expired (401) messages - localized
  static String sessionExpired(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Your session expired faster than ice cream in Miami.",
          'es': "Tu sesion expiro mas rapido que un helado en Miami.",
          'fr': "Ta session a expire plus vite qu'une glace a Miami.",
        },
        {
          'en': "Logged out! Your session melted in the Florida sun.",
          'es': "Desconectado! Tu sesion se derritio bajo el sol de Florida.",
          'fr': "Deconnecte! Ta session a fondu sous le soleil de Floride.",
        },
        {
          'en': "Time to log in again - your session went on vacation.",
          'es': "Hora de iniciar sesion otra vez - tu sesion se fue de vacaciones.",
          'fr': "Il faut te reconnecter - ta session est partie en vacances.",
        },
        {
          'en': "Session's gone! Like a tourist after spring break.",
          'es': "Sesion perdida! Como un turista despues del spring break.",
          'fr': "Session terminee! Comme un touriste apres les vacances.",
        },
        {
          'en': "Your login took an early retirement to Boca. Sign in again!",
          'es': "Tu sesion se jubilo temprano en Boca. Inicia sesion otra vez!",
          'fr': "Ta connexion a pris sa retraite anticipee. Reconnecte-toi!",
        },
      ]);

  /// Not found (404) messages - localized
  static String notFound(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "404: We looked everywhere, even under the palm trees!",
          'es': "404: Buscamos por todas partes, hasta debajo de las palmeras!",
          'fr': "404: On a cherche partout, meme sous les palmiers!",
        },
        {
          'en': "Can't find that! It's hiding better than a gecko.",
          'es': "No lo encontramos! Se esconde mejor que una lagartija.",
          'fr': "Introuvable! Ca se cache mieux qu'un gecko.",
        },
        {
          'en': "Not found. Maybe it floated away to the Bahamas?",
          'es': "No encontrado. Quizas floto hasta las Bahamas?",
          'fr': "Introuvable. C'est peut-etre parti aux Bahamas?",
        },
        {
          'en': "We searched from Pensacola to Key West. Nada!",
          'es': "Buscamos desde Pensacola hasta Key West. Nada!",
          'fr': "On a cherche de Pensacola a Key West. Rien!",
        },
        {
          'en': "Missing! Last seen heading south on US-1.",
          'es': "Desaparecido! Visto por ultima vez rumbo al sur por la US-1.",
          'fr': "Disparu! Vu pour la derniere fois sur la US-1 direction sud.",
        },
      ]);

  /// Permission denied (403) messages - localized
  static String permissionDenied(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "No entry! This area is more exclusive than Fisher Island.",
          'es': "Sin acceso! Esta area es mas exclusiva que Fisher Island.",
          'fr': "Acces refuse! Cette zone est plus exclusive que Fisher Island.",
        },
        {
          'en': "Access denied. You need a VIP wristband for this!",
          'es': "Acceso denegado. Necesitas una pulsera VIP para esto!",
          'fr': "Acces refuse. Il te faut un bracelet VIP pour ca!",
        },
        {
          'en': "Sorry, this section is gated - like a fancy Naples community.",
          'es': "Lo siento, esta seccion esta cerrada - como las comunidades de Naples.",
          'fr': "Desole, cette section est privee - comme a Naples.",
        },
        {
          'en': "Can't go there! It's off-limits, like feeding the gators.",
          'es': "No puedes ir ahi! Esta prohibido, como alimentar caimanes.",
          'fr': "Impossible d'y aller! C'est interdit, comme nourrir les alligators.",
        },
      ]);

  /// Bad request (400) messages - localized
  static String badRequest(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "That request was confusing - like Florida weather forecasts.",
          'es': "Esa solicitud fue confusa - como el pronostico del tiempo en Florida.",
          'fr': "Cette requete etait confuse - comme la meteo en Floride.",
        },
        {
          'en': "Something's not right. Did autocorrect strike again?",
          'es': "Algo no esta bien. El autocorrector ataco de nuevo?",
          'fr': "Quelque chose ne va pas. L'autocorrecteur a encore frappe?",
        },
        {
          'en': "We couldn't understand that. Try again, por favor!",
          'es': "No entendimos eso. Intentalo de nuevo, por favor!",
          'fr': "On n'a pas compris. Reessaie, s'il te plait!",
        },
        {
          'en': "Invalid request! Let's try that again, nice and easy.",
          'es': "Solicitud invalida! Intentemoslo de nuevo, con calma.",
          'fr': "Requete invalide! Reessayons, doucement.",
        },
      ]);

  /// Generic error messages - localized
  static String genericError(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Well, that didn't work. But hey, at least there's sunshine!",
          'es': "Bueno, eso no funciono. Pero hey, al menos hay sol!",
          'fr': "Bon, ca n'a pas marche. Mais au moins il y a du soleil!",
        },
        {
          'en': "Oops! Something went sideways. Stay calm and stay tropical.",
          'es': "Ups! Algo salio mal. Mantente tranquilo y tropical.",
          'fr': "Oups! Ca a derape. Reste calme et tropical.",
        },
        {
          'en': "Houston... er, Miami, we have a problem!",
          'es': "Houston... digo, Miami, tenemos un problema!",
          'fr': "Houston... euh, Miami, on a un probleme!",
        },
        {
          'en': "Things went a little loco. Let's try again!",
          'es': "Las cosas se pusieron un poco locas. Intentemos de nuevo!",
          'fr': "Les choses ont derape. Reessayons!",
        },
        {
          'en': "That didn't go as planned. Time for Plan B(each)!",
          'es': "Eso no salio como planeamos. Hora del Plan B(laya)!",
          'fr': "Ca ne s'est pas passe comme prevu. Plan B(lage)!",
        },
      ]);

  /// Service unavailable (502, 503, 504) messages - localized
  static String serviceUnavailable(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Service is taking a break. Even servers need sunscreen time!",
          'es': "El servicio esta descansando. Hasta los servidores necesitan bloqueador!",
          'fr': "Le service fait une pause. Meme les serveurs ont besoin de creme solaire!",
        },
        {
          'en': "Temporarily closed for renovations. Like half of Miami.",
          'es': "Temporalmente cerrado por renovaciones. Como la mitad de Miami.",
          'fr': "Temporairement ferme pour renovation. Comme la moitie de Miami.",
        },
        {
          'en': "We're experiencing technical difficulties. Blame the humidity!",
          'es': "Estamos experimentando dificultades tecnicas. Culpa a la humedad!",
          'fr': "On a des difficultes techniques. C'est la faute de l'humidite!",
        },
        {
          'en': "Service unavailable. Our team is on it faster than a thunderstorm rolls in!",
          'es': "Servicio no disponible. Nuestro equipo esta en ello mas rapido que una tormenta!",
          'fr': "Service indisponible. Notre equipe s'en occupe plus vite qu'un orage!",
        },
      ]);

  // ============================================
  // SUCCESS MESSAGES - MULTILINGUAL
  // ============================================

  /// Generic success messages - localized
  static String success(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Success! Smoother than a Key Lime pie.",
          'es': "Exito! Mas suave que un pie de limon.",
          'fr': "Succes! Plus doux qu'une tarte au citron vert.",
        },
        {
          'en': "Done! That was easier than finding a Publix.",
          'es': "Listo! Eso fue mas facil que encontrar un Publix.",
          'fr': "Termine! Plus facile que trouver un supermarche.",
        },
        {
          'en': "All set! You're doing great, sunshine!",
          'es': "Todo listo! Lo estas haciendo genial, sol!",
          'fr': "C'est fait! Tu te debrouilles super bien!",
        },
        {
          'en': "Perfecto! You're on a roll like a Cuban sandwich.",
          'es': "Perfecto! Estas en racha como un sandwich cubano.",
          'fr': "Parfait! Tu es en forme comme un sandwich cubain.",
        },
        {
          'en': "Nailed it! Give yourself a cafecito break.",
          'es': "Lo lograste! Date un descanso con un cafecito.",
          'fr': "Bravo! Offre-toi une pause cafe.",
        },
      ]);

  /// Loading complete messages - localized
  static String loadingComplete(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "All loaded up! Ready to roll.",
          'es': "Todo cargado! Listo para rodar.",
          'fr': "Tout charge! Pret a demarrer.",
        },
        {
          'en': "Done loading! Faster than a Florida thunderstorm.",
          'es': "Carga completa! Mas rapido que una tormenta de Florida.",
          'fr': "Chargement termine! Plus rapide qu'un orage en Floride.",
        },
        {
          'en': "Ready to go! Let's do this!",
          'es': "Listo para ir! Hagamoslo!",
          'fr': "Pret a partir! C'est parti!",
        },
      ]);

  // ============================================
  // LOADING MESSAGES - MULTILINGUAL
  // ============================================

  /// Loading/waiting messages - localized
  static String loading(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Loading... Grab a cafecito while you wait!",
          'es': "Cargando... Toma un cafecito mientras esperas!",
          'fr': "Chargement... Prends un cafe en attendant!",
        },
        {
          'en': "Hang tight! Good things come to those who wait.",
          'es': "Aguanta! Las cosas buenas llegan a quienes esperan.",
          'fr': "Patience! Les bonnes choses arrivent a ceux qui attendent.",
        },
        {
          'en': "Working on it... Like a pelican diving for fish.",
          'es': "Trabajando en ello... Como un pelicano buscando peces.",
          'fr': "On y travaille... Comme un pelican qui plonge.",
        },
        {
          'en': "Just a moment... Patience, grasshopper!",
          'es': "Un momento... Paciencia, saltamontes!",
          'fr': "Un instant... Patience, petit scarabee!",
        },
        {
          'en': "Loading... Almost as fast as Florida Man makes headlines!",
          'es': "Cargando... Casi tan rapido como Florida Man sale en las noticias!",
          'fr': "Chargement... Presque aussi vite que Florida Man fait les gros titres!",
        },
      ]);

  // ============================================
  // EMPTY STATE MESSAGES - MULTILINGUAL
  // ============================================

  /// No results/empty state messages - localized
  static String noResults(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Nothing here yet! Emptier than a beach at 6am.",
          'es': "Nada aqui todavia! Mas vacio que una playa a las 6am.",
          'fr': "Rien ici pour l'instant! Plus vide qu'une plage a 6h.",
        },
        {
          'en': "No results. Quieter than the Everglades at dawn.",
          'es': "Sin resultados. Mas silencioso que los Everglades al amanecer.",
          'fr': "Aucun resultat. Plus calme que les Everglades a l'aube.",
        },
        {
          'en': "Nada, zip, zilch! Let's change that.",
          'es': "Nada de nada! Cambiemos eso.",
          'fr': "Rien, que dalle! Changeons ca.",
        },
        {
          'en': "Empty! Like a snowbird's house in summer.",
          'es': "Vacio! Como la casa de un snowbird en verano.",
          'fr': "Vide! Comme la maison d'un snowbird en ete.",
        },
      ]);

  // ============================================
  // BUTTON TEXT - MULTILINGUAL
  // ============================================

  /// Retry button text options - localized
  static String retryButton(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Try Again", 'es': "Intentar de Nuevo", 'fr': "Reessayer"},
        {'en': "Give It Another Shot", 'es': "Dale Otra Oportunidad", 'fr': "Encore un Essai"},
        {'en': "Let's Go Again", 'es': "Vamos de Nuevo", 'fr': "On y Retourne"},
        {'en': "One More Time", 'es': "Una Vez Mas", 'fr': "Encore Une Fois"},
        {'en': "Retry, Amigo", 'es': "Reintentar, Amigo", 'fr': "Reessaie, Mon Ami"},
      ]);

  /// OK button text - localized
  static String okButton(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Got It!", 'es': "Entendido!", 'fr': "Compris!"},
        {'en': "OK", 'es': "OK", 'fr': "OK"},
        {'en': "Alright!", 'es': "De Acuerdo!", 'fr': "D'accord!"},
        {'en': "Cool", 'es': "Genial", 'fr': "Super"},
      ]);

  /// Cancel button text - localized
  static String cancelButton(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Cancel", 'es': "Cancelar", 'fr': "Annuler"},
        {'en': "Never Mind", 'es': "Olvidalo", 'fr': "Laisse Tomber"},
        {'en': "Not Now", 'es': "Ahora No", 'fr': "Pas Maintenant"},
      ]);

  // ============================================
  // ERROR TITLES - MULTILINGUAL
  // ============================================

  /// Error screen titles - localized
  static String errorTitle(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Oops!", 'es': "Ups!", 'fr': "Oups!"},
        {'en': "Ay Caramba!", 'es': "Ay Caramba!", 'fr': "Oh la la!"},
        {'en': "Well, Shucks!", 'es': "Vaya!", 'fr': "Zut alors!"},
        {'en': "Uh Oh!", 'es': "Oh No!", 'fr': "Oh Non!"},
        {'en': "Yikes!", 'es': "Caramba!", 'fr': "Aie!"},
        {'en': "Hold Up!", 'es': "Espera!", 'fr': "Attends!"},
      ]);

  /// Success screen titles - localized
  static String successTitle(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Awesome!", 'es': "Genial!", 'fr': "Super!"},
        {'en': "Sweet!", 'es': "Excelente!", 'fr': "Chouette!"},
        {'en': "You Did It!", 'es': "Lo Lograste!", 'fr': "Tu l'as fait!"},
        {'en': "High Five!", 'es': "Choca Esos Cinco!", 'fr': "Tope la!"},
      ]);

  // ============================================
  // AUTH MESSAGES - MULTILINGUAL
  // ============================================

  /// Password reset sent - localized
  static String passwordResetSent(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Password reset email sent! Check your inbox (and spam, just in case).",
          'es': "Correo de restablecimiento enviado! Revisa tu bandeja (y el spam, por si acaso).",
          'fr': "Email de reinitialisation envoye! Verifie ta boite (et les spams, au cas ou).",
        },
      ]);

  /// Sign in required - localized
  static String signInRequired(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "It's been a while! Please sign in again for security.",
          'es': "Ha pasado tiempo! Por favor inicia sesion de nuevo por seguridad.",
          'fr': "Ca fait un moment! Reconnecte-toi pour la securite.",
        },
        {
          'en': "Your session took a siesta. Time to log back in!",
          'es': "Tu sesion se tomo una siesta. Hora de volver a entrar!",
          'fr': "Ta session a fait la sieste. Il faut te reconnecter!",
        },
      ]);

  /// Email already in use - localized
  static String emailAlreadyInUse(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "That email's already taken! Someone beat you to it.",
          'es': "Ese correo ya esta en uso! Alguien te gano.",
          'fr': "Cet email est deja pris! Quelqu'un t'a devance.",
        },
      ]);

  /// Invalid credentials - localized
  static String invalidCredentials(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Hmm, those credentials don't match. Double-check and try again!",
          'es': "Hmm, esas credenciales no coinciden. Revisa e intenta de nuevo!",
          'fr': "Hmm, ces identifiants ne correspondent pas. Verifie et reessaie!",
        },
      ]);

  // ============================================
  // PAYMENT/TIP MESSAGES - MULTILINGUAL
  // ============================================

  /// Tip empty error - localized
  static String tipEmpty(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Don't forget the tip! Our valets work hard in this Florida heat.",
          'es': "No olvides la propina! Nuestros valets trabajan duro en este calor.",
          'fr': "N'oublie pas le pourboire! Nos voituriers travaillent dur sous cette chaleur.",
        },
      ]);

  /// Select valid option - localized
  static String selectValidOption(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Pick an option first! Like choosing between beach or pool.",
          'es': "Elige una opcion primero! Como elegir entre playa o piscina.",
          'fr': "Choisis une option d'abord! Comme choisir entre plage ou piscine.",
        },
      ]);

  /// Payment error - localized
  static String paymentError(BuildContext context, String? details) {
    final baseMsg = _randomFromLocalized(context, [
      {
        'en': "Payment hiccup! Don't worry, your card is safe.",
        'es': "Problema con el pago! No te preocupes, tu tarjeta esta segura.",
        'fr': "Souci de paiement! Ne t'inquiete pas, ta carte est en securite.",
      },
    ]);
    return details != null && details.isNotEmpty ? "$baseMsg ($details)" : baseMsg;
  }

  // ============================================
  // FORM VALIDATION - MULTILINGUAL
  // ============================================

  /// License plate required - localized
  static String plateRequired(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "We need your plate number! Can't valet a mystery car, even in Florida.",
          'es': "Necesitamos tu numero de placa! No podemos estacionar un carro misterioso.",
          'fr': "Il nous faut ta plaque! On ne peut pas garer une voiture mystere.",
        },
        {
          'en': "License plate, please! Our valets aren't mind readers (yet).",
          'es': "Placa, por favor! Nuestros valets no leen mentes (todavia).",
          'fr': "Plaque d'immatriculation, s'il te plait! Nos voituriers ne lisent pas les pensees.",
        },
        {
          'en': "No plate? That's more mysterious than the Bermuda Triangle!",
          'es': "Sin placa? Eso es mas misterioso que el Triangulo de las Bermudas!",
          'fr': "Pas de plaque? C'est plus mysterieux que le Triangle des Bermudes!",
        },
      ]);

  /// Email required - localized
  static String emailRequired(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "We need your email! How else will we send you beach-worthy updates?",
          'es': "Necesitamos tu correo! Como te enviamos las actualizaciones?",
          'fr': "Il nous faut ton email! Comment t'envoyer les mises a jour sinon?",
        },
        {
          'en': "Email required! Don't leave us hanging like a palm tree in the wind.",
          'es': "Correo requerido! No nos dejes colgados como una palmera al viento.",
          'fr': "Email requis! Ne nous laisse pas en plan comme un palmier au vent.",
        },
      ]);

  /// Passwords don't match - localized
  static String passwordsDontMatch(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Those passwords are as mismatched as socks on a beach day!",
          'es': "Esas contrasenas no coinciden, como calcetines en la playa!",
          'fr': "Ces mots de passe ne correspondent pas, comme des chaussettes a la plage!",
        },
        {
          'en': "Passwords don't match! They're going in different directions like I-95 traffic.",
          'es': "Las contrasenas no coinciden! Van en direcciones opuestas como el trafico de la I-95.",
          'fr': "Les mots de passe ne correspondent pas! Ils vont dans des directions opposees.",
        },
        {
          'en': "Oops! Your passwords are more different than Miami and the Keys.",
          'es': "Ups! Tus contrasenas son mas diferentes que Miami y los Cayos.",
          'fr': "Oups! Tes mots de passe sont plus differents que Miami et les Keys.",
        },
      ]);

  /// Profile photo required - localized
  static String photoRequired(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "We need your photo! Our valets want to recognize your sunny face.",
          'es': "Necesitamos tu foto! Nuestros valets quieren reconocer tu cara soleada.",
          'fr': "Il nous faut ta photo! Nos voituriers veulent reconnaitre ton visage ensoleille.",
        },
        {
          'en': "Profile pic required! Show us that Florida glow.",
          'es': "Foto de perfil requerida! Muestranos ese brillo de Florida.",
          'fr': "Photo de profil requise! Montre-nous cet eclat floridien.",
        },
        {
          'en': "No photo? Our attendants need to spot you faster than a flamingo in a parking lot!",
          'es': "Sin foto? Nuestros asistentes necesitan reconocerte mas rapido que un flamingo!",
          'fr': "Pas de photo? Nos assistants doivent te reperer plus vite qu'un flamant rose!",
        },
      ]);

  /// State selection required - localized
  static String stateRequired(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Pick a state! We're guessing Florida, but we need to be sure.",
          'es': "Selecciona un estado! Adivinamos Florida, pero necesitamos estar seguros.",
          'fr': "Choisis un etat! On devine Floride, mais on doit etre sur.",
        },
        {
          'en': "State required! Even Florida Man has to say where he's from.",
          'es': "Estado requerido! Hasta Florida Man tiene que decir de donde es.",
          'fr': "Etat requis! Meme Florida Man doit dire d'ou il vient.",
        },
      ]);

  /// Invalid file format - localized
  static String invalidFileFormat(BuildContext context, String? format) {
    final baseMsg = _randomFromLocalized(context, [
      {
        'en': "That file format is fishier than a Key West dock!",
        'es': "Ese formato de archivo es mas sospechoso que un muelle de Key West!",
        'fr': "Ce format de fichier est plus louche qu'un quai de Key West!",
      },
      {
        'en': "Invalid format! We can't read that like we can't read hurricane paths.",
        'es': "Formato invalido! No podemos leer eso como no podemos leer los huracanes.",
        'fr': "Format invalide! On ne peut pas lire ca comme on ne peut pas lire les ouragans.",
      },
    ]);
    return format != null && format.isNotEmpty ? "$baseMsg ($format)" : baseMsg;
  }

  /// No favorites yet - localized
  static String noFavoritesYet(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "No favorites yet! Like a beach towel waiting for someone to claim it.",
          'es': "Sin favoritos todavia! Como una toalla de playa esperando que la reclamen.",
          'fr': "Pas de favoris encore! Comme une serviette de plage qui attend d'etre reclamee.",
        },
        {
          'en': "Empty favorites? Time to explore! Florida has plenty of hidden gems.",
          'es': "Favoritos vacios? Hora de explorar! Florida tiene muchas joyas ocultas.",
          'fr': "Favoris vides? C'est le moment d'explorer! La Floride a plein de tresors caches.",
        },
        {
          'en': "No saved spots yet. Like a snowbird who hasn't found their winter home!",
          'es': "Sin lugares guardados. Como un snowbird que no ha encontrado su casa de invierno!",
          'fr': "Pas d'endroits sauvegardes. Comme un snowbird qui n'a pas trouve sa maison d'hiver!",
        },
      ]);

  // ============================================
  // MEDIA SELECTION - MULTILINGUAL
  // ============================================

  /// Choose source title - localized
  static String chooseSource(BuildContext context) => _randomFromLocalized(context, [
        {
          'en': "Choose Source",
          'es': "Elegir Fuente",
          'fr': "Choisir Source",
        },
      ]);

  /// Gallery photo option - localized
  static String galleryPhoto(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Gallery (Photo)", 'es': "Galeria (Foto)", 'fr': "Galerie (Photo)"},
      ]);

  /// Gallery video option - localized
  static String galleryVideo(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Gallery (Video)", 'es': "Galeria (Video)", 'fr': "Galerie (Video)"},
      ]);

  /// Gallery option - localized
  static String gallery(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Gallery", 'es': "Galeria", 'fr': "Galerie"},
      ]);

  /// Camera option - localized
  static String camera(BuildContext context) => _randomFromLocalized(context, [
        {'en': "Camera", 'es': "Camara", 'fr': "Appareil Photo"},
      ]);

  // ============================================
  // HELPER METHODS - WITH CONTEXT
  // ============================================

  /// Returns an appropriate Florida-themed message based on HTTP status code
  static String getMessageForStatusCode(BuildContext context, int statusCode) {
    switch (statusCode) {
      case 400:
        return badRequest(context);
      case 401:
        return sessionExpired(context);
      case 403:
        return permissionDenied(context);
      case 404:
        return notFound(context);
      case 500:
        return serverError(context);
      case 502:
      case 503:
      case 504:
        return serviceUnavailable(context);
      default:
        if (statusCode >= 400 && statusCode < 500) {
          return badRequest(context);
        } else if (statusCode >= 500) {
          return serverError(context);
        }
        return genericError(context);
    }
  }

  /// Returns an appropriate Florida-themed message based on error type
  static String getMessageForError(BuildContext context, dynamic error) {
    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('timeout') || errorStr.contains('timed out')) {
      return timeout(context);
    } else if (errorStr.contains('socket') ||
               errorStr.contains('network') ||
               errorStr.contains('connection')) {
      return noInternet(context);
    } else if (errorStr.contains('401') || errorStr.contains('unauthorized')) {
      return sessionExpired(context);
    } else if (errorStr.contains('403') || errorStr.contains('forbidden')) {
      return permissionDenied(context);
    } else if (errorStr.contains('404') || errorStr.contains('not found')) {
      return notFound(context);
    } else if (errorStr.contains('500') || errorStr.contains('server')) {
      return serverError(context);
    }

    return genericError(context);
  }

  // ============================================
  // STATIC HELPERS (NO CONTEXT - ENGLISH ONLY)
  // Used when BuildContext is not available
  // ============================================

  /// Server error - English only (for use without context)
  static String get serverErrorStatic => _randomFrom([
        "Our servers took a beach day without asking. We're calling them back!",
        "The servers are stuck in I-95 traffic. Please hold tight!",
        "Server's out getting a cafecito. Be right back!",
      ]);

  /// Generic error - English only (for use without context)
  static String get genericErrorStatic => _randomFrom([
        "Well, that didn't work. But hey, at least there's sunshine!",
        "Oops! Something went sideways. Stay calm and stay tropical.",
        "Houston... er, Miami, we have a problem!",
      ]);

  /// Get message for status code - English only (for use without context)
  static String getMessageForStatusCodeStatic(int statusCode) {
    switch (statusCode) {
      case 400:
        return _randomFrom([
          "That request was confusing - like Florida weather forecasts.",
          "Something's not right. Did autocorrect strike again?",
        ]);
      case 401:
        return _randomFrom([
          "Your session expired faster than ice cream in Miami.",
          "Time to log in again - your session went on vacation.",
        ]);
      case 403:
        return _randomFrom([
          "No entry! This area is more exclusive than Fisher Island.",
          "Access denied. You need a VIP wristband for this!",
        ]);
      case 404:
        return _randomFrom([
          "404: We looked everywhere, even under the palm trees!",
          "Can't find that! It's hiding better than a gecko.",
        ]);
      case 500:
        return serverErrorStatic;
      case 502:
      case 503:
      case 504:
        return _randomFrom([
          "Service is taking a break. Even servers need sunscreen time!",
          "Temporarily closed for renovations. Like half of Miami.",
        ]);
      default:
        if (statusCode >= 400 && statusCode < 500) {
          return _randomFrom([
            "That request was confusing - like Florida weather forecasts.",
            "We couldn't understand that. Try again, por favor!",
          ]);
        } else if (statusCode >= 500) {
          return serverErrorStatic;
        }
        return genericErrorStatic;
    }
  }

  /// Timeout error - English only (for use without context)
  static String get timeoutStatic => _randomFrom([
        "This is taking longer than the line at Publix on Sunday.",
        "Request timed out. Slower than a manatee in January!",
        "Timed out! Our server's on island time apparently.",
      ]);

  /// No internet error - English only (for use without context)
  static String get noInternetStatic => _randomFrom([
        "No internet? Did a hurricane take out the WiFi again?",
        "No signal! Are you in the Everglades or something?",
        "Internet's gone fishing. Check your connection!",
      ]);

  /// Get message for error - English only (for use without context)
  static String getMessageForErrorStatic(dynamic error) {
    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('timeout') || errorStr.contains('timed out')) {
      return timeoutStatic;
    } else if (errorStr.contains('socket') ||
               errorStr.contains('network') ||
               errorStr.contains('connection')) {
      return noInternetStatic;
    } else if (errorStr.contains('401') || errorStr.contains('unauthorized')) {
      return getMessageForStatusCodeStatic(401);
    } else if (errorStr.contains('403') || errorStr.contains('forbidden')) {
      return getMessageForStatusCodeStatic(403);
    } else if (errorStr.contains('404') || errorStr.contains('not found')) {
      return getMessageForStatusCodeStatic(404);
    } else if (errorStr.contains('500') || errorStr.contains('server')) {
      return serverErrorStatic;
    }

    return genericErrorStatic;
  }
}
