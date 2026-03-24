import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/repository/unloading_repository.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/bottle_entry_form.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/capentryform.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/cartonentryform.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/labelentryform.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/monocartonentryform.dart';
import 'package:inventory_mobile_app/widgets/appdropdown.dart';

class UnloadingPage extends StatefulWidget {
  const UnloadingPage({super.key});

  @override
  State<UnloadingPage> createState() => _UnloadingPageState();
}

class _UnloadingPageState extends State<UnloadingPage> {
  int selectedSection = 0;

  final List<String> sections = const [
    "Bottle",
    "Label",
    "Cap",
    "Carton",
    "Mono Carton",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Raw Material Entry",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 300.w,
                  child: AppDropdown(
                    title: "Select Operation",
                    hint: "",
                    items: sections,
                    value: sections[selectedSection],
                    onChanged: (value) {
                      setState(() {
                        selectedSection = sections.indexOf(value!);
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    key: ValueKey(selectedSection),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(create: (context) => MasterBloc()),
                        BlocProvider(
                          create: (context) =>
                              UnloadingBloc(repo: UnloadingRepository()),
                        ),
                      ],
                      child: _buildForm(selectedSection),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(int index) {
    switch (index) {
      case 0:
        return BottleEntryForm();
      case 1:
        return LabelEntryForm();
      case 2:
        return CapEntryForm();
      case 3:
        return CartonEntryForm();
      case 4:
        return MonoCartonEntryForm();
      default:
        return const SizedBox();
    }
  }
}
