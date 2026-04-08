import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:inventory_mobile_app/features/master/bloc/bottle_size_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/brand_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_event.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_party_bloc.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_state.dart';
import 'package:inventory_mobile_app/features/master/master_model/mapping_label_model.dart';
import 'package:inventory_mobile_app/features/master/master_repository/master_repo.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/bottle_list_bloc/bottle_list_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/label_list_bloc/label_list_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/bloc/unloading_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/repository/unloading_repository.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/bottle_entry_form.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/capentryform.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/cartonentryform.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/labelentryform.dart';
import 'package:inventory_mobile_app/features/unloading/widgets/monocartonentryform.dart';

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
        leading: BackButton(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: const Text(
          "Raw Material Entry",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              /// 🔥 Tabs instead of dropdown
              SizedBox(
                height: 45.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: sections.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (context, index) {
                    final isSelected = selectedSection == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSection = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade300,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            sections[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              /// 🔥 Form Container
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(selectedSection),
                    // padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) {
                            final now = DateTime.now();
                            final yesterday = now.subtract(
                              const Duration(days: 1),
                            );

                            return BottleListBloc(repo: UnloadingRepository())
                              ..add(
                                FetchBottleListEvent(
                                  fromDate: DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(yesterday),
                                  toDate: DateFormat('yyyy-MM-dd').format(now),
                                ),
                              );
                          },
                        ),
                        BlocProvider(
                          create: (context) {
                            final now = DateTime.now();
                            final yesterday = now.subtract(
                              const Duration(days: 1),
                            );

                            return LabelListBloc(repo: UnloadingRepository())
                              ..add(
                                FetchLabelListEvent(
                                  fromDate: DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(now.subtract(Duration(days: 30))),
                                  toDate: DateFormat('yyyy-MM-dd').format(now),
                                ),
                              );
                          },
                        ),
                        BlocProvider(
                          create: (_) =>
                              UnloadingBloc(repo: UnloadingRepository()),
                        ),

                        BlocProvider(
                          create: (_) =>
                              MasterBloc()
                                ..add(FetchMappingLabelEvent(labelTypeId: 1)),
                        ),
                        BlocProvider(
                          create: (_) =>
                              PartyBloc(repository: MasterRepo())
                                ..add(FetchParties()),
                        ),
                        BlocProvider(
                          create: (_) =>
                              BrandBloc(repository: MasterRepo())
                                ..add(FetchBrands()),
                        ),
                        BlocProvider(
                          create: (_) =>
                              BottleSizeBloc(repository: MasterRepo())
                                ..add(FetchBottleSizes()),
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
        return BottleCreateScreen();
      case 1:
        return LabelCreateScreen();
      case 2:
        return BottleCreateScreen();
      case 3:
        return BottleCreateScreen();
      case 4:
        return BottleCreateScreen();
      default:
        return const SizedBox();
    }
  }
}
