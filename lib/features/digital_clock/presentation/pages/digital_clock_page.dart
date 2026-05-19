import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/digital_clock_bloc.dart';
import '../widgets/timezone_clock_card.dart';

class DigitalClockPage extends StatelessWidget {
  const DigitalClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DigitalClockBloc()..add(const StartClockEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'World Clock',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocBuilder<DigitalClockBloc, DigitalClockState>(
          builder: (context, state) {
            if (state is DigitalClockLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is DigitalClockLoadedState) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Local Time Display
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Local Time',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  state.localTime,
                                  style: TextStyle(
                                    fontSize: 48.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  state.localDate,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Other Time Zones
                    Text(
                      'Other Time Zones',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 1,
                      ),
                      itemCount: state.timeZones.length,
                      itemBuilder: (context, index) {
                        return TimeZoneClockCard(
                          timezone: state.timeZones[index],
                          time: state.times[index],
                          date: state.dates[index],
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            if (state is DigitalClockErrorState) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }

            return const Center(
              child: Text('Unable to load clock'),
            );
          },
        ),
      ),
    );
  }
}
