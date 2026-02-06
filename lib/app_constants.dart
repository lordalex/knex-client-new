abstract class FFAppConstants {
  static const String createUserURL =
      'https://client.knex-app.xyz/api/createUserClient';
  static const String searchUserURL =
      'https://client.knex-app.xyz/api/searchUserClient';
  static const String getPINURL =
      'https://client.knex-app.xyz/api/createTicket'; // Assuming this is for creating a ticket
  static const String searchURL = 'https://client.knex-app.xyz/api/search';
  static const String searchModelURL = 'https://client.knex-app.xyz/api/search';
  static const String createTicketURL =
      'https://client.knex-app.xyz/api/createTicket';
  static const String latesticketURL =
      'https://client.knex-app.xyz/api/getLatestTicket';
  static const String cancelTicketUrl =
      'https://client.knex-app.xyz/api/setToCancelForClient';
  static const String setTicketToDeparture =
      'https://client.knex-app.xyz/api/setToDeparture';
  static const String setTip = 'https://client.knex-app.xyz/api/setTicketTip';
  static const String confirmPaymentURL =
      'https://client.knex-app.xyz/api/confirmPayment'; // Not in openapi_client.json
}
