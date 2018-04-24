//
//  HXWCComment+WCTTableCoding.h
//  HongXun
//
//  Created by 张炯 on 2018/3/27.
//

#import "HXWCComment.h"
#import <WCDB/WCDB.h>

@interface HXWCComment (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(ID)

// 评论内容
WCDB_PROPERTY(content)

// 动态ID
WCDB_PROPERTY(webchatid)

// 评论人昵称
WCDB_PROPERTY(nickname)

// 评论人用户ID
WCDB_PROPERTY(userinfoid)


// 被评论昵称
WCDB_PROPERTY(replynickname)

// 被评论用户ID
WCDB_PROPERTY(replyuid)

@end
