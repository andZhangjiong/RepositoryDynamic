//
//  HXWCDynamic+WCTTableCoding.h
//  HongXun
//
//  Created by 张炯 on 2018/3/26.
//

#import "HXWCDynamic.h"
#import <WCDB/WCDB.h>

@interface HXWCDynamic (WCTTableCoding)<WCTTableCoding>

// 访问者id
WCDB_PROPERTY(myUserid);

// 头像
WCDB_PROPERTY(photo)

// 昵称
WCDB_PROPERTY(nickname)

// 内容
WCDB_PROPERTY(content)

WCDB_PROPERTY(selected)

// 图片
WCDB_PROPERTY(spicpath)
WCDB_PROPERTY(bpicpath)

// 点赞状态
WCDB_PROPERTY(praisestatus)

// 点赞列表
WCDB_PROPERTY(praiselist)

// 动态发布时间
WCDB_PROPERTY(pubdate)

// 用户信息
WCDB_PROPERTY(sex)
WCDB_PROPERTY(grade)
WCDB_PROPERTY(userinfoid)

WCDB_PROPERTY(createtime)
WCDB_PROPERTY(ID)
WCDB_PROPERTY(imginfo)
WCDB_PROPERTY(location)

@end
