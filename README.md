# KNEX Client App

A Flutter-based mobile application designed for the KNEX platform, facilitating valet parking services, ticket management, and seamless payments.

## Overview

The KNEX Client App allows users to manage their parking tickets, request vehicle retrieval, and handle payments and tips directly from their mobile devices. It integrates with Firebase for backend services and Stripe for secure payment processing.

## Features

*   **User Authentication**: Secure login and sign-up using Firebase Auth.
*   **Ticket Management**:
    *   Generate new tickets.
    *   View active and past tickets.
    *   Request vehicle departure (retrieval).
    *   Cancel tickets.
*   **Payments & Tipping**:
    *   Secure payment processing via Stripe.
    *   Option to add tips for service.
    *   Manage credit cards.
*   **Vehicle Management**: Add and manage vehicle details.
*   **Profile Management**: Update user profile and settings.
*   **Multi-language Support**: Available in English, Spanish, and French.
*   **Location Services**: Integration for site location and details.

## Tech Stack

*   **Frontend**: Flutter (Dart)
*   **Backend Services**: Firebase (Auth, Cloud Functions, Storage)
*   **Payments**: Stripe
*   **UI/Theming**: FlutterFlow Theme & Components
*   **State Management**: Provider / FFAppState
*   **Routing**: GoRouter

## Getting Started

### Prerequisites

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) (Version >=3.0.0 <4.0.0)
*   CocoaPods (for iOS dependencies)

### Installation

1.  **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd knex-client-new
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Setup Firebase:**
    *   Ensure you have the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files placed in their respective directories (`android/app` and `ios/Runner`).

### Running the App

*   **Run on iOS Simulator/Device:**

    ```bash
    open -a Simulator
    flutter run
    ```

*   **Run on Android Emulator/Device:**

    ```bash
    flutter run
    ```

## Project Structure

The `lib` directory is organized as follows:

*   `auth/`: Authentication logic and Firebase integration.
*   `backend/`: Backend services, API calls, and Stripe management.
*   `components/`: Reusable UI components.
*   `flutter_flow/`: FlutterFlow generated utilities and theme configuration.
*   `home_page/`: Main dashboard and navigation.
*   `ticket/`: Ticket management screens and logic.
*   `pay/`, `add_credit_card/`: Payment related screens.
*   `profile/`, `settings/`: User profile and app settings.
*   `app_constants.dart`: API endpoints and global constants.
*   `main.dart`: Application entry point and routing configuration.

## License

[Add License Information Here]
