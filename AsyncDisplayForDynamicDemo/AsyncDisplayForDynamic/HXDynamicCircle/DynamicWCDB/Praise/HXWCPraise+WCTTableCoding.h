//
//  HXWCPraise+WCTTableCoding.h
//  HongXun
//
//  Created by 张炯 on 2018/3/27.
//

#import "HXWCPraise.h"
#import <WCDB/WCDB.h>

@interface HXWCPraise (WCTTableCoding)<WCTTableCoding>

// 头像
WCDB_PROPERTY(nickname)

WCDB_PROPERTY(ID)

// 动态ID -> 自定义  用于查询
WCDB_PROPERTY(webchatid)

@end
