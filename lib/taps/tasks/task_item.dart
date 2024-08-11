import 'package:flutter/material.dart';
import 'package:todo/app_them.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
   ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color:AppTheme.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: MediaQuery.of(context).size.height * .13,
      child: Row(
        children: [
          Container(
            color:theme.primaryColor,
            width: 4,
            height: 62,
            margin: EdgeInsetsDirectional.only(end: 10),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Play basketball",
                style: theme.textTheme.titleLarge ?. copyWith(color: Theme.of(context).primaryColor,)
              ),
              Text(
                'This is description',
                style: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
              )
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width * .16,
            height: 36,
            child: Icon(Icons.check ,color: AppTheme.white, size: 32,),
          )
        ],
      ),
    );
  }
}
