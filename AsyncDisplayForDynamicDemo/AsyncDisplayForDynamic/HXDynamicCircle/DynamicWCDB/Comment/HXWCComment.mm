//
//  HXWCComment.m
//  HongXun
//
//  Created by 张炯 on 2018/3/27.
//

#import "HXWCComment.h"
#import "HXWCComment+WCTTableCoding.h"

@implementation HXWCComment

WCDB_IMPLEMENTATION(HXWCComment)

// 头像
WCDB_SYNTHESIZE(HXWCComment, ID)

// 评论内容
WCDB_SYNTHESIZE(HXWCComment, content)

// 动态ID
WCDB_SYNTHESIZE(HXWCComment, webchatid)

// 评论人昵称
WCDB_SYNTHESIZE(HXWCComment, nickname)

// 评论人用户ID
WCDB_SYNTHESIZE(HXWCComment, userinfoid)

// 被评论昵称
WCDB_SYNTHESIZE(HXWCComment, replynickname)

// 被评论用户ID
WCDB_SYNTHESIZE(HXWCComment, replyuid)


+ (NSMutableArray<HXWCComment *> *)keyValues:(NSArray *)comments webchatid:(NSString *)webchatid
{
    NSMutableArray *mutablArray = [NSMutableArray array];
    
    if (!comments) {
        /**
         *  本地数据
         */
        
        NSArray *names = @[@"李靚蕾Jinglei ​​​​",@"王力宏",@"芒果捞小萌主",@"李易峰",@"萌动我心07",@"Any-梅",@"晴天v雪天",@"薰衣草shanshan花语",@"罗优雅hiahiahia",@"张弓弓长",@"爱上执手温酒",@"做你怀里柔软的猫"];
        
        NSArray *replynickname = @[@"有几颗星星啊 ​​​​",@"黑毛狗邓子函",@"周文琪喝可乐",@"金毛狗董雪坷",@"张硕很烦",@"笑颜撩人丷",@"王木木Stories-Untold",@"黄山吴彦祖-",@"晓霞Soplei",@"风城王祖贤",@"w-myth",@"粟裕100"];
        
        NSArray *contents = @[@"看完这部剧超喜欢德善去剪了短发，结果变成了蔡英文",
                              @"我也觉得德善的时候最好看，不要那么浓的妆，那时候最好看",
                              @"我们惠利真的是个很可爱很有趣的姑娘呢",
                              @"秀妍、秀妍、秀妍，要说多少次？你这样秀妍考不上大学的[笑cry][笑cry][笑cry]",
                              @"总之每次看她都会被她的鼻子吸引",
                              @"这他妈才是纯正狗粮",
                              @"跑完一身臭汗 全蹭女朋友身上了",
                              @"你身材好的时候跟最胖的我在一起……现在我身材好了跟最胖的你在一起？？？爱情是个轮回吗",
                              @"太帅气啦",
                              @"：史上最帅的小警察。峰峰、你帅爆了。新戏未播先火是因为有你…",
                              @"这个世界缺的不是完美的人... 只问深情，无问西东",
                              @"你先的喔！偷拍大战..开始....今天..还是明天? 直播...影片..还是照片？要偷拍二哥@王力宏 做什么呢"];
        
        int count = arc4random() % 50;        
        for (int i = 0; i < count;  ++i ) {
            HXWCComment *comment = [[HXWCComment alloc] init];
            
            int x = arc4random() % (names.count - 1);
            int y = arc4random() % (replynickname.count - 1);
            int z = arc4random() % (contents.count - 1);

            comment.webchatid = webchatid;
            comment.ID = [self getRandomStringWithNum:32];
            
            comment.replyuid = [self getRandomStringWithNum:16];
            comment.userinfoid = [self getRandomStringWithNum:16];
            
            comment.nickname = names[x];
            comment.replynickname = replynickname[y];
            comment.content = contents[z];

            [mutablArray addObject:comment];
        }
        return mutablArray;
    }
    
    /**
     *  网络数据
     */
    for (NSDictionary *commentDict in comments) {
        HXWCComment *comment = [[HXWCComment alloc] init];
        
        comment.webchatid = [NSString stringWithFormat:@"%@",commentDict[@"webchatid"]];
        comment.ID = [NSString stringWithFormat:@"%@",commentDict[@"id"]];
        comment.content = [NSString stringWithFormat:@"%@",commentDict[@"content"]];
        comment.nickname = [NSString stringWithFormat:@"%@",commentDict[@"nickname"]];
        comment.userinfoid = [NSString stringWithFormat:@"%@",commentDict[@"userinfoid"]];
        comment.replynickname = [NSString stringWithFormat:@"%@",commentDict[@"replynickname"]];
        comment.replyuid = [NSString stringWithFormat:@"%@",commentDict[@"replyuid"]];

        [mutablArray addObject:comment];
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
