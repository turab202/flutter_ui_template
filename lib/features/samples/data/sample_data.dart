// ============================================================
// SAMPLE DATA
// 🎨 PROJECT-SPECIFIC — SAMPLE CONTENT
// Static fixture data used by all sample screens.
// No backend, no APIs, no real authentication.
// Replace all values when reusing this template.
// ============================================================

abstract final class SampleData {
  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — User / Profile
  // ----------------------------------------------------------
  static const String userName = 'Alex Johnson';
  static const String userEmail = 'alex.johnson@company.com';
  static const String userTitle = 'Product Designer';
  static const String userLocation = 'Addis Ababa, Ethiopia';
  static const String userPhone = '+251 912 345 678';
  static const String userBio =
      'I design intuitive experiences that make people\'s lives easier and more productive.';
  static const String userInitials = 'AJ';
  static const String userJoinDate = 'January 2024';

  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — Profile stats
  // ----------------------------------------------------------
  static const int profileProjects = 12;
  static const int profileTasksDone = 8;
  static const int profileTeamMembers = 5;

  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — Skills
  // ----------------------------------------------------------
  static const List<String> skills = [
    'UI/UX Design',
    'Product Design',
    'Figma',
    'User Research',
    'Prototyping',
  ];

  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — Dashboard current project
  // ----------------------------------------------------------
  static const String currentProjectLabel = 'Current Project';
  static const String currentProjectName = 'Product Redesign';
  static const double currentProjectProgress = 0.70;
  static const String currentProjectTasks = '3 tasks remaining';
  static const String currentProjectDue = 'Due Apr 28, 2025';

  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — Dashboard stats
  // ----------------------------------------------------------
  static const List<DashboardStat> stats = [
    DashboardStat(label: 'Active Projects', value: '4', delta: '+1 this week', isPositive: true),
    DashboardStat(label: 'Tasks Completed', value: '12', delta: '+20%', isPositive: true),
    DashboardStat(label: 'Team Members', value: '5', delta: '+1 new', isPositive: true),
  ];

  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — Recent activity
  // ----------------------------------------------------------
  static const List<ActivityItem> activities = [
    ActivityItem(
      id: '1',
      actorName: 'Sarah Miller',
      actorInitials: 'SM',
      action: 'commented on',
      target: 'Design System Update',
      timeAgo: '2 hours ago',
    ),
    ActivityItem(
      id: '2',
      actorName: 'Project Proposal.pdf',
      actorInitials: 'PP',
      action: 'was uploaded to',
      target: 'Marketing',
      timeAgo: '4 hours ago',
      isFile: true,
    ),
    ActivityItem(
      id: '3',
      actorName: 'David Kim',
      actorInitials: 'DK',
      action: 'completed task',
      target: 'UI Wireframes',
      timeAgo: '6 hours ago',
    ),
  ];

  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — Upcoming deadlines
  // ----------------------------------------------------------
  static const List<DeadlineItem> deadlines = [
    DeadlineItem(
      title: 'Design Review Meeting',
      date: 'Apr 24, 2025',
      time: '10:00 AM',
    ),
  ];

  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — Quick actions
  // ----------------------------------------------------------
  static const List<QuickAction> quickActions = [
    QuickAction(label: 'New Project', iconCodePoint: 0xe145),  // add
    QuickAction(label: 'Add Task', iconCodePoint: 0xe876),     // check_circle
    QuickAction(label: 'Upload File', iconCodePoint: 0xe2c6),  // upload_file
    QuickAction(label: 'More', iconCodePoint: 0xe5d3),         // more_horiz
  ];
}

// ----------------------------------------------------------
// Data models
// ----------------------------------------------------------

class DashboardStat {
  const DashboardStat({
    required this.label,
    required this.value,
    required this.delta,
    required this.isPositive,
  });
  final String label;
  final String value;
  final String delta;
  final bool isPositive;
}

class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.actorName,
    required this.actorInitials,
    required this.action,
    required this.target,
    required this.timeAgo,
    this.isFile = false,
  });
  final String id;
  final String actorName;
  final String actorInitials;
  final String action;
  final String target;
  final String timeAgo;
  final bool isFile;
}

class DeadlineItem {
  const DeadlineItem({
    required this.title,
    required this.date,
    required this.time,
  });
  final String title;
  final String date;
  final String time;
}

class QuickAction {
  const QuickAction({
    required this.label,
    required this.iconCodePoint,
  });
  final String label;
  final int iconCodePoint;
}
