import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage('${article["urlToImage"]}'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text('${article['title']}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  Text('${article['publishedAt']}',
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          )
        ],
      ),
    );

Widget myDivider() => Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      height: 1,
      color: Colors.orange,
    ));

Widget articleBuilder(list, context) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      itemCount: list.length,
      separatorBuilder: (context, index) => myDivider(),
    ),
    fallback: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
