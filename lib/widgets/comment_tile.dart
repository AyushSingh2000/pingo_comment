import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/comment_model.dart';
import '../services/remote_config_service.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;

  CommentTile({required this.comment});

  String maskEmail(String email) {
    var parts = email.split('@');
    if (parts[0].length <= 3) {
      return email;
    }
    return '${parts[0].substring(0, 3)}****@${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    final remoteConfigService = Provider.of<RemoteConfigService>(context);

    bool maskEmailConfig = remoteConfigService.maskEmail;

    return Card(
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFCED3EC),
              radius: 30.0,
              child: Text(
                comment.email != null && comment.email!.isNotEmpty
                    ? comment.email![0].toUpperCase()
                    : '?',
                style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xFF303F60),
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Name: ",
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Color(0xFFCED3EC),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: '${comment.name ?? 'No Name'}',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Color(0xFF303F60),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.0),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Email: ",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFFCED3EC),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              '${maskEmailConfig ? maskEmail(comment.email ?? 'No Email') : (comment.email ?? 'No Email')}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF303F60),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    comment.body ?? 'No Content',
                    style: TextStyle(
                      color: Color(0xFF303F60),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
