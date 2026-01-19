# KNEX Valet Client API Usage Guide

This document provides a detailed guide on how to use the KNEX Valet Client API. Each endpoint is described with a scenario, request and response formats, and practical examples.

## Authentication

All API requests must be authenticated using a **Bearer Token** (Firebase ID Token) or an **API Key**.

- **Bearer Token**: Include the Firebase ID token in the `Authorization` header as a Bearer token.
- **API Key**: Include your API key in the `X-API-Key` header.

The request body for all POST requests is a JSON object with two main properties:
- `idToken`: Your Firebase ID token (for token authentication).
- `data`: A JSON object containing the endpoint-specific payload.

---

## Endpoints

### Client Profile Management

#### `POST /createUserClient`

- **Description**: Creates a new client profile.
- **Scenario**: A new user signs up and needs to create their profile.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
  - `data` (object): Client profile details.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token",
    "data": {
      "email": "new.client@example.com",
      "firstName": "New",
      "lastName": "Client",
      "phoneNumber": "+15551234567"
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "status": {
        "status": "CREATED",
        "result": "Doc user_client_... created.",
        "message": "User profile created successfully."
    },
    "data": {
        "id": "a_new_client_id",
        "email": "new.client@example.com"
    }
  }
  ```

#### `POST /getUserClient`

- **Description**: Retrieves the profile of the currently authenticated client.
- **Scenario**: A client views their profile information in the app.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
  - `data` (object): An object containing the client's `id`.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token",
    "data": {
      "id": "1D54B7D3-E7CA-4195-98F8-E9206FDE167A"
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "id": "1D54B7D3-E7CA-4195-98F8-E9206FDE167A",
    "email": "client4@example.com",
    "firstName": "Patricia",
    "lastName": "Williams",
    "phoneNumber": "+15551001004"
  }
  ```

#### `POST /updateUserClient`

- **Description**: Updates an existing client's profile.
- **Scenario**: A client updates their phone number.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
  - `data` (object): Client details to update, including the client's `id`.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token",
    "data": {
      "id": "1D54B7D3-E7CA-4195-98F8-E9206FDE167A",
      "phoneNumber": "+15557654321"
    }
  }
  ```
- **Example Response**:
  ```json
   {
    "status": {
        "status": "UPDATED",
        "result": "Doc user_client_... updated.",
        "message": "User profile updated successfully."
    },
    "data": {
        "id": "1D54B7D3-E7CA-4195-98F8-E9206FDE167A"
    }
  }
  ```

### Vehicle Management

#### `POST /createVehicle`

- **Description**: Adds a new vehicle to a client's profile.
- **Scenario**: A client adds their new car to their profile.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
  - `data` (object): Vehicle details.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token",
    "data": {
      "vehicle_make": "Tesla",
      "vehicle_model": "Model Y",
      "vehicle_year": "2024",
      "license_plate": "NEW-CAR",
      "color": "White"
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "status": {
        "status": "CREATED",
        "result": "Doc vehicle_... created.",
        "message": "Vehicle created successfully."
    },
    "data": {
        "id": "a_new_vehicle_id"
    }
  }
  ```

#### `POST /listVehicles`

- **Description**: Retrieves a list of all vehicles for the authenticated client.
- **Scenario**: A client views their list of registered vehicles.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token"
  }
  ```
- **Example Response**:
  ```json
  [
    {
      "id": "4D8C9E76-2394-4694-BB6D-2A89CDF860D6",
      "user_client_id": "1D54B7D3-E7CA-4195-98F8-E9206FDE167A",
      "vehicle_make": "Honda",
      "vehicle_model": "Model 3",
      "vehicle_year": "2018",
      "license_plate": "J",
      "color": "Blue"
    }
  ]
  ```

---

### Location Management

#### `POST /getLocations`

- **Description**: Retrieves a list of all available valet locations.
- **Scenario**: A client wants to see all locations where they can use the valet service.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token"
  }
  ```
- **Example Response**:
  ```json
  [
    {
      "id": "fpyOo8sHXzMvTvDZyyJR",
      "name": "Downtown Garage",
      "address": "100 City Center"
    },
    {
      "id": "2bzPArq5SQmcMji2AGHU",
      "name": "Airport Lot",
      "address": "500 Aviation Way"
    }
  ]
  ```

### Ticket Management

#### `POST /createTicket`

