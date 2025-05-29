import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:zaplab_design/zaplab_design.dart';

class CommunitiesTab extends StatelessWidget {
  const CommunitiesTab({super.key});

  TabData tabData(BuildContext context) {
    return TabData(
      label: 'Communities',
      icon: const AppEmojiContentType(contentType: 'community'),
      content: HookConsumer(
        builder: (context, ref, _) {
          final communities =
              ref.watch(query<Community>()).models.cast<Community>();

          return AppContainer(
            padding: const AppEdgeInsets.all(AppGapSize.s12),
            child: Column(
              children: [
                for (final community in communities)
                  Column(
                    children: [
                      AppCommunityCard(
                        community: community,
                        onTap: () {},
                        onProfilesTap: () {},
                      ),
                      const AppGap.s12(),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => tabData(context).content;
}
