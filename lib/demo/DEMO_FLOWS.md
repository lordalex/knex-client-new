# KNEX Client - Demo Mode Flows

## Running Demo Mode
```bash
xcrun simctl list devices available
flutter run --dart-define=DEMO_MODE=true -d <SIMULATOR_ID>
```

---

## All Available Pages

| Page | Route | Description |
|------|-------|-------------|
| LoginSignUpWidget | `/loginSignUp` | Authentication (bypassed in demo) |
| ProfileCreateWidget | `/profileCreate` | Create/edit user profile |
| HomePageWidget | `/mainHomePage` | Main hub - location carousel |
| SiteDetailsWidget | `/siteDetails?id={id}` | Location details & photos |
| AddCarsWidget | `/addCars?id={id}` | Vehicle form |
| TicketWidget | `/ticket` | Active ticket view |
| TicketTimerWidget | `/ticketTimer` | Car retrieval countdown |
| TicketCompletedPageWidget | `/ticketCompletedPage` | "Thank You!" completion page |
| ProfileWidget | NavBar tab | User profile & settings |
| FavoritesSitesWidget | `/favoritesSites` | Saved favorite locations |
| ChangeLanguageWidget | `/changeLanguage` | Language selection (EN/ES/FR) |
| HistoryWidget | `/history` | Past ticket history |
| ListconfigWidget | `/listconfig` | Sort/filter options |
| AddCreditCardWidget | `/addCreditCard` | Payment methods |
| PayWidget | `/pay` | Payment confirmation |

---

## Flow 1: App Launch & Auto-Login

```
App Start (/)
  |
  v
[DEMO MODE] Skip Firebase, Stripe, Notifications, Crashlytics
  |
  v
DemoAuthUser auto-logged in
  uid: demo_uid_001
  email: demo@knex-app.xyz
  name: Alex Sunshine
  phone: (305) 555-0123
  |
  v
Splash screen (1 second)
  |
  v
NavBarPage -> HomePage
```

**What's bypassed in demo:**
- `initFirebase()` - skipped
- `initializeStripe()` - skipped
- `NotificationService.initialize()` - skipped
- `FirebaseCrashlytics` - skipped
- `jwtTokenStream` - returns `Stream.value('demo_jwt_token')`
- `knexFirebaseUserStream()` - emits `DemoAuthUser` immediately

---

## Flow 2: HomePage Load (5-Step Process)

```
HomePageWidget loads
  |
  v
Step 1/5: Lock Orientation (portrait)
  |
  v
Step 2/5: Fetch & Validate Profile via FlowManager
  |-- MockApiClient.searchUserClient({email: demo@knex-app.xyz})
  |-- Returns: Alex Sunshine profile
  |-- Schema validation (hardcoded): firstName, lastName, phoneNumber, email
  |-- Profile complete? YES -> continue
  |                      NO  -> REDIRECT to ProfileCreateWidget
  v
Step 3/5: Fetch PIN (via sendjsontourl)
  |-- Demo guard returns: {"data": {"PIN": "8842"}}
  |-- 401 error? -> REDIRECT to LoginSignUpWidget
  v
Step 4/5: Fetch Sites via ApiClient
  |-- MockApiClient.getLocations()
  |-- Returns 3 locations:
  |     1. Truluck's Fort Lauderdale ($15)
  |     2. The Breakers Palm Beach ($20)
  |     3. Brickell City Centre ($12)
  |-- Sort by device distance (times out on simulator -> unsorted)
  v
Step 5/5: Check for Active Tickets
  |-- MockApiClient.getLatestTicket()
  |-- Active ticket? YES -> REDIRECT to TicketWidget
  |                  NO  -> Continue to show HomePage
  v
HomePage rendered with 3 location cards in carousel
```

---

## Flow 3: Browse Location Details

```
HomePage
  |
  | (tap location card)
  v
SiteDetailsWidget (/siteDetails?id=loc_001)
  |
  |-- Displays:
  |     - Location name & address
  |     - Bio/description
  |     - Photo carousel
  |     - Company name (KNEX Valet)
  |     - Valet price (e.g. $15.00)
  |     - Notes ("Valet stand is at the main entrance...")
  |
  |-- Actions:
  |     - Back button -> HomePage
  |     - "Request Valet" button -> AddCarsWidget
  v
```

