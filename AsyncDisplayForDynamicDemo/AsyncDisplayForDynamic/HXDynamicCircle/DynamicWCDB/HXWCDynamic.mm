//
//  HXWCDynamic.m
//  HongXun
//
//  Created by 张炯 on 2018/3/26.
//

#import "HXWCDynamic.h"
#import "HXWCDynamic+WCTTableCoding.h"

@implementation HXWCDynamic

WCDB_IMPLEMENTATION(HXWCDynamic)

// 访问者id
WCDB_SYNTHESIZE(HXWCDynamic, myUserid);

// 头像
WCDB_SYNTHESIZE(HXWCDynamic, photo)

// 昵称
WCDB_SYNTHESIZE(HXWCDynamic, nickname)

// 内容
WCDB_SYNTHESIZE(HXWCDynamic, content)

WCDB_SYNTHESIZE(HXWCDynamic, selected)


// 图片 小图，大图
WCDB_SYNTHESIZE(HXWCDynamic, spicpath)
WCDB_SYNTHESIZE(HXWCDynamic, bpicpath)

// 点赞状态
WCDB_SYNTHESIZE(HXWCDynamic, praisestatus)

//// 点赞列表
//WCDB_SYNTHESIZE(HXWCDynamic, praiseArray)
//
//// 评论列表
//WCDB_SYNTHESIZE(HXWCDynamic, commentArray)

// 动态发布时间
WCDB_SYNTHESIZE(HXWCDynamic, pubdate)

// 用户信息
WCDB_SYNTHESIZE(HXWCDynamic, sex)
WCDB_SYNTHESIZE(HXWCDynamic, grade)
WCDB_SYNTHESIZE(HXWCDynamic, userinfoid)

WCDB_SYNTHESIZE(HXWCDynamic, createtime)
WCDB_SYNTHESIZE(HXWCDynamic, ID)
WCDB_SYNTHESIZE(HXWCDynamic, imginfo)
WCDB_SYNTHESIZE(HXWCDynamic, location)

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

