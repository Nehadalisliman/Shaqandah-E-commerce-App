import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/app_router.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';
import '../widget/BrandTypeSection.dart';
import '../widget/best_selling_grid.dart';
import '../widget/categories_list_section.dart';

// ✅ تم حذف جميع مكتبات الـ Web والـ kIsWeb لضمان بناء الـ APK بنجاح

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            "شقندة - الرئيسية",
            style: TextStyle(color: Colors.black, fontSize: 18.sp, fontFamily: 'Cairo')
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () => context.read<HomeCubit>().fetchHomeData(),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
            );
          } else if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errMessage),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().fetchHomeData(),
                    child: const Text("إعادة المحاولة"),
                  )
                ],
              ),
            );
          } else if (state is HomeSuccess) {

            // ❌ تم حذف شرط if (kIsWeb) وعملية تسجيل الصور تماماً
            // لأننا اعتمدنا الآن على Image.network في كل الكروت (Widgets)

            return RefreshIndicator(
              onRefresh: () async => context.read<HomeCubit>().fetchHomeData(),
              color: const Color(0xFFD4AF37),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),

                    // البحث والتصفية
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: _buildSearchField()),
                          SizedBox(width: 10.w),
                          Expanded(flex: 1, child: _buildCategoryDropdown(state)),
                        ],
                      ),
                    ),

                    SizedBox(height: 25.h),
                    BrandTypeSection(brandTypes: state.brandTypes),

                    SizedBox(height: 35.h),
                    CategoriesListSection(categories: state.categories),

                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _buildSectionHeader("الأكثر مبيعاً"),
                    ),

                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: BestSellingGrid(
                        products: state.products,
                        onProductTap: (productId) {
                          GoRouter.of(context).push(
                            AppRouter.kProductDetails,
                            extra: productId,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- دوال الـ UI المساعدة ---

  Widget _buildSearchField() => TextField(
    decoration: InputDecoration(
      hintText: "ابحث عن منتج...",
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
    ),
  );

  Widget _buildCategoryDropdown(HomeSuccess state) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: const Text("الكل"),
        isExpanded: true,
        value: selectedCategoryId,
        items: state.categories.map((cat) => DropdownMenuItem(
          value: cat.categoryId,
          child: Text(cat.categoryName, style: TextStyle(fontSize: 12.sp)),
        )).toList(),
        onChanged: (val) => setState(() => selectedCategoryId = val),
      ),
    ),
  );

  Widget _buildSectionHeader(String title) => Text(
    title,
    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
  );

  Widget _buildBottomNav() => BottomNavigationBar(
    selectedItemColor: const Color(0xFFD4AF37),
    unselectedItemColor: Colors.grey,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
    ],
  );
}