**Mock Locations:**

| ID | Name | Address | Price |
|----|------|---------|-------|
| loc_001 | Truluck's Fort Lauderdale | 2584 E Sunrise Blvd, FL 33304 | $15 |
| loc_002 | The Breakers Palm Beach | 1 S County Rd, FL 33480 | $20 |
| loc_003 | Brickell City Centre | 701 S Miami Ave, FL 33131 | $12 |

---

## Flow 4: Add Vehicle & Create Ticket

```
SiteDetailsWidget
  |
  | ("Request Valet")
  v
AddCarsWidget (/addCars?id=loc_001)
  |
  |-- Form fields:
  |     - Vehicle Make (text input)
  |     - Vehicle Model (text input)
  |     - Vehicle Year (text input)
  |     - License Plate (required)
  |     - Color (dropdown)
  |     - VIN (optional)
  |
  |-- Validation:
  |     - License plate required
  |
  | ("Save Info")
  v
MockApiClient.createVehicle(data)
  |-- Returns: {id: demo_vehicle_1}
  |-- Status check: result == 'CREATED' || status == 'VALID'
  v
[DEMO MODE] Auto-create ticket:
  MockApiClient.createTicket(...)
  |-- Creates _DemoTicket with:
  |     - id: demo_ticket_1
  |     - ticketNumber: TK-1001
  |     - status: Parked
  |     - pin: 8001
  |     - site: {name, address, ...} (resolved from location)
  |     - created_at: now
  |     - lockerSpace: L-12
  |     - parkingSpace: P-7
  |-- Sets _lastTicketCreatedAt = now
  v
NAVIGATE -> TicketWidget (/ticket)
```

---

## Flow 5: Ticket Status Lifecycle (Core Demo Flow)

This is the main demo experience. The ticket auto-advances through statuses based on elapsed time.

### Timeline

```
+0s    Ticket created -> status: "Parked"
       (no status message shown)
       |
+15s   Auto-advance -> status: "Processing-Arrival"
       Message: "Wait your valet is coming"
       |
+30s   _model.accepted = true
       Message: "Enjoy your KNEX experience"
       Button: "Request Pick Up" appears
       |
       | (user taps "Request Pick Up")
       v
+0s    setToDeparture() called -> status: "Departure"
       Message: "Wait your attendant is picking up your vehicle"
       Sets _departureRequestedAt = now
       |
+10s   Auto-advance -> status: "Processing-Departure"
       REDIRECT -> TicketTimerWidget (countdown timer)
       |
+25s   Auto-advance -> status: "Completed"
       REDIRECT -> TicketCompletedPageWidget ("Thank You!")
       |
       | (user taps "Return to Dashboard")
       v
       HomePage (fresh start, no active ticket)
```

### Ticket Status Messages in TicketWidget

| Status | Condition | Message Shown |
|--------|-----------|---------------|
| `Parked` | - | (no message) |
| `Arrival` | - | "Valet has been notified" |
| `Processing-Arrival` | `accepted == false` | "Wait your valet is coming" |
| `Processing-Arrival` | `accepted == true` | "Enjoy your KNEX experience" |
| `Departure` | - | "Wait your attendant is picking up your vehicle" |
| `Processing-Departure` | - | Redirects to TicketTimerWidget |
| `Completed` | - | SuccessTicketWidget dialog / TicketCompletedPage |
| `Cancelled` | - | Redirects to HomePage |

### Ticket Data Fields (used by TicketWidget via getkeyfromjsonstring)

| Field | Demo Value | Read By |
|-------|------------|---------|
| `id` | `demo_ticket_1` | Ticket actions |
| `ticket_number` | `TK-1001` | Display |
| `status` | Auto-advancing | Status messages |
| `pin` | `8001` | Barcode display |
| `created_at` | ISO timestamp | Date/time display |
| `site.name` | Location name | Header |
| `site.address` | Location address | Subtitle |
| `lockerSpace` | `L-12` | Request Pick Up guard |
| `parkingSpace` | `P-7` | Request Pick Up guard |
| `notes` | From location | Display |

---

