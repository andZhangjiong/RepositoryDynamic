//
//  HXWCPraise.m
//  HongXun
//
//  Created by 张炯 on 2018/3/27.
//

#import "HXWCPraise.h"
#import "HXWCPraise+WCTTableCoding.h"

@implementation HXWCPraise

WCDB_IMPLEMENTATION(HXWCPraise)

// 头像
WCDB_SYNTHESIZE(HXWCPraise, nickname)

// 昵称
WCDB_SYNTHESIZE(HXWCPraise, ID)

// 动态ID -> 自定义  用于查询
WCDB_SYNTHESIZE(HXWCPraise, webchatid)


+ (NSMutableArray<HXWCPraise *> *)keyValues:(NSArray *)praises webchatid:(NSString *)webchatid
{
    
    NSMutableArray *mutablArray = [NSMutableArray array];
    if (!praises) {
        /**
         *  本地数据
         */
        NSArray *names = @[@"李靚蕾Jinglei ​​​​",@"王力宏",@"芒果捞小萌主",@"李易峰",@"萌动我心07",@"Any-梅",@"晴天v雪天",@"薰衣草shanshan花语",@"罗优雅hiahiahia",@"张弓弓长",@"爱上执手温酒",@"做你怀里柔软的猫"];
        
        int count = arc4random() % 50;
        for (int i = 0; i < count;  ++i ) {
            HXWCPraise *praise = [[HXWCPraise alloc] init];
            
            int x = arc4random() % (names.count - 1);

            praise.ID = [self getRandomStringWithNum:32];
            praise.nickname = names[x];
            praise.webchatid = webchatid;
            [mutablArray addObject:praise];
        }
        return mutablArray;
    }
    
    /**
     *  网络数据
     */
    for (NSDictionary *paraiseDict in praises) {
        HXWCPraise *praise = [[HXWCPraise alloc] init];
        
        praise.ID = [NSString stringWithFormat:@"%@",paraiseDict[@"id"]];
        praise.nickname = [NSString stringWithFormat:@"%@",paraiseDict[@"nickname"]];
        praise.webchatid = [NSString stringWithFormat:@"%@",webchatid];

        [mutablArray addObject:praise];
    }
    
    return mutablArray;
}

+ (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}


@end
