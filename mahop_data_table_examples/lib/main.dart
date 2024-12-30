import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mahop_data_table_examples/item_views/get_started/min_sample_mio_rows.dart';
import 'package:mahop_data_table_examples/item_views/get_started/sample_drag_drop_1.dart';
import 'package:mahop_data_table_examples/item_views/get_started/sample_invitations.dart';
import 'package:mahop_data_table_examples/item_views/get_started/sample_jump_to.dart';
import 'package:mahop_data_table_examples/item_views/get_started/sample_reorder_rows.dart';
import 'package:go_router/go_router.dart';
import 'package:mahop_data_table_examples/item_views/test-views/scroll_test_view2.dart';
import 'package:window_manager/window_manager.dart';
import 'package:mahop_data_table/mh_drag_utils/mh_drag_drop_provider.dart';

import 'home_page.dart';
import 'item_views/get_started/min_sample_data_table_view.dart';
import 'item_views/get_started/min_sample_edit.dart';
import 'item_views/get_started/min_sample_items_view.dart';
import 'item_views/get_started/sample_filter.dart';
import 'item_views/get_started/sample_save_view_state.dart';
import 'item_views/get_started/sample_selection_modes.dart';
import 'item_views/test-views/scroll_test_view.dart';
import 'item_views/todo_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      await windowManager.ensureInitialized();

      WindowOptions windowOptions = const WindowOptions(
        size: Size(1200, 800),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
        windowButtonVisibility: true,
      );

      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();

  static MainAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MainAppState>()!;
}

class MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.system;

  // GoRouter configuration
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              path: 'todo-view', builder: (context, state) => const ToDoView()),
          GoRoute(
              path: 'sample-invitations-view',
              builder: (context, state) => const SampleInvitations()),
          GoRoute(
              path: 'min-sample-items-view',
              builder: (context, state) => const MinSampleItemsView()),
          GoRoute(
              path: 'min-sample-data-table-view',
              builder: (context, state) => const MinSampleDataTableView()),
          GoRoute(
              path: 'min-sample-edit',
              builder: (context, state) => const MinSampleEdit()),
          GoRoute(
              path: 'min-sample-mio-rows',
              builder: (context, state) => const MinSampleMioRows()),
          GoRoute(
              path: 'sample-jump-to',
              builder: (context, state) => const SampleJumpTo()),
          GoRoute(
              path: 'sample-save-view-state',
              builder: (context, state) => const SampleSaveViewState()),
          GoRoute(
              path: 'sample-reorder-rows',
              builder: (context, state) => const SampleReorderRows()),
          GoRoute(
              path: 'sample-selection-modes',
              builder: (context, state) => const SampleSelectionModes()),
          GoRoute(
              path: 'sample-filter',
              builder: (context, state) => const SampleFilter()),
          GoRoute(
              path: 'sample-drag-drop-1',
              builder: (context, state) => const SampleDragDrop1()),
          GoRoute(
              path: 'scroll-test',
              builder: (context, state) => const ScrollTestView()),
          GoRoute(
              path: 'scroll-test2',
              builder: (context, state) => const ScrollTestView2()),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // Use a Wrapper like this to enable Reorder and Drag and Drop over multiple Controls
    return MhDragDropProvider(
      child: MaterialApp.router(
        routerConfig: _router,
        // scrollBehavior: const MaterialScrollBehavior().copyWith(
        //   // Mouse dragging enabled for scrollbars in this demo
        //   dragDevices: PointerDeviceKind.values.toSet(),
        // ),
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            tertiary: Colors.green.shade700,
            tertiaryContainer: Colors.green.shade200,
            onTertiaryContainer: Colors.green.shade800,
          ),
          scrollbarTheme: const ScrollbarThemeData(
            thumbColor:
                WidgetStatePropertyAll(Color.fromARGB(127, 127, 127, 127)),
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            tertiary: Colors.green.shade700,
            tertiaryContainer: Colors.green.shade200,
            onTertiaryContainer: Colors.green.shade800,
            brightness: Brightness.dark,
          ),
          scrollbarTheme: const ScrollbarThemeData(
            thumbColor:
                WidgetStatePropertyAll(Color.fromARGB(127, 127, 127, 127)),
          ),
        ),
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  /// 3) Call this to change theme from any context using "of" accessor
  /// e.g.:
  /// MyApp.of(context).changeTheme(ThemeMode.dark);
  void changeTheme(ThemeMode newThemeMode) {
    setState(() {
      themeMode = newThemeMode;
    });
  }
}
