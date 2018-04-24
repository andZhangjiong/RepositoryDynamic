//
//  HXWCPraise.h
//  HongXun
//
//  Created by 张炯 on 2018/3/27.
//

#import <Foundation/Foundation.h>

@interface HXWCPraise : NSObject

// 昵称
@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *ID;

// 动态ID -> 自定义  用于查询   需要手动存储
@property (nonatomic, copy) NSString *webchatid;


+ (NSMutableArray<HXWCPraise *> *)keyValues:(NSArray *)praises webchatid:(NSString *)webchatid;


@end
