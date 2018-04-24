//
//  HXWCComment.h
//  HongXun
//
//  Created by 张炯 on 2018/3/27.
//

#import <Foundation/Foundation.h>

@interface HXWCComment : NSObject

@property (nonatomic, copy) NSString *ID;

// 评论内容
@property (nonatomic, copy) NSString *content;

// 动态ID
@property (nonatomic, copy) NSString *webchatid;

// 评论人昵称
@property (nonatomic, copy) NSString *nickname;

// 评论人用户ID
@property (nonatomic, copy) NSString *userinfoid;


// 被评论昵称
@property (nonatomic, copy) NSString *replynickname;

// 被评论用户ID
@property (nonatomic, copy) NSString *replyuid;


+ (NSMutableArray <HXWCComment*>* )keyValues:(NSArray *)comments webchatid:(NSString *)webchatid;


@end
