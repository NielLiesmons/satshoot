import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:satshoot/src/feeds/jobs_feed.dart';
import 'package:zaplab_design/zaplab_design.dart';
import '../../providers/resolvers.dart';

class DiscoverTab extends ConsumerWidget {
  const DiscoverTab({super.key});

  TabData tabData(BuildContext context) {
    final theme = AppTheme.of(context);

    return TabData(
      label: 'Discover',
      icon: const AppEmojiContentType(contentType: 'discover'),
      bottomBar: const AppBottomBarSafeArea(),
      content: HookConsumer(
        builder: (context, ref, _) {
          final servicesState = ref.watch(query<Service>());
          final services = servicesState.models.cast<Service>();
          final jobsState = ref.watch(query<Job>());
          final jobs = jobsState.models.cast<Job>();

          return Column(
            children: [
              AppContainer(
                padding: const AppEdgeInsets.all(AppGapSize.s12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBigSectionTitle(
                      title: 'Services',
                      filter: 'Satshoot Community',
                    ),
                    const AppGap.s8(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < services.length; i++) ...[
                            AppContainer(
                              width: 260,
                              child: AppServiceCard(
                                service: services[i],
                                onTap: (service) {
                                  // Handle service tap
                                },
                                noPadding: true,
                              ),
                            ),
                            if (i < services.length - 1) const AppGap.s16(),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const AppDivider(),
              AppContainer(
                padding: const AppEdgeInsets.all(AppGapSize.s12),
                child: Column(
                  children: [
                    AppBigSectionTitle(
                      title: 'Jobs',
                      filter: 'Satshoot Community',
                    ),
                    const AppGap.s8(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < jobs.length; i++) ...[
                            AppContainer(
                              width: 300,
                              child: AppJobCard(
                                job: jobs[i],
                                onTap: (job) {
                                  // Handle job tap
                                },
                              ),
                            ),
                            if (i < jobs.length - 1) const AppGap.s16(),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const AppDivider(),
              AppContainer(
                padding: const AppEdgeInsets.all(AppGapSize.s12),
                child: Column(
                  children: [
                    AppBigSectionTitle(
                      title: 'Other',
                      filter: 'Placeholder',
                    ),
                    const AppGap.s8(),
                    AppPanel(
                      child: SizedBox(
                        width: double.infinity,
                        height: 500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => tabData(context).content;
}