## Flow 6: TicketTimerWidget (Car Retrieval Countdown)

```
TicketWidget (status = Processing-Departure)
  |
  | (auto-redirect from polling)
  v
TicketTimerWidget (/ticketTimer)
  |
  |-- Displays:
  |     - Countdown timer (StopWatchTimer)
  |     - "Your car is being retrieved"
  |     - Vehicle details
  |     - Location info
  |
  |-- Polls every 9.5 seconds:
  |     MockApiClient.getLatestTicket()
  |
  |-- Status check:
  |     status != 'Processing-Departure'?
  |       |
  |       YES + status == 'Completed' + Demo mode:
  |       |   -> REDIRECT to TicketCompletedPageWidget
  |       |
  |       YES + other:
  |       |   -> REDIRECT to TicketWidget
  |       |
  |       NO: continue countdown
  v
```

---

## Flow 7: Thank You / Completion Page

```
TicketTimerWidget (status = Completed)
  |
  v
TicketCompletedPageWidget (/ticketCompletedPage)
  |
  |-- Displays:
  |     - Gradient header (blue)
  |     - Checkmark icon
  |     - "Thank You!"
  |     - "Your valet has been successfully completed"
  |     - Valet Details card:
  |       - Ticket number
  |       - Date submitted / Date completed
  |       - Category / Priority
  |     - "Return to Dashboard" button
  |
  | ("Return to Dashboard")
  v
NAVIGATE -> HomePageWidget (goNamed, replaces stack)
```

---

## Flow 8: Profile Management

```
NavBarPage (Profile tab)
  |
  v
ProfileWidget (/profile)
  |
  |-- Displays:
  |     - User avatar & name
  |     - Email & phone
  |
  |-- Actions:
  |     - "Edit Profile" -> ProfileCreateWidget
  |     - "My Favorite Sites" -> FavoritesSitesWidget
  |     - "Change Language" -> ChangeLanguageWidget
  |     - "History" -> HistoryWidget
  |     - "Sign Out" -> LoginSignUpWidget (no-op in demo, redirects)
  v
```

### Edit Profile
```
ProfileWidget -> ProfileCreateWidget (/profileCreate)
  |
  |-- Pre-filled with demo data:
  |     - First Name: Alex
  |     - Last Name: Sunshine
  |     - Phone: (305) 555-0123
  |     - Email: demo@knex-app.xyz
  |
  |-- On save: MockApiClient.updateUserClient(data)
  |-- On success: REDIRECT to HomePage
  v
```

### Favorites
```
ProfileWidget -> FavoritesSitesWidget (/favoritesSites)
  |
  |-- Shows locations saved in FFAppState.myFavs
  |-- Toggle favorites (heart icon)
  |-- Tap site -> SiteDetailsWidget
  v
```

### Language
```
ProfileWidget -> ChangeLanguageWidget (/changeLanguage)
  |
  |-- Options: English / Spanish / French
  |-- Stores selection in FFLocalizations
  |-- All UI text updates immediately
  v
```

### History
```
ProfileWidget -> HistoryWidget (/history)
  |
  |-- MockApiClient.getTicketList()
  |-- Shows completed/cancelled tickets
  |-- Tabs: Completed / In Progress / Cancelled
  v
```

---

## Flow 9: Cancel Ticket

```
TicketWidget
  |
  | ("Cancel" button)
  v
MockApiClient.setToCancelForClient(ticketId)
  |-- Status -> "Cancelled"
  |-- Polling detects null active ticket
  v
REDIRECT -> HomePageWidget
```

---

## Flow 10: Error Redirects

| Error | From | Redirects To |
|-------|------|-------------|
| 401 Unauthorized | Any page | LoginSignUpWidget |
| No active ticket | TicketWidget initial load | HomePageWidget |
| Profile incomplete | HomePage Step 2 | ProfileCreateWidget |
| Active ticket exists | HomePage Step 5 | TicketWidget |
| Network timeout | HomePage | Shows ErrorStateWidget |

---

## Mock API Method Summary

