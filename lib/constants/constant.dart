class Constants {
  // App Meta
  static const String appName = 'GoTo';
  static const String appTagline = 'Organize Everything';
  static const String appVersion = '1.0.0';

  // Auth Flow
  static const String continueText = 'Continue';
  static const String welcomeBack = 'Welcome to GoTo';
  static const String emailHint = 'email@example.com';
  static const String passwordHint = 'Password';
  static const String confirmPasswordHint = 'Confirm Password';
  static const String login = 'Log In';
  static const String signUp = 'Sign Up';
  static const String forgotPassword = 'Forgot Password?';

  // Onboarding
  static const String onboarding1Title = 'Plan Your Day';
  static const String onboarding1Desc = 'Organize tasks with intuitive drag & drop';
  static const String onboarding2Title = 'Team Collaboration';
  static const String onboarding2Desc = 'Share projects with your team seamlessly';
  static const String onboarding3Title = 'Smart Reminders';
  static const String onboarding3Desc = 'Never miss important deadlines again';

  // Task Management
  static const String today = 'Today';
  static const String upcoming = 'Upcoming';
  static const String projects = 'Projects';
  static const String allTasks = 'All Tasks';
  static const String createTask = 'Create Task';
  static const String taskTitleHint = 'Task title';
  static const String taskDescriptionHint = 'Description (optional)';
  static const String dueDate = 'Due Date';
  static const String priority = 'Priority';
  static const String category = 'Category';

  // Priority Levels
  static const String lowPriority = 'Low';
  static const String mediumPriority = 'Medium';
  static const String highPriority = 'High';

  // Categories
  static const String work = 'Work';
  static const String personal = 'Personal';
  static const String shopping = 'Shopping';
  static const String health = 'Health';

  // Settings
  static const String settings = 'Settings';
  static const String theme = 'Theme';
  static const String notifications = 'Notifications';
  static const String account = 'Account';
  static const String help = 'Help';
  static const String logout = 'Log Out';
}

class SessionKeys {
  static const String authToken = 'auth_token';
  static const String currentUser = 'current_user';
  static const String userPreferences = 'user_prefs';
  static const String tasksData = 'tasks_data';
  static const String projectsData = 'projects_data';
  static const String lastSyncTime = 'last_sync_time';
}
// lib/routes/app_routes.dart
abstract class Routes {
  static const HOME = '/home';
  static const PERSONAL_PLANS = '/personal-plans';
  static const WORK_PLANS = '/work-plans';
  static const ALL_PLANS = '/all-plans';
  // Add other route names here
}