+ (instancetype)keyValues:(NSDictionary *)dict
{
    if (!dict) {
        /**
         *  本地数据
         */
        HXWCDynamic *model = [[self alloc] init];
        
        NSString *strRandom = @"";
       
        
        model.ID = [HXWCDynamic getRandomStringWithNum:32];
        
        model.myUserid = kUSERID;
        
        // 头像
        NSArray *photos = @[@"http://img4.duitang.com/uploads/item/201511/26/20151126112617_vUaQf.jpeg",
                            @"http://imgsrc.baidu.com/forum/w=580/sign=1588b7c5d739b6004dce0fbfd9503526/7bec54e736d12f2eb97e1a464dc2d56285356898.jpg",
                            @"http://www.qqzhi.com/uploadpic/2014-09-23/000247589.jpg",
                            @"http://pic.qqtn.com/file/2013/2015-5/2015051514475586835.png",
                            @"http://cdnq.duitang.com/uploads/item/201504/04/20150404H3338_N8Wir.jpeg",
                            @"http://up.qqya.com/allimg/201710-t/17-101804_132321.jpg"];
        int x = arc4random() % (photos.count - 1);
        model.photo = photos[x];
        
        // 昵称
        NSArray *names = @[@"李靚蕾Jinglei ​​​​",@"王力宏",@"芒果捞小萌主",@"李易峰",@"萌动我心07",@"Any-梅",@"晴天v雪天",@"薰衣草shanshan花语"];
        x = arc4random() % (names.count - 1);
        model.nickname = names[x];
        
        // 内容
        NSArray *contents = @[@"李易峰制服，李易峰新剧《隐秘而伟大》路透，穿制服的顾耀东警官简直不能更帅，身材太好了，妥妥的制服诱惑，超级期待啊",
                              @"【你身材好的时候，咋没遇到你？情侣相约校园夜跑 女友骑车监督】河南农业大学 的大四学生陈同学每天和女朋友相约校园夜跑，他骑车陪女友跑一圈，女友骑车陪他跑三圈。女友：“你身材好的时候我咋没遇到你？最后还得陪着你减肥。”跑完后，二人还来了个拥抱。网友：嘴上不愿意，身体却很诚实~ L嘿校园的秒拍视频",
                              @"#新闻早餐来啦#【湖北大冶现过马路神器 闯红灯被喷水：谁闯喷谁[允悲]】请不要通行，通行喷水，滋~~~为了治理中国式过马路，湖北大冶市出新招，在红绿灯路口安装高科技设备——行人闯红灯自动识别抓拍系统，系统有语音提醒，能自动抓拍，还能对闯红灯者喷水。网友：夏天…带着沐浴露去？#对此你想说# L中国新闻网的秒拍视频 更多新闻戳→O网页链接",
                              @"李惠利Lee Hye-ri 请回答1988里漂亮又可爱的德善啊[心] ​ ​​​​",
                              @"4月18日 19:40 来自 微博 weibo.com【昆凌自拍撞脸莉莉·柯林斯 周杰伦：你比她漂亮】18日，昆凌@HannahQuinlivan 晒和#莉莉·柯林斯#的照片，称看起来相像很幸运。两人都留着利落短发，同一角度侧脸回眸，确有神似。随后#周杰伦#留言大赞老婆，“你比她漂亮，哈哈，她是谁？”周董嘴真的不要太甜！你老婆最美[二哈]O昆凌晒自拍撞脸莉莉·柯林斯 ​​​​",
                              @"【马克龙自称“我与普京不相上下” 遭网友嘲笑】今日俄罗斯报道，马克龙16日接受媒体采访后与记者私下小酌，在谈及对叙利亚局势的立场时，他坦言“我和普京不相上下”。马克龙甚至还向主持人透露，法国参与对叙利亚的军事打击行动也是为了证明这一点。“普京也理解我。我决定打击叙利亚是为了向普京传达，我们也是其中的一分子。",
                              @"就这样一个无知的违法行为，坑了多少人...[怒骂] L谁干的的秒拍视频 ​​​​",
                              @"44岁生日，一家人纷纷晒照送出祝福，囧三依旧抄袭二哥罗密欧的文案[笑cry]也是看不懂他为啥要把自己打包成那样[笑cry]小七给妈妈唱生日歌，两个儿子认真做蛋糕，老公小贝@DavidBeckham 送了一屋子鲜花，礼物和贺卡堆了满桌，一家人简直不要太温馨幸福",
                              @"「搞笑贴」遇见这么当妈当爹的，我也是醉了哈哈[允悲] ​​​​"];
        x = arc4random() % (contents.count - 1);

        
        model.content = contents[x];
        
        // 图片 小图，大图
        NSArray *images = @[@"http://attachments.gfan.com/forum/attachments2/201304/24/134256oe4lamvbxm7bb2hq.jpg"
                            ];
        
        NSArray *images3 = @[@"http://imgsrc.baidu.com/forum/w%3D580/sign=82a4ddc4e7dde711e7d243fe97edcef4/c98311fa513d26970e28659c57fbb2fb4116d8e3.jpg",
                            @"http://c.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0dac90ad40a7d933bffdec77987bfd25/48540923dd54564e90474e80b1de9c82d1584f6c.jpg",
                            @"http://e.hiphotos.baidu.com/image/pic/item/43a7d933c895d14359a03cf279f082025baf0709.jpg"
                            ];
        
        NSArray *images5 = @[@"http://c.hiphotos.baidu.com/zhidao/pic/item/6609c93d70cf3bc7c5df9afad500baa1cc112acc.jpg",
                             
                            @"http://h.hiphotos.baidu.com/zhidao/pic/item/c8177f3e6709c93d57bdaff59c3df8dcd1005460.jpg",
                             
                             @"http://img4.imgtn.bdimg.com/it/u=77413179,2111005406&fm=214&gp=0.jpg",
                             @"http://scimg.jb51.net/allimg/160324/14-160324150401116.jpg",
                             @"http://i2.sanwen.net/doc/1608/704-160Q10TS9-51.jpg",
                             @"http://img5.duitang.com/uploads/item/201404/27/20140427164330_xBM5s.thumb.700_0.jpeg"
                            ];
        
        NSArray *images7 = @[@"http://pic31.nipic.com/20130728/7447430_144337722000_2.jpg",
                             
                             @"http://up.enterdesk.com/edpic_source/4f/20/ee/4f20eee5c10880c45cb9aad30fda04b8.jpg",
                             
                             @"http://img7.ph.126.net/xnVL3ktL-yI_XCH1YPBjgA==/2502031067998436417.jpg",
                             @"http://img5.duitang.com/uploads/blog/201407/14/20140714203632_a8wLh.thumb.700_0.jpeg",
                             @"http://img.t.388g.com/jzd/uploads/519/images/201705/1493708427687483.jpeg",
                             @"http://up.enterdesk.com/edpic_360_360/d8/a5/a2/d8a5a2e67768afa02184e2302c3a2a3a.jpg",
                             @"http://img4.imgtn.bdimg.com/it/u=253628729,1449487169&fm=214&gp=0.jpg",
                             @"http://image.tianjimedia.com/uploadImages/2014/287/32/1E2205O0EVSB_1000x500.jpg",
                             @"http://wmimg.sc115.com/wm/pic/1604/1604vxl5lnxpi2i.jpg",
                             @"https://wx4.sinaimg.cn/mw690/006e5GHqly1fqgy2ei5jkj30o20yan4o.jpg"
                             ];
        
        NSArray *bpicpaths = @[images,images3,images5,images7];
        x = arc4random() % (bpicpaths.count - 1);

        
        model.spicpath = bpicpaths[x];
        model.bpicpath = model.spicpath;
        
        // 点赞状态
        model.praisestatus = @"0";
        
        // 点赞列表
        model.praiseArray = [HXWCPraise keyValues:nil webchatid:model.ID];
        
        // 评论列表
        model.commentArray = [HXWCComment keyValues:nil webchatid:model.ID];
        
        // 动态发布时间
        model.pubdate = @"今天";
        
        // 用户信息
        model.sex = @"1";
        model.grade = @"12";
        model.userinfoid = @"fdsfasdfsdfasdfsd";
        
        model.createtime = @"fsdfsadf";
        model.location =  @"深圳";
        
        if ([model findFormatSqlConditions]) {
            NSLog(@"更新数据成功");
        }
        
        return model;
    }
    
    /**
     *  网络数据
     */
    HXWCDynamic *model = [[self alloc] init];
    
    model.ID = dict[@"id"];
    
    model.myUserid = kUSERID;
    
    // 头像
    model.photo = dict[@"photo"];
    
    // 昵称
    model.nickname = dict[@"nickname"];
    
    // 内容
    model.content = dict[@"content"];
    
    // 图片 小图，大图
    model.spicpath = dict[@"spicpath"];
    model.bpicpath = dict[@"bpicpath"];
    
    // 点赞状态
    model.praisestatus = dict[@"praisestatus"];
    
    // 点赞列表
    model.praiseArray = [HXWCPraise keyValues:dict[@"praiselist"] webchatid:model.ID];
    
    // 评论列表
    model.commentArray = [HXWCComment keyValues:dict[@"webChatCommentInfoList"] webchatid:model.ID];
    
    // 动态发布时间
    model.pubdate = dict[@"pubdate"];
    
    // 用户信息
    model.sex = dict[@"sex"];
    model.grade = dict[@"grade"];
    model.userinfoid = dict[@"userinfoid"];
    
    model.createtime = dict[@"createtime"];
    model.imginfo = dict[@"imginfo"];
    model.location = dict[@"location"];
    
    if ([model findFormatSqlConditions]) {
        NSLog(@"更新数据成功");
    }
    
    return model;
}

