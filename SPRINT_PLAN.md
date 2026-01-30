# Habitly Flutter UI Kit - Detailed Sprint Plan & Project Structure

---

## Executive Summary

This document outlines the development strategy for **Habitly**, a minimalist habit-tracking Flutter application. The project is **frontend-only** with mock data and local state management. Development is structured into **4 sprints** over 4-5 weeks, following a **Feature-Based Architecture** with a modular, scalable design system.

---

## Part 1: Detailed Sprint Breakdown

### **Sprint 1: Foundation & Design System (1 Week)**
**Goal:** Establish the visual foundation, theme system, and reusable UI components.

#### 1.1 Design System Setup
- [ ] Configure **Google Fonts** (Poppins, Inter) in `pubspec.yaml` and theme
- [ ] Define **Color Palette** as constants
  - Primary: `#5C6BC0` (Indigo/Purple)
  - Secondary: `#2ECC71` (Emerald Green)
  - Background: `#FFFFFF` (White), `#F5F7FA` (Light Grey)
  - Text: `#2D3436` (Dark Slate), `#636E72` (Medium Grey)
  - Pastel Accents: Light Purple, Light Green, Light Orange, Light Blue
- [ ] Create `AppTheme` and `ThemeProvider` using Material 3 design
- [ ] Define **Typography** scale (Headline, Title, Body, Label, etc.)

#### 1.2 Reusable Components Library
- [ ] **HabitlyCard**: Custom Card widget with soft shadows and rounded corners (20px)
- [ ] **PrimaryButton**: Full-width button with `BorderRadius.circular(30)` (Primary color)
- [ ] **SecondaryButton**: Outlined button variant
- [ ] **HabitCard**: Habit list item with icon, name, frequency, streak
- [ ] **ProgressRing**: Circular progress indicator (70% example)
- [ ] **IconSelector**: Grid of icon options with pastel backgrounds
- [ ] **TabBar**: Custom tab navigation (All/Daily/Weekly, etc.)
- [ ] **BottomNavBar**: Custom 4-tab navigation (Home, Habits, Calendar, Profile)
- [ ] **HeatmapCell**: Small weekly indicator cell (M T W T F S S)

#### 1.3 Project Configuration
- [ ] Set up `pubspec.yaml` with all required dependencies
- [ ] Configure asset paths (fonts, icons)
- [ ] Create `constants.dart` for app-wide values
- [ ] Set up routes/navigation structure

**Deliverables:**
- Fully configured theme system
- Component library documentation
- Color & typography constants

---

### **Sprint 2: Authentication & Onboarding (1 Week)**
**Goal:** Implement entry point screens and user authentication flows.

#### 2.1 Onboarding Flow
- [ ] **OnboardingScreen 1**: "Track habits daily" illustration + description + Next/Skip buttons
- [ ] **OnboardingScreen 2-3**: (Optional) Additional onboarding slides
- [ ] **PageIndicator**: Visual progress indicator (dots)
- [ ] **OnboardingController**: Page navigation logic with Provider

#### 2.2 Authentication Pages
- [ ] **EntryPage**: Logo, slogan, "Get Started" (green button), login link
- [ ] **SignUpPage**: Email, password, name inputs + validation + Sign Up button
- [ ] **LoginPage**: Email, password inputs + validation + Login button
- [ ] **ForgotPasswordPage**: Email input + reset logic

#### 2.3 Navigation Setup
- [ ] Implement `GoRouter` or `Navigator` routing strategy
- [ ] Define auth state management (authenticated vs. unauthenticated flows)
- [ ] Create splash screen for app initialization

**Deliverables:**
- Complete onboarding & auth flows
- Navigation routing configured
- Mock authentication logic

---

### **Sprint 3: Core Habit Features (1.5 Weeks)**
**Goal:** Implement the main user-facing habit management features.

#### 3.1 Home Screen
- [ ] **TodayProgressCard**: Gradient card with "60% complete" (3/5), progress bar
- [ ] **HabitsListSection**: List of habits with checkboxes + Done/Pending status
- [ ] **AddHabitFAB**: Floating action button for adding new habits
- [ ] **BottomNavigationBar**: Navigation to Habits, Calendar, Profile tabs

#### 3.2 All Habits Screen
- [ ] **HabitTabBar**: Filter tabs (All, Daily, Weekly)
- [ ] **HabitListView**: Filterable list of all habits
  - Icon + Name
  - Frequency badge
  - Current streak
  - Completion status
- [ ] **Pull-to-refresh** or **pagination** mock
- [ ] **Add Habit Button**: Leading to Add Habit flow

