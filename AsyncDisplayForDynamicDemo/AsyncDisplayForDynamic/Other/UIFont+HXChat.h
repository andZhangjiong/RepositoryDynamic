//
//  UIFont+HXChat.h
//  HongXun
//
//  Created by 张炯 on 2017/8/18.
//
//

#import <UIKit/UIKit.h>

@interface UIFont (HXChat)

#pragma mark - Common
+ (UIFont *)fontNavBarTitle;

#pragma mark - Conversation
+ (UIFont *)fontConversationUsername;
+ (UIFont *)fontConversationDetail;
+ (UIFont *)fontConversationTime;

#pragma mark - Friends
+ (UIFont *) fontFriendsUsername;

#pragma mark - Mine
+ (UIFont *)fontMineNikename;
+ (UIFont *)fontMineUsername;

#pragma mark - Setting
+ (UIFont *)fontSettingHeaderAndFooterTitle;


#pragma mark - Chat   自适应Plus
+ (UIFont *)fontTextMessageText;

+ (UIFont *) fontFontOfSize16;

+ (UIFont *) fontFontOfSize15;

+ (UIFont *) fontFontOfSize14;

+ (UIFont *) fontFontOfSize13;

+ (UIFont *) fontFontOfSize12;

+ (UIFont *) fontFontOfSize11;

+ (UIFont *) fontFontOfSize10;

@end