- **Description**: Creates a new valet ticket for one of the client's vehicles.
- **Scenario**: A client arrives at a valet location and requests service.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
  - `data` (object): Ticket details, including vehicle and location ID.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token",
    "data": {
      "vehicle_id": "4D8C9E76-2394-4694-BB6D-2A89CDF860D6",
      "location_id": "fpyOo8sHXzMvTvDZyyJR"
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "status": {
        "status": "CREATED",
        "result": "Doc ticket_... created.",
        "message": "Ticket created successfully."
    },
    "data": {
        "id": "a_new_ticket_id"
    }
  }
  ```

#### `POST /getTicketList`

- **Description**: Retrieves a list of the client's past and active valet tickets.
- **Scenario**: A client views their ticket history.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token"
  }
  ```
- **Example Response**:
  ```json
  [
    {
      "id": "029CC91C-6ED6-4D75-A65A-F3D8E37E3C25",
      "ticket_number": "131244",
      "status": "PARKED"
    }
  ]
  ```

#### `POST /setToDeparture`

- **Description**: Allows a client to request their vehicle for departure.
- **Scenario**: A client is ready to leave and requests their car from the valet.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
  - `data` (object): An object containing the `ticketId`.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token",
    "data": {
      "ticketId": "029CC91C-6ED6-4D75-A65A-F3D8E37E3C25"
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "status": {
        "status": "UPDATED",
        "result": "Doc ticket_... updated.",
        "message": "Vehicle requested for departure successfully."
    },
    "data": {
        "id": "029CC91C-6ED6-4D75-A65A-F3D8E37E3C25"
    }
  }
  ```

#### `POST /setTicketTip`

- **Description**: Allows a client to add a tip to a completed valet ticket.
- **Scenario**: A client adds a tip for the attendant.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
  - `data` (object): An object containing the `ticketId` and `tip` amount.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token",
    "data": {
      "ticketId": "00058377-44D2-44BA-BC6F-94A9A6B6926D",
      "tip": 5.00
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "status": {
        "status": "UPDATED",
        "result": "Doc ticket_... updated.",
        "message": "Tip added successfully."
    },
    "data": {
        "id": "00058377-44D2-44BA-BC6F-94A9A6B6926D"
    }
  }
  ```

### Provisional and Casual User

#### `POST /createProvisionalTicket`

- **Description**: Creates a temporary ticket for a user without an account.
- **Scenario**: A user who hasn't signed up wants to use the valet service.
- **Request Body**:
  - `data` (object): Provisional ticket details.
- **Example Request**:
  ```json
  {
    "data": {
      "location_id": "fpyOo8sHXzMvTvDZyyJR",
      "vehicle": {
        "vehicle_make": "Ford",
        "vehicle_model": "Mustang",
        "color": "Red"
      }
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "id": "a_provisional_ticket_id",
    "pin": "123456",
    "location_id": "fpyOo8sHXzMvTvDZyyJR",
    "vehicle": {
      "vehicle_make": "Ford",
      "vehicle_model": "Mustang",
      "color": "Red"
    }
  }
  ```

#### `POST /linkUserClientToTicketByProvisionalPIN`

- **Description**: Associates a provisional ticket with a client's account using the PIN.
- **Scenario**: A user who used a provisional ticket decides to sign up and wants to link their ticket to their new account.
- **Request Body**:
  - `idToken` (string): Firebase authentication token.
  - `data` (object): An object containing the `pin`.
- **Example Request**:
  ```json
  {
    "idToken": "your_firebase_id_token",
    "data": {
      "pin": "123456"
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "status": {
        "status": "UPDATED",
        "result": "Doc ticket_... updated.",
        "message": "Ticket linked successfully."
    },
    "data": {
        "id": "the_linked_ticket_id"
    }
  }
  ```

#### `POST /setToDepartureCasual`

- **Description**: Allows a casual user to request their vehicle for departure using their ticket PIN.
- **Scenario**: A user without an account is ready to leave and requests their car.
- **Request Body**:
  - `data` (object): An object containing the `pin`.
- **Example Request**:
  ```json
  {
    "data": {
      "pin": "123456"
    }
  }
  ```
- **Example Response**:
  ```json
  {
    "status": {
        "status": "UPDATED",
        "result": "Doc ticket_... updated.",
        "message": "Vehicle requested for departure successfully."
    },
    "data": {
        "id": "the_ticket_id"
    }
  }
  ```
