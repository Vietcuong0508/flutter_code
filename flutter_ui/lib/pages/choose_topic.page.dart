import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/data/model/topic.model.dart';
import 'package:untitled/data/topic_storage.dart';
import 'package:untitled/utils/theme.dart';
import 'package:untitled/widgets/responsive_builder.dart';

final topicStorage = AssetTopicStorage();

class ChooseTopicPage extends StatelessWidget {
  const ChooseTopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveBuilder(
          portrait: Column(
            children: const [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _Header(),
              ),
              Flexible(
                flex: 3,
                child: _TopicGrid(),
              ),
            ],
          ),
          landscape: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  children: const [
                    Expanded(child: _Header()),
                    Spacer(),
                  ],
                ),
              ),
              const Flexible(
                flex: 2,
                child: _TopicGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicGrid extends StatelessWidget {
  const _TopicGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
        future: topicStorage.load(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final topics = snapshot.data!;
          return MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: topics.length,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemBuilder: (context, index) {
              final topic = topics[index];
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: topic.bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LayoutBuilder(builder: (context, constrains) {
                      return SvgPicture.asset(
                        topic.thumbnail,
                        width: constrains.maxWidth,
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        topics[index].title,
                        style: PrimaryFont.bold(
                                context.screenSize.shortestSide * 0.04)
                            .copyWith(color: topic.textColor),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(
            flex: 3,
          ),
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What Brings you',
                      style: PrimaryFont.bold(28),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'to Silent Moon?',
                      style: PrimaryFont.light(28),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            flex: 1,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'choose a topic to focus on:',
                style: PrimaryFont.light(20).copyWith(
                  color: const Color(0xFFA1A4B2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