#### 3.3 Add/Edit Habit Screen
- [ ] **HabitNameField**: Text input with placeholder
- [ ] **IconGridSelector**: 12-16 icon options in grid layout
  - Display selected icon in preview
  - Pastel background colors
- [ ] **FrequencySelector**: Daily/Weekly toggle buttons
- [ ] **GoalTypeSelector**: Yes/No vs. Count toggle
- [ ] **ReminderToggle**: Optional reminder time picker
  - Time selection UI (HH:MM picker)
- [ ] **SaveButton**: Form validation + save action
- [ ] **Mock Local Storage**: Save to a list (Provider state)

**Deliverables:**
- Fully functional Home & All Habits screens
- Add/Edit Habit form with validation
- Tab filtering working
- Mock data structure

---

### **Sprint 4: Analytics, Details & Profile (1.5 Weeks)**
**Goal:** Complete remaining screens with data visualization and user profile features.

#### 4.1 Habit Details Screen
- [ ] **HabitHeader**: Habit name, icon, description (Exercise for 30 minutes)
- [ ] **ProgressRing**: Large circular progress (70% with animation)
  - Use `fl_chart` or custom canvas
  - Animate on entry
- [ ] **StreakCard**: "7-day streak" with fire icon
- [ ] **WeeklyHeatmap**: M T W T F S S with green/red/yellow dots
- [ ] **EditHabitButton**: Navigate to Edit Habit screen
- [ ] **Back Navigation**: Return to Habits list

#### 4.2 Calendar Screen
- [ ] **MonthView**: Full month calendar grid
  - Swipe left/right for previous/next month
  - Header with month/year + navigation arrows
- [ ] **HabitDots**: Dots on calendar dates indicating status
  - Green: Complete
  - Yellow: Partial
  - Red: Missed
  - Grey: No Data
- [ ] **DayDetailsSection**: Show completed habits for selected date
- [ ] **HabitStatusBadges**: Green checkmark badges for completed habits

#### 4.3 Profile Screen
- [ ] **ProfileHeader**: Avatar, name, username, quote section
- [ ] **StatisticsGrid**: 4 cards showing:
  - Day Streak (127)
  - Completed (842)
  - Best Streak (24)
  - Completion Rate (89%)
- [ ] **StatIcon**: Icon + large number + label layout

#### 4.4 Settings Screen
- [ ] **NotificationToggle**: Notifications on/off with description
- [ ] **ThemeSelector**: Light/Dark mode toggle (extensible)
- [ ] **AboutSection**: App version, info link
- [ ] **LogOutButton**: Large red button with logout icon

#### 4.5 Polish & Integration
- [ ] Page transitions & animations
- [ ] Error handling & edge cases
- [ ] Responsive layout testing (phone layouts)
- [ ] Performance optimization

**Deliverables:**
- All 10 screens fully implemented
- Data visualization (charts, heatmaps, progress rings)
- Full app navigation working
- Professional animations & transitions

---

## Part 2: Folder Structure (Feature-Based Architecture)

