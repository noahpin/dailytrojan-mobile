import 'package:dailytrojan/article_route.dart';
import 'package:dailytrojan/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';

class PostList extends StatelessWidget {
  const PostList({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var post in posts) PostElementImage(post: post),
      ],
    );
  }
}

class PostElementImage extends StatelessWidget {
  final Post post;

  const PostElementImage({
    super.key,
    required this.post,
  });

  final double imageSize = 100.0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final headlineStyle = theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onSurface,
        fontFamily: "SourceSerif4",
        fontSize: 18,
        fontWeight: FontWeight.bold);
    final authorStyle = theme.textTheme.labelSmall!.copyWith(
        color: theme.colorScheme.onSurfaceVariant, fontFamily: "Inter");
    final excerptStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontSize: 14.0,
        fontFamily: "SourceSerif4");

    var articleDOM = parse(post.content);
    var author = '';
    articleDOM.querySelectorAll('h6').forEach((e) {
      // a really awful way to do things because the wordpress api doesnt return the correct author 100% of the time.
      ;
      if (e.innerHtml.startsWith("By")) {
        author = (htmlUnescape.convert(e.innerHtml));
        return;
      }
    });

    return InkWell(
      onTap: () {
        appState.setArticle(post);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ArticleRoute()),
        );
      },
      child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8)
            .add(horizontalContentPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        htmlUnescape.convert(post.title),
                        style: headlineStyle,
                      ),
                      SizedBox(height: 6),
                      Text(
                          parse(htmlUnescape.convert(post.excerpt))
                                  .querySelector("p")
                                  ?.innerHtml ??
                              "",
                          style: excerptStyle),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image(
                    image: NetworkImage(post.coverImage),
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          DateFormat('MMM d, yyyy')
                              .format(DateTime.parse(post.date)),
                          style: authorStyle),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.bookmark_border_outlined)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.share)),
                          ],
                        ),
                      )
                    ],
                  ),
          ],
        ),
        
      ),
    );
  }
}

class PostElement extends StatelessWidget {
  final Post post;

  const PostElement({
    super.key,
    required this.post,
  });

  final double imageSize = 100.0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final headlineStyle = theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onSurface,
        fontFamily: "SourceSerif4",
        fontWeight: FontWeight.bold);
    final subStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary, fontSize: 14.0, fontFamily: "Inter");
    final authorStyle = theme.textTheme.labelSmall!.copyWith(
        color: theme.colorScheme.onSurfaceVariant, fontFamily: "Inter");

    var articleDOM = parse(post.content);
    var author = '';
    articleDOM.querySelectorAll('h6').forEach((e) {
      // a really awful way to do things because the wordpress api doesnt return the correct author 100% of the time.
      ;
      if (e.innerHtml.startsWith("By")) {
        author = (htmlUnescape.convert(e.innerHtml));
        return;
      }
    });

    return InkWell(
      onTap: () {
        appState.setArticle(post);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ArticleRoute()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0)
            .add(horizontalContentPadding),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                post.breaking
                    ? Text("BREAKING",
                        style: subStyle.copyWith(fontWeight: FontWeight.bold))
                    : EmptyWidget(),
                Text(
                  htmlUnescape.convert(post.title),
                  style: headlineStyle,
                ),
                SizedBox(height: 6),
                Text(author, style: authorStyle)
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class PostElementImageLarge extends StatelessWidget {
  final Post post;

  const PostElementImageLarge({
    super.key,
    required this.post,
  });

  final double imageSize = 100.0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final headlineStyle = theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onSurface,
        fontFamily: "SourceSerif4",
        fontWeight: FontWeight.bold);
    final subStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary, fontSize: 14.0, fontFamily: "Inter");
    final authorStyle = theme.textTheme.labelSmall!.copyWith(
        color: theme.colorScheme.onSurfaceVariant, fontFamily: "Inter");
    final excerptStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontSize: 16.0,
        fontFamily: "SourceSerif4");

    var articleDOM = parse(post.content);
    var author = '';
    articleDOM.querySelectorAll('h6').forEach((e) {
      // a really awful way to do things because the wordpress api doesnt return the correct author 100% of the time.
      ;
      if (e.innerHtml.startsWith("By")) {
        author = (htmlUnescape.convert(e.innerHtml));
        return;
      }
    });

    return InkWell(
      onTap: () {
        appState.setArticle(post);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ArticleRoute()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0)
            .add(horizontalContentPadding),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                post.breaking
                    ? Text("BREAKING",
                        style: subStyle.copyWith(fontWeight: FontWeight.bold))
                    : EmptyWidget(),
                Text(
                  htmlUnescape.convert(post.title),
                  style: headlineStyle,
                ),
                SizedBox(height: 6),
                Text(
                    parse(htmlUnescape.convert(post.excerpt))
                            .querySelector("p")
                            ?.innerHtml ??
                        "",
                    style: excerptStyle),
                SizedBox(height: 6),
                Text(author, style: authorStyle),
                SizedBox(height: 8),
                Image(
                  image: NetworkImage(post.coverImage),
                  fit: BoxFit.cover,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class PostElementImageLargeFullTop extends StatelessWidget {
  final Post post;

  const PostElementImageLargeFullTop({
    super.key,
    required this.post,
  });

  final double imageSize = 100.0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final headlineStyle = theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onSurface,
        fontFamily: "SourceSerif4",
        fontWeight: FontWeight.bold);
    final subStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary, fontSize: 14.0, fontFamily: "Inter");
    final authorStyle = theme.textTheme.labelSmall!.copyWith(
        color: theme.colorScheme.onSurfaceVariant, fontFamily: "Inter");
    final excerptStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontSize: 16.0,
        fontFamily: "SourceSerif4");

    var articleDOM = parse(post.content);
    var author = '';
    articleDOM.querySelectorAll('h6').forEach((e) {
      // a really awful way to do things because the wordpress api doesnt return the correct author 100% of the time.
      ;
      if (e.innerHtml.startsWith("By")) {
        author = (htmlUnescape.convert(e.innerHtml));
        return;
      }
    });

    return InkWell(
      onTap: () {
        appState.setArticle(post);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ArticleRoute()),
        );
      },
      child: Column(
        children: [
          Image(
            image: NetworkImage(post.coverImage),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0)
                .add(horizontalContentPadding),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    post.breaking
                        ? Text("BREAKING",
                            style:
                                subStyle.copyWith(fontWeight: FontWeight.bold))
                        : EmptyWidget(),
                    Text(
                      htmlUnescape.convert(post.title),
                      style: headlineStyle,
                    ),
                    SizedBox(height: 6),
                    Text(
                        parse(htmlUnescape.convert(post.excerpt))
                                .querySelector("p")
                                ?.innerHtml ??
                            "",
                        style: excerptStyle),
                        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          DateFormat('MMM d, yyyy')
                              .format(DateTime.parse(post.date)),
                          style: authorStyle),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.bookmark_border_outlined)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.share)),
                          ],
                        ),
                      )
                    ],
                  ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