+ (BOOL)createTable
{
    NSString *path = [self pathContactsData];
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    NSString *tabbleName = kWC_TABLE_WCDB_NAME;
    if (![database isTableExists:tabbleName]) {
        BOOL result = [database createTableAndIndexesOfName:tabbleName withClass:self.class];
        if (!result) {
            NSLog(@"创建数据库失败");
        }
        return result;
    }
    return YES;
}

+ (WCTDatabase *)database
{
    NSString *path = [self pathContactsData];
    WCTDatabase *newDatabase = [[WCTDatabase alloc] initWithPath:path];
    return newDatabase;
}

+ (NSArray *)findFormatSqlConditionsWithUserinfoid:(NSString *)userid
{
    WCTDatabase *database = [self database];
    if ([database canOpen]) {
        
        WCTCondition where = [HXWCDynamic getWCTConditionWithObjects:userid];
        NSArray <HXWCDynamic *> *objects = [database getObjectsOfClass:HXWCDynamic.class
                                             fromTable:kWC_TABLE_WCDB_NAME
                                                 where:where];
        return objects;
    }
    return nil;
}

- (BOOL)isExistObjects
{
    WCTDatabase *database = [HXWCDynamic database];
    if ([database canOpen]) {
        NSString *table = kWC_TABLE_WCDB_NAME;
        WCTCondition where = {(HXWCDynamic.userinfoid == kUSERID) &&
            (HXWCDynamic.ID == self.ID)};
        NSArray<HXWCDynamic *> *objects = [database getObjectsOfClass:HXWCDynamic.class
                                                                   fromTable:table
                                                                       where:where];
        return objects.count;
    }
    return NO;
}