```
habitly/
├── lib/
│   ├── config/
│   │   ├── theme/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_theme.dart
│   │   │   ├── typography.dart
│   │   │   └── theme_provider.dart
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   └── duration_constants.dart
│   │   ├── routes/
│   │   │   └── app_routes.dart
│   │   └── env/
│   │       └── env_config.dart
│   │
│   ├── features/
│   │   ├── onboarding/
│   │   │   ├── screens/
│   │   │   │   └── onboarding_screen.dart
│   │   │   ├── widgets/
│   │   │   │   └── onboarding_slide.dart
│   │   │   ├── controller/
│   │   │   │   └── onboarding_controller.dart
│   │   │   └── provider/
│   │   │       └── onboarding_provider.dart
│   │   │
│   │   ├── auth/
│   │   │   ├── screens/
│   │   │   │   ├── entry_page.dart
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── signup_screen.dart
│   │   │   │   └── forgot_password_screen.dart
│   │   │   ├── widgets/
│   │   │   │   └── auth_text_field.dart
│   │   │   ├── provider/
│   │   │   │   └── auth_provider.dart
│   │   │   └── models/
│   │   │       └── user_model.dart
│   │   │
│   │   ├── home/
│   │   │   ├── screens/
│   │   │   │   └── home_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── today_progress_card.dart
│   │   │   │   └── habits_list_section.dart
│   │   │   └── provider/
│   │   │       └── home_provider.dart
│   │   │
│   │   ├── habits/
│   │   │   ├── screens/
│   │   │   │   └── all_habits_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── habit_card.dart
│   │   │   │   ├── habit_tab_bar.dart
│   │   │   │   └── habit_list_view.dart
│   │   │   ├── provider/
│   │   │   │   └── habits_provider.dart
│   │   │   └── models/
│   │   │       └── habit_model.dart
│   │   │
│   │   ├── add_habit/
│   │   │   ├── screens/
│   │   │   │   └── add_edit_habit_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── habit_name_field.dart
│   │   │   │   ├── icon_grid_selector.dart
│   │   │   │   ├── frequency_selector.dart
│   │   │   │   ├── goal_type_selector.dart
│   │   │   │   └── reminder_picker.dart
│   │   │   ├── provider/
│   │   │   │   └── add_habit_provider.dart
│   │   │   └── validators/
│   │   │       └── habit_validators.dart
│   │   │
│   │   ├── habit_details/
│   │   │   ├── screens/
│   │   │   │   └── habit_details_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── progress_ring.dart
│   │   │   │   ├── streak_card.dart
│   │   │   │   └── weekly_heatmap.dart
│   │   │   └── provider/
│   │   │       └── habit_details_provider.dart
│   │   │
│   │   ├── calendar/
│   │   │   ├── screens/
│   │   │   │   └── calendar_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── month_calendar.dart
│   │   │   │   ├── calendar_day_cell.dart
│   │   │   │   └── habit_status_badge.dart
│   │   │   ├── provider/
│   │   │   │   └── calendar_provider.dart
│   │   │   └── models/
│   │   │       └── calendar_model.dart
│   │   │
│   │   ├── profile/
│   │   │   ├── screens/
│   │   │   │   └── profile_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── profile_header.dart
│   │   │   │   └── statistics_grid.dart
│   │   │   └── provider/
│   │   │       └── profile_provider.dart
│   │   │
│   │   └── settings/
│   │       ├── screens/
│   │       │   └── settings_screen.dart
│   │       ├── widgets/
│   │       │   ├── settings_tile.dart
│   │       │   └── toggle_setting.dart
│   │       └── provider/
│   │           └── settings_provider.dart
│   │
│   ├── shared/
│   │   ├── widgets/
│   │   │   ├── habitly_card.dart
│   │   │   ├── primary_button.dart
│   │   │   ├── secondary_button.dart
│   │   │   ├── custom_app_bar.dart
│   │   │   ├── bottom_nav_bar.dart
│   │   │   ├── loading_indicator.dart
│   │   │   └── error_widget.dart
│   │   │
│   │   ├── models/
│   │   │   ├── base_model.dart
│   │   │   └── response_model.dart
│   │   │
│   │   ├── utils/
│   │   │   ├── date_utils.dart
│   │   │   ├── string_extensions.dart
│   │   │   ├── validators.dart
│   │   │   └── logger.dart
│   │   │
│   │   ├── providers/
│   │   │   └── app_state_provider.dart
│   │   │
│   │   └── services/
│   │       ├── local_storage_service.dart
│   │       └── mock_data_service.dart
│   │
│   ├── app/
│   │   ├── app.dart
│   │   └── app_binding.dart
│   │
│   └── main.dart
│
├── assets/
│   ├── icons/
│   │   └── (SVG or PNG icons for habits)
│   ├── images/
│   │   ├── logo.png
│   │   ├── onboarding_1.png
│   │   ├── onboarding_2.png
│   │   └── avatar_placeholder.png
│   └── fonts/
│       ├── Poppins-Bold.ttf
│       ├── Poppins-SemiBold.ttf
│       ├── Poppins-Medium.ttf
│       ├── Poppins-Regular.ttf
│       ├── Inter-Bold.ttf
│       └── Inter-Regular.ttf
│
├── test/
│   ├── unit/
│   │   └── validators_test.dart
│   ├── widget/
│   │   └── primary_button_test.dart
│   └── integration/
│       └── app_flow_test.dart
│
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
└── README.md
```

### **Folder Structure Explanation:**

| Folder | Purpose |
|--------|---------|
| `config/` | Theme, colors, typography, routes, constants |
| `features/` | Feature modules (auth, home, habits, etc.) |
| `shared/` | Reusable widgets, models, utilities, services |
| `assets/` | Images, icons, fonts |
| `test/` | Unit, widget, and integration tests |

---

