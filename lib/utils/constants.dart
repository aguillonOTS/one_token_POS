/// Global configuration constants for the One Token POS.
/// Using constants prevents "magic numbers" and ensures consistency across the app.

// App Identity
const String kAppName = 'One Team POS';
const String kGoApiUrl = "https://api.oneteam-monitoring.com/v1";

// Smart Contract Fee Protocol (One Token Logic)
const double kNgoFeePercent = 0.02;  // 2.0% for Charity
const double kDevFeePercent = 0.002; // 0.2% for Protocol Maintenance

// Supported NGOs for donation routing
const List<String> kNgoList = [
  "WWF",
  "Médecins Sans Frontières (MSF)",
  "Handicap International",
  "Fondation VUE"
];