- (BOOL)insertObject
{
    BOOL result = NO;
    WCTDatabase *database = [HXWCDynamic database];
    if ([database canOpen]) {
        result = [database insertObject:self into:kWC_TABLE_WCDB_NAME];
    }
    return result;
}

- (BOOL)findFormatSqlConditions
{
    WCTDatabase *database = [HXWCDynamic database];
    if ([database canOpen]) {
        
        WCTSelect *select = [database prepareSelectObjectsOnResults:{
            HXWCDynamic.myUserid,
            HXWCDynamic.photo,
            HXWCDynamic.nickname,
            HXWCDynamic.content,
            HXWCDynamic.selected,
            HXWCDynamic.spicpath,
            HXWCDynamic.bpicpath,
            HXWCDynamic.praisestatus,
            HXWCDynamic.pubdate,
            HXWCDynamic.sex,
            HXWCDynamic.grade,
            HXWCDynamic.userinfoid,
            HXWCDynamic.createtime,
            HXWCDynamic.ID,
            HXWCDynamic.imginfo,
            HXWCDynamic.location
        } fromTable:kWC_TABLE_WCDB_NAME];
        
        WCTCondition where = {(HXWCDynamic.userinfoid == kUSERID) &&
            (HXWCDynamic.ID == self.ID)};
        
        NSArray<HXWCDynamic *> *objects = [[select where:where] limit:10].allObjects;
        if (objects.count) {
            HXWCDynamic *db = objects.lastObject;
            return [self updateObject];
        }
        else {
            return [self insertObject];
        }
    }
    return NO;
}

- (BOOL)updateObject
{
    BOOL result = NO;
    WCTDatabase *database = [HXWCDynamic database];
    if ([database canOpen]) {
        WCTCondition where = {(HXWCDynamic.userinfoid == kUSERID) &&
            (HXWCDynamic.ID == self.ID)};
        result = [database updateRowsInTable:kWC_TABLE_WCDB_NAME
                                onProperties:{
                                    HXWCDynamic.myUserid,
                                    HXWCDynamic.photo,
                                    HXWCDynamic.nickname,
                                    HXWCDynamic.content,
                                    HXWCDynamic.selected,
                                    HXWCDynamic.spicpath,
                                    HXWCDynamic.bpicpath,
                                    HXWCDynamic.praisestatus,
                                    HXWCDynamic.pubdate,
                                    HXWCDynamic.sex,
                                    HXWCDynamic.grade,
                                    HXWCDynamic.userinfoid,
                                    HXWCDynamic.createtime,
                                    HXWCDynamic.ID,
                                    HXWCDynamic.imginfo,
                                    HXWCDynamic.location
                                }
                                  withObject:self where:where];
    }
    return result;
}

- (BOOL)deleteObjects
{
    BOOL result = NO;
    WCTDatabase *database = [HXWCDynamic database];
    if ([database canOpen]) {
        WCTCondition where = {(HXWCDynamic.userinfoid == kUSERID) &&
            (HXWCDynamic.ID == self.ID)};
        result = [database deleteObjectsFromTable:kWC_TABLE_WCDB_NAME where:where];
    }
    return result;
}

+ (BOOL)deleteAll
{
    BOOL result = NO;
    WCTDatabase *database = [HXWCDynamic database];
    if ([database canOpen]) {
        result = [database deleteAllObjectsFromTable:kWC_TABLE_WCDB_NAME];
    }
    return result;
}

#pragma mark - Getter
+ (NSString *)pathContactsData
{
    NSString *path = [NSString stringWithFormat:@"%@/%@/Store/", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],kUSERID];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:@"Store.sqlite"];
}

+ (WCTCondition )getWCTConditionWithObjects:(NSString *)userid
{
    return {(HXWCDynamic.myUserid == userid)};
}


@end