## Part 3: Required Dependencies for `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Design & UI
  google_fonts: ^6.1.0                    # Google Fonts (Poppins, Inter)
  flutter_phosphor_icons: ^1.2.0          # Icon library (minimalist style)
  # OR
  # fluentui_system_icons: ^1.1.0         # Alternative icon library

  # State Management
  provider: ^6.1.0                        # State management with ChangeNotifier
  # OR
  # riverpod: ^2.4.0                      # Alternative: more powerful

  # Charts & Progress
  fl_chart: ^0.65.0                       # For progress rings, charts
  percent_indicator: ^4.1.1               # Circular progress indicators (alternative)

  # Navigation & Routing
  go_router: ^13.2.0                      # Modern routing solution
  # OR
  # auto_route: ^7.8.0                    # Alternative: auto-generated routes

  # Utilities & Helpers
  intl: ^0.19.0                           # Date/time formatting
  uuid: ^4.0.0                            # Generate unique IDs for habits
  
  # JSON Serialization (for mock data)
  json_annotation: ^4.8.0                 # JSON serialization helpers
  json_serializable: ^6.7.0                # Code generation for JSON

  # Storage (mock local storage)
  shared_preferences: ^2.2.0              # Local key-value storage

  # Additional UI Polish
  smooth_page_indicator: ^1.1.0           # Animated page indicators (onboarding)
  flutter_animate: ^4.1.1                 # Animation utilities
  # OR
  # rive: ^0.11.0                         # Complex animations

  # Logging & Debugging
  logger: ^2.0.0                          # Better logging

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.0                   # Linting rules
  
  # Testing
  mockito: ^5.4.0                         # Mocking library
  bloc_test: ^9.1.0                       # Testing provider/bloc

  # Code Generation
  build_runner: ^2.4.0                    # Code generation runner
  json_serializable: ^6.7.0               # JSON code generation
```

### **Dependency Notes:**

| Dependency | Reason |
|-----------|--------|
| `google_fonts` | Load Poppins/Inter fonts from Google Fonts API or assets |
| `flutter_phosphor_icons` | Minimalist icon style matching design vibe |
| `provider` | Lightweight state management for UI interactions |
| `fl_chart` | Circular progress rings and chart visualizations |
| `go_router` | Modern, declarative routing for screen navigation |
| `intl` | Format dates for calendar and habit frequency |
| `shared_preferences` | Persist mock habit data locally |
| `smooth_page_indicator` | Animated dots for onboarding slides |
| `logger` | Better console logging for debugging |

---

## Part 4: Implementation Timeline

| Sprint | Duration | Milestones |
|--------|----------|-----------|
| **Sprint 1** | Week 1 (Mon-Fri) | Design system, theme, components library ready |
| **Sprint 2** | Week 2 (Mon-Fri) | Auth & onboarding screens complete |
| **Sprint 3** | Week 3-4 (Mon-Thu) | Home, Habits, Add/Edit features working |
| **Sprint 4** | Week 4-5 (Fri-Wed) | Details, Calendar, Profile, Settings polished |
| **Buffer** | Remaining | Testing, bug fixes, animations, deployment prep |

---

## Part 5: Key Design System References

### **Color Tokens (Dart Constants)**
```
- Primary: Color(0xFF5C6BC0)        // Indigo/Purple
- Secondary: Color(0xFF2ECC71)      // Emerald Green
- TextDark: Color(0xFF2D3436)       // Dark Slate
- TextMedium: Color(0xFF636E72)     // Medium Grey
- BgWhite: Color(0xFFFFFFFF)        // White
- BgLight: Color(0xFFF5F7FA)        // Light Grey
- AccentPurple: Color(0xFFE8E5F5)   // Light Purple (Pastel)
- AccentGreen: Color(0xFFD5F4E6)    // Light Green (Pastel)
- AccentOrange: Color(0xFFFDEADB)   // Light Orange (Pastel)
- Success: Color(0xFF2ECC71)        // Green (Complete)
- Warning: Color(0xFFF39C12)        // Orange (Partial)
- Error: Color(0xFFE74C3C)          // Red (Missed)
```

### **Component Specifications**
- **Card Radius:** `BorderRadius.circular(20)`
- **Button Radius:** `BorderRadius.circular(30)`
- **Shadow:** `BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)`
- **Spacing:** Use 8px, 16px, 24px, 32px grid
- **Typography Scale:** H1 (32px), H2 (24px), H3 (18px), Body (16px), Small (14px)

---

## Part 6: Success Criteria

By the end of all 4 sprints:

✅ All 10 screens fully implemented with pixel-perfect design  
✅ Smooth navigation and transitions between screens  
✅ Interactive elements (buttons, toggles, forms) fully functional  
✅ Mock data system for habits with add/edit functionality  
✅ Calendar with habit status visualization  
✅ Progress rings and data visualizations working  
✅ Responsive design tested on multiple phone sizes  
✅ Clean, documented, production-ready code  
✅ Ready for backend integration in future phases  

---

## Next Steps

Once approved, proceed with:
1. **Create project structure** (folders, files)
2. **Set up pubspec.yaml** with dependencies
3. **Implement Sprint 1** (design system & components)
4. **Daily standups** to track progress

---

*Document Version: 1.0*  
*Last Updated: January 30, 2026*  
*Status: Ready for Sprint Planning*