| Method | Returns | Used By |
|--------|---------|---------|
| `searchUserClient({email})` | Demo profile | FlowManager, HomePage |
| `createUserClient(data)` | Success | ProfileCreate |
| `updateUserClient(data)` | Success | ProfileCreate |
| `getUserClient(id)` | Demo profile | Profile views |
| `listUserClients()` | [Demo profile] | Admin views |
| `deleteUserClient(id)` | Success | Profile deletion |
| `createVehicle(data)` | `{id: demo_vehicle_N}` | AddCars |
| `listVehicles()` | In-memory vehicles | AddCars (saved cars) |
| `getVehicle(id)` | Vehicle by ID | Ticket details |
| `updateVehicle(data)` | Success | Vehicle edit |
| `deleteVehicle(id)` | Success | Vehicle removal |
| `createTicket(data)` | `{id, pin}` + starts timer | AddCars (demo) |
| `getLatestTicket()` | Auto-advancing ticket | TicketWidget polling |
| `getTicketList()` | All tickets (auto-advancing) | TicketTimer polling, History |
| `getTicketByPIN(pin)` | Ticket by PIN | PIN lookup |
| `setToDeparture(id)` | `{status: UPDATED}` + starts departure timer | Request Pick Up |
| `setToCancelForClient(id)` | Success, status -> Cancelled | Cancel button |
| `setTicketTip(id, tip)` | Success | Tip submission |
| `setTicketStatus(id, status)` | Success | Manual status change |
| `getLocations()` | 3 Florida locations | HomePage |
| `createProvisionalTicket(data)` | Provisional ticket | Casual flow |
| `linkUserClientToTicketByProvisionalPIN(pin)` | Success | PIN linking |
| `setToDepartureCasual(pin)` | Success | Casual departure |

---

## Custom Action Guards (Demo Mode)

These custom actions have `if (DemoConfig.isDemo)` guards at the top:

| Action | File | Demo Behavior |
|--------|------|---------------|
| `sendjsontourl` | `lib/custom_code/actions/sendjsontourl.dart` | Parses URL, returns mock JSON |
| `sendprofile` | `lib/custom_code/actions/sendprofile.dart` | Returns success with submitted data |
| `get_user` | `lib/custom_code/actions/get_user.dart` | Returns demo profile JSON |
| `create_ticket` | `lib/custom_code/actions/create_ticket.dart` | Returns success with PIN 8842 |

---

## Auto-Advance Status Engine (MockApiClient)

The mock uses two timestamp trackers:
- `_lastTicketCreatedAt` - set when `createTicket()` is called
- `_departureRequestedAt` - set when `setToDeparture()` is called

### Arrival Phase (from creation)
```
elapsed >= 15s AND status == 'Parked'
  -> advance to 'Processing-Arrival'
```

### Departure Phase (from setToDeparture)
Sequential one-step-at-a-time advancement:
```
status == 'Departure' AND elapsed >= 10s
  -> advance to 'Processing-Departure'

status == 'Processing-Departure' AND elapsed >= 25s
  -> advance to 'Completed'

status not in [Departure, Processing-Departure, Completed]
  -> advance to 'Departure' first (catch-up)
```

### Reset
When a new ticket is created, `_departureRequestedAt` is reset to `null`.

---

## Quick Test Script

1. Launch app -> Splash -> **HomePage** (3 locations)
2. Tap "Truluck's Fort Lauderdale" -> **SiteDetails**
3. Tap "Request Valet" -> **AddCars**
4. Fill in: Make=Toyota, Model=Camry, Plate=ABC123, Color=Blue
5. Tap "Save Info" -> **TicketWidget** (status: Parked)
6. Wait 15s -> Message: "Wait your valet is coming"
7. Wait 30s -> Message: "Enjoy your KNEX experience" + "Request Pick Up" button
8. Tap "Request Pick Up" -> Message: "Wait your attendant is picking up..."
9. Wait ~10s -> **TicketTimerWidget** (countdown)
10. Wait ~15s more -> **TicketCompletedPage** ("Thank You!")
11. Tap "Return to Dashboard" -> **HomePage**
12. Go to Profile tab -> See Alex Sunshine info
13. Tap "Edit Profile" -> **ProfileCreate** (pre-filled)
14. Back -> Tap "My Favorite Sites" -> **FavoritesSites**
15. Back -> Tap "Change Language" -> Switch to Spanish -> All UI updates
