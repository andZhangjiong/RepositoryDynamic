//
//  HXWCDynamic.h
//  HongXun
//
//  Created by 张炯 on 2018/3/26.
//

#import <Foundation/Foundation.h>
#import "HXWCPraise.h"
#import "HXWCComment.h"

#define kWC_TABLE_WCDB_NAME @"WC_TABLE_WCDB_NAME_Dynamic"
#define kUSERID @"393d698640fb424282d78e1c460060cd"


@interface HXWCDynamic : NSObject

// 访问者id
@property (nonatomic, copy) NSString *myUserid;

// 头像
@property (nonatomic, copy) NSString *photo;

// 昵称
@property (nonatomic, copy) NSString *nickname;

// 内容
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) BOOL selected;

// 图片 小图，大图
@property (nonatomic, copy) NSArray *spicpath;
@property (nonatomic, copy) NSArray *bpicpath;

// 点赞状态
@property (nonatomic, copy) NSString *praisestatus;

// 点赞列表
@property (nonatomic, copy) NSMutableArray < HXWCPraise* > *praiseArray;

// 评论列表
@property (nonatomic, copy) NSMutableArray < HXWCComment* > *commentArray;

// 动态发布时间
@property (nonatomic, copy) NSString *pubdate;

// 用户信息
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *userinfoid;

@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *imginfo;
@property (nonatomic, copy) NSString *location;

+ (instancetype)keyValues:(NSDictionary *)dict;

/**
 *  创建表
 */
+ (BOOL)createTable;

/**
 *  查询
 */
+ (NSArray *)findFormatSqlConditionsWithUserinfoid:(NSString *)userid;

/**
 *  更新数据库是否成功
 *  成功，数据库有数据
 *  失败，数据库没有数据
 */
- (BOOL)findFormatSqlConditions;

/**
 *  数据库中是否存在
 */
- (BOOL)isExistObjects;

/**
 *  插入一条新数据
 */
- (BOOL)insertObject;

- (BOOL)updateObject;

/**
 *  删除一条新数据
 */
- (BOOL)deleteObjects;

+ (BOOL)deleteAll;

@end
