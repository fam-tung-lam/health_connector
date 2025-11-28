import 'package:flutter/material.dart';

/// Centralized collection of all icon data used throughout the application.
///
/// This class provides a single source of truth for all icons, ensuring
/// consistent icon usage across the app.
abstract final class AppIcons {
  // Navigation & Actions
  static const IconData refresh = Icons.refresh;
  static const IconData addCircleOutline = Icons.add_circle_outline;
  static const IconData chevronRight = Icons.chevron_right;
  static const IconData settings = Icons.settings;

  // Health & Data
  static const IconData healthAndSafety = Icons.health_and_safety;
  static const IconData directionsWalk = Icons.directions_walk;
  static const IconData monitorWeight = Icons.monitor_weight;
  static const IconData height = Icons.height;
  static const IconData percent = Icons.percent;
  static const IconData straighten = Icons.straighten;
  static const IconData localFireDepartment = Icons.local_fire_department;
  static const IconData stairs = Icons.stairs;
  static const IconData accessible = Icons.accessible;
  static const IconData readMore = Icons.read_more;
  static const IconData calculate = Icons.calculate;
  static const IconData favorite = Icons.favorite;

  // Permissions & Security
  static const IconData lockOutline = Icons.lock_outline;
  static const IconData checkCircle = Icons.check_circle;
  static const IconData cancel = Icons.cancel;
  static const IconData helpOutline = Icons.help_outline;
  static const IconData infoOutline = Icons.info_outline;

  // Status & Feedback
  static const IconData errorOutline = Icons.error_outline;
  static const IconData inbox = Icons.inbox;
  static const IconData expandMore = Icons.expand_more;

  // Form Fields
  static const IconData calendarToday = Icons.calendar_today;
  static const IconData accessTime = Icons.access_time;
  static const IconData numbers = Icons.numbers;
  static const IconData category = Icons.category;
  static const IconData list = Icons.list;
  static const IconData devices = Icons.devices;

  // Recording Method
  static const IconData edit = Icons.edit;
  static const IconData autoAwesome = Icons.auto_awesome;
  static const IconData fitnessCenter = Icons.fitness_center;

  // Device Types
  static const IconData watch = Icons.watch;
  static const IconData phone = Icons.phone_android;
  static const IconData scale = Icons.scale;
  static const IconData ring = Icons.circle;
  static const IconData fitnessBand = Icons.watch;
  static const IconData chestStrap = Icons.sensors;
  static const IconData headMounted = Icons.view_in_ar;
  static const IconData smartDisplay = Icons.smart_display;

  // Aggregation Metrics
  static const IconData sum = Icons.add_circle;
  static const IconData avg = Icons.trending_up;
  static const IconData min = Icons.trending_down;
  static const IconData max = Icons.trending_up;
  static const IconData count = Icons.numbers;

  // Measurement Units
  static const IconData mass = Icons.scale;
  static const IconData numeric = Icons.numbers;
  static const IconData length = Icons.straighten;
  static const IconData energy = Icons.local_fire_department;
  static const IconData bloodGlucose = Icons.bloodtype;
  static const IconData power = Icons.bolt;
  static const IconData pressure = Icons.compress;
  static const IconData temperature = Icons.thermostat;
  static const IconData velocity = Icons.speed;
  static const IconData volume = Icons.water_drop;

  // Health Platforms
  static const IconData apple = Icons.apple;
  static const IconData android = Icons.android;

  // Example App Home Page - API Actions
  static const IconData removeCircle = Icons.remove_circle;
  static const IconData info = Icons.info;
  static const IconData add = Icons.add;
  static const IconData delete = Icons.delete;
  static const IconData deleteSweep = Icons.delete_sweep;
}
