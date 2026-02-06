# KNEX Client - Demo Mode

## Overview
Demo mode allows the app to run fully without a live backend or Firebase auth. All API calls return mock data, and write operations persist in-memory for the session.

## Running in Demo Mode
```bash
# List available simulators
xcrun simctl list devices available

# Run with demo mode enabled
flutter run --dart-define=DEMO_MODE=true -d <SIMULATOR_ID>
```

Normal mode (no flag or `DEMO_MODE=false`) is completely unaffected.

## Architecture

### Factory + Guard Clause Pattern
- `ApiClient()` uses a factory constructor that returns `MockApiClient` when `DEMO_MODE=true`
- Custom actions (`sendjsontourl`, `sendprofile`, `get_user`, `create_ticket`) have guard clauses at the top
- **Zero widget file changes** - the factory pattern intercepts all structured API calls transparently

### Key Files

| File | Role |
|------|------|
| `lib/demo/demo_config.dart` | Compile-time constant: `bool.fromEnvironment('DEMO_MODE')` |
| `lib/demo/demo_auth.dart` | `DemoAuthUser extends BaseAuthUser` with hardcoded demo user |
| `lib/backend/api_client/mock_api_client.dart` | `part of` api_client.dart, overrides all 22 API methods |

### Modified Files

| File | Change |
|------|--------|
| `lib/backend/api_client/api_client.dart` | Factory constructor: `MockApiClient` in demo, `ApiClient._real()` otherwise |
| `lib/main.dart` | Skips Firebase, Stripe, Notifications, Crashlytics init |
| `lib/auth/firebase_auth/auth_util.dart` | Demo JWT token, email, uid getters |
| `lib/auth/firebase_auth/firebase_user_provider.dart` | Emits `DemoAuthUser` stream immediately |
| `lib/auth/firebase_auth/firebase_auth_manager.dart` | Sign-in returns `DemoAuthUser`, sign-out is no-op |
| `lib/utils/flow_manager.dart` | Hardcoded schema with required fields |
| `lib/custom_code/actions/sendjsontourl.dart` | URL-based mock responses |
| `lib/custom_code/actions/sendprofile.dart` | Returns success with submitted data |
| `lib/custom_code/actions/get_user.dart` | Returns demo profile JSON |
| `lib/custom_code/actions/create_ticket.dart` | Returns success with PIN |

## Mock Data

| Data | Count | Details |
|------|-------|---------|
| Profile | 1 | Alex Sunshine, demo@knex-app.xyz, (305) 555-0123, Fort Lauderdale |
| Locations | 3 | Truluck's Fort Lauderdale, The Breakers Palm Beach, Brickell City Centre |
| Vehicles | 0 initial | Created in-memory when user goes through AddCars |
| Tickets | 0 initial | Created in-memory when user creates a ticket |

Static in-memory stores (`MockApiClient._profiles`, `_vehicles`, `_tickets`, `_locations`) survive widget rebuilds since they are Dart statics.

## Test Flow

1. App launches -> splash -> HomePage (auto-logged in as demo user)
2. HomePage shows 3 Florida locations in carousel
3. Tap location -> SiteDetails shows name, address, bio, photos
4. Tap "Request Valet" -> AddCars form, fill in car details, submit -> creates in-memory vehicle + ticket
5. Redirects to Ticket view showing active ticket with PIN
6. Profile tab shows Alex Sunshine's info
7. ProfileCreate editable with pre-filled data
8. History tab shows ticket list
9. FavoritesSites works (toggle favorites via FFAppState.myFavs)

## Adding New Mock Data

To add a new mock location, edit the `_locations` list in `lib/backend/api_client/mock_api_client.dart`:
```dart
Location.fromMap({
  'id': 'loc_004',
  'name': 'Your Location Name',
  'address': '123 Main St, Miami, FL 33101',
  'coordinates_latitude': 25.7617,
  'coordinates_longitude': -80.1918,
  'image': 'https://example.com/image.jpg',
  'bio': 'Description of the location.',
  'Company': {'name': 'KNEX Valet'},
  'currency': 'USD',
  'value': 15.00,
  'photos': ['https://example.com/photo1.jpg'],
  'notes': 'Instructions for valet pickup.',
}),
```

## Troubleshooting

- **App still tries to connect to Firebase**: Make sure you're passing `--dart-define=DEMO_MODE=true` (not `--dart-define DEMO_MODE=true`)
- **Mock data resets on hot restart**: This is expected. Static stores reset when the Dart VM restarts. Hot reload preserves them.
- **New API method not mocked**: Add an override in `MockApiClient` (mock_api_client.dart). The `part of` directive gives access to the parent class.
