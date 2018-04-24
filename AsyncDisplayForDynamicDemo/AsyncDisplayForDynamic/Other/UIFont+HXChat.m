//
//  UIFont+HXChat.m
//  HongXun
//
//  Created by 张炯 on 2017/8/18.
//
//

#import "UIFont+HXChat.h"
#define     OVER_Iphone6                WIDTH_SCREEN > 375
#define     WIDTH_SCREEN  [UIScreen mainScreen].bounds.size.width

@implementation UIFont (HXChat)

+ (UIFont *) fontNavBarTitle
{
    return [UIFont boldSystemFontOfSize:17.5f];
}

+ (UIFont *) fontConversationUsername
{
    return [UIFont systemFontOfSize:17.0f];
}

+ (UIFont *) fontFriendsUsername
{
    return [UIFont systemFontOfSize:17.0f];
}

+ (UIFont *) fontMineNikename
{
    return [UIFont systemFontOfSize:16.0f];
}

+ (UIFont *) fontMineUsername
{
    return [UIFont systemFontOfSize:14.0f];
}

+ (UIFont *) fontConversationTime
{
    return [UIFont systemFontOfSize:12.5f];
}


+ (UIFont *) fontSettingHeaderAndFooterTitle
{
    return [UIFont systemFontOfSize:12.0f];
}

+ (UIFont *) fontConversationDetail
{
    return [UIFont systemFontOfSize:10.0f];
}


+ (UIFont *)fontTextMessageText
{
    CGFloat size = [[NSUserDefaults standardUserDefaults] doubleForKey:@"CHAT_FONT_SIZE"];
    if (size == 0) {
        size = 16.0f;
    }
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)fontFontOfSize16
{
    if (OVER_Iphone6) {
        return [UIFont systemFontOfSize:16.0f/0.9];
    }
    return [UIFont systemFontOfSize:16.0f];
}

+ (UIFont *) fontFontOfSize15
{
    if (OVER_Iphone6) {
        return [UIFont systemFontOfSize:15.0f/0.9];
    }
    return [UIFont systemFontOfSize:15.0f];
}

+ (UIFont *) fontFontOfSize14
{
    if (OVER_Iphone6) {
        return [UIFont systemFontOfSize:14.0f/0.9];
    }
    return [UIFont systemFontOfSize:14.0f];
}

+ (UIFont *) fontFontOfSize13
{
    if (OVER_Iphone6) {
        return [UIFont systemFontOfSize:13.0f/0.9];
    }
    return [UIFont systemFontOfSize:13.0f];
}

+ (UIFont *) fontFontOfSize12
{
    if (OVER_Iphone6) {
        return [UIFont systemFontOfSize:12.0f/0.9];
    }
    return [UIFont systemFontOfSize:12.0f];
}

+ (UIFont *) fontFontOfSize11
{
    if (OVER_Iphone6) {
        return [UIFont systemFontOfSize:11.0f/0.9];
    }
    return [UIFont systemFontOfSize:11.0f];
}

+ (UIFont *) fontFontOfSize10
{
    if (OVER_Iphone6) {
        return [UIFont systemFontOfSize:10.0f/0.9];
    }
    return [UIFont systemFontOfSize:10.0f];
}

@end
