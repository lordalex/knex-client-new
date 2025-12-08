# KNEX Client - Project Context for Claude

## Project Overview
KNEX is a valet parking service app built with **Flutter** and **FlutterFlow**. The app allows users to request valet services, manage their vehicles, and pay for services including tips via Stripe.

## Tech Stack
- **Framework**: Flutter (FlutterFlow exported project)
- **Backend**: Firebase (Auth, Firestore)
- **Payments**: Stripe
- **State Management**: FlutterFlow's built-in state (`FFAppState`)
- **Localization**: FFLocalizations (supports EN, ES, FR)

## Flutter SDK Location
```
/Volumes/FireDrive/Code/flutter/bin/flutter
```

## Running the App
```bash
# List available simulators
xcrun simctl list devices available

# Run on iOS Simulator
/Volumes/FireDrive/Code/flutter/bin/flutter run -d <DEVICE_ID>

# Hot reload: press 'r' in the terminal running flutter
# Hot restart: press 'R' in the terminal
```

## Project Structure
```
lib/
├── auth/firebase_auth/     # Firebase authentication
├── backend/                # Stripe, schemas, API calls
├── components/             # Reusable widgets
├── custom_code/actions/    # Custom Dart actions
├── flutter_flow/           # FlutterFlow utilities
├── home_page/              # Main home page
├── utils/                  # Utility classes (FloridaMessages)
└── [page_name]/            # Individual page folders
```

## Key Files

### Florida-Themed Messages System
The app uses fun, Florida-themed messages for all user-facing text. This system supports **English, Spanish, and French**.

**Main file**: `lib/utils/florida_messages.dart`

**Usage with BuildContext** (preferred):
```dart
FloridaMessages.errorTitle(context)
FloridaMessages.genericError(context)
FloridaMessages.retryButton(context)
FloridaMessages.plateRequired(context)
// etc.
```

**Static usage** (when BuildContext unavailable):
```dart
FloridaMessages.getMessageForStatusCodeStatic(500)
FloridaMessages.getMessageForErrorStatic(exception)
FloridaMessages.serverErrorStatic
FloridaMessages.genericErrorStatic
```

### Available Florida Messages
| Method | Purpose |
|--------|---------|
| `errorTitle(context)` | Error dialog/widget titles |
| `genericError(context)` | Generic error messages |
| `serverError(context)` | 500 server errors |
| `timeout(context)` | Request timeout |
| `noInternet(context)` | Connection issues |
| `sessionExpired(context)` | Auth token expired |
| `notFound(context)` | 404 errors |
| `forbidden(context)` | 403 errors |
| `badRequest(context)` | 400 errors |
| `retryButton(context)` | Retry button text |
| `okButton(context)` | OK button text |
| `cancelButton(context)` | Cancel button text |
| `loadingDefault(context)` | Loading indicator text |
| `successGeneric(context)` | Success messages |
| `plateRequired(context)` | License plate validation |
| `emailRequired(context)` | Email validation |
| `passwordsDontMatch(context)` | Password confirmation |
| `photoRequired(context)` | Profile photo validation |
| `stateRequired(context)` | State selection validation |
| `invalidFileFormat(context, format)` | File upload validation |
| `noFavoritesYet(context)` | Empty favorites state |
| `tipEmpty(context)` | Empty tip validation |
| `selectValidOption(context)` | Selection validation |
| `paymentError(context, details)` | Payment failures |
| `signInRequired(context)` | Re-authentication needed |
| `passwordResetSent(context)` | Password reset confirmation |
| `emailAlreadyInUse(context)` | Duplicate email error |
| `invalidCredentials(context)` | Wrong login credentials |
| `getMessageForStatusCode(context, code)` | HTTP status code messages |
| `getMessageForError(context, error)` | Exception-based messages |

### Error Handling Pattern
The app uses graceful error handling that returns error codes instead of throwing:

```dart
// In sendjsontourl.dart
Future<String> sendjsontourl(...) async {
  // Returns status code as string on error (e.g., "500")
  // instead of throwing exceptions
}

// Safe wrapper with Florida messages
Future<({bool success, String? data, String? errorMessage})> sendjsontourlSafe(...) async {
  // Returns structured result with Florida-themed error messages
}
```

### Error State Widget
`lib/components/error_state_widget.dart` - Reusable error UI component with:
- Animated error icon
- Customizable title and message
- Retry button
- Optional secondary action
- Compact mode for inline errors

### API Configuration
- Base URLs are stored in `FFAppConstants`
- Auth tokens use `currentJwtToken` from Firebase Auth
- API calls wrap data in `{"idToken": token, "data": payload}` format

## Localization
The app supports three languages via `FFLocalizations`:
- English (en) - default
- Spanish (es)
- French (fr)

Get current language:
```dart
FFLocalizations.of(context).languageCode // Returns 'en', 'es', or 'fr'
```

## Common Issues & Solutions

### App stuck in loading state
- Usually caused by API errors (500, timeout, etc.)
- Check the console logs for colored debug output
- The error handling system now gracefully displays errors instead of hanging

### Server 500 Error: "Converting circular structure to JSON"
- This is a **backend issue**, not a client issue
- The server's searchUser endpoint has a bug
- Client-side error handling displays a friendly message

### Flutter not found
- Use full path: `/Volumes/FireDrive/Code/flutter/bin/flutter`
- Or add to PATH via `.zshrc`

### Google Fonts loading error
- "Unable to load asset: AssetManifest.json" - usually resolves after hot restart
- Not critical for app functionality

## Files Modified for Florida Messages

### Core Files
- `lib/utils/florida_messages.dart` - Central message repository
- `lib/components/error_state_widget.dart` - Error UI component

### Pages Updated
- `lib/home_page/home_page_widget.dart` - Main page error handling
- `lib/home_page/home_page_model.dart` - Error state fields
- `lib/login_sign_up/login_sign_up_widget.dart` - Password validation
- `lib/profile_create/profile_create_widget.dart` - Profile validation
- `lib/add_cars/add_cars_widget.dart` - Plate validation
- `lib/deprecated/forgot_password/forgot_password_widget.dart` - Email validation

### Components Updated
- `lib/components/tip_bottom_sheet_widget.dart` - Tip validation
- `lib/components/empty_widget_widget.dart` - Empty state

### Auth & Utilities Updated
- `lib/auth/firebase_auth/firebase_auth_manager.dart` - Auth errors
- `lib/custom_code/actions/sendjsontourl.dart` - API error handling
- `lib/flutter_flow/upload_data.dart` - File format validation

## Adding New Florida Messages

1. Add the method to `lib/utils/florida_messages.dart`:
```dart
/// Description - localized
static String myNewMessage(BuildContext context) => _randomFromLocalized(context, [
  {
    'en': "English message with Florida flair!",
    'es': "Spanish translation here!",
    'fr': "French translation here!",
  },
  {
    'en': "Alternative English message for variety!",
    'es': "Alternative Spanish!",
    'fr': "Alternative French!",
  },
]);
```

2. Import and use in your widget:
```dart
import '/utils/florida_messages.dart';
// ...
Text(FloridaMessages.myNewMessage(context))
```

## Git Information
- Main branch: `dev`
- Current branch: `refactor/newapiversion`

## Notes for Future Sessions
- The backend API has issues (circular JSON bug) - this is server-side, not client
- All user-facing messages should use FloridaMessages for consistency
- Messages randomly vary to keep the UX fresh and fun
- Always provide all three language translations (EN/ES/FR)
- Keep messages family-friendly and respectful
