import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:zaplab_design/zaplab_design.dart';
import '../../providers/resolvers.dart';

class ForumTab extends StatelessWidget {
  const ForumTab({super.key});

  TabData tabData(BuildContext context) {
    return TabData(
      label: 'Forum',
      icon: const AppEmojiContentType(contentType: 'forum'),
      bottomBar: const AppBottomBarSafeArea(),
      content: HookConsumer(
        builder: (context, ref, _) {
          final theme = AppTheme.of(context);

          final forumPosts =
              ref.watch(query<ForumPost>()).models.cast<ForumPost>();

          return Column(
            children: [
              AppContainer(
                padding: const AppEdgeInsets.all(AppGapSize.s12),
                child: AppPanel(
                  padding: const AppEdgeInsets.only(
                    left: AppGapSize.s16,
                    right: AppGapSize.s12,
                    top: AppGapSize.s12,
                    bottom: AppGapSize.s12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                AppProfilePic.fromUrl("ghjk",
                                    size: AppProfilePicSize.s48),
                                const AppGap.s12(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.reg14("Welcome to the Forum of the",
                                        color: theme.colors.white66),
                                    AppText.med16(
                                      "Satshoot Community",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const AppGap.s12(),
                            AppText.reg14(
                                "Click on the Forum button again to filter posts or search for a topic",
                                color: theme.colors.white66),
                          ],
                        ),
                      ),
                      AppCrossButton.s24(
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              for (final forumPost in forumPosts)
                AppFeedForumPost(
                  forumPost: forumPost,
                  onTap: (model) =>
                      context.push('/forum/${model.id}', extra: model),
                  onReply: (model) =>
                      context.push('/reply-to/${model.id}', extra: model),
                  onActions: (model) =>
                      context.push('/actions/${model.id}', extra: model),
                  onReactionTap: (reaction) {},
                  onZapTap: (zap) {},
                  onResolveEvent: ref.read(resolversProvider).eventResolver,
                  onResolveProfile: ref.read(resolversProvider).profileResolver,
                  onResolveEmoji: ref.read(resolversProvider).emojiResolver,
                  onResolveHashtag: ref.read(resolversProvider).hashtagResolver,
                  onLinkTap: (url) {
                    print(url);
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => tabData(context).content;
}
