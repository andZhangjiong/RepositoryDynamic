//
//  HXExpandNode.m
//  HongXun
//
//  Created by 张炯 on 2018/4/4.
//

#import "HXExpandNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "HXWCDynamic.h"

#import "UIColor+hex.h"
#import "UIFont+HXChat.h"

#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define     WIDTH_SCREEN  [UIScreen mainScreen].bounds.size.width

@interface HXExpandNode ()

@property (nonatomic, strong) HXWCDynamic *model;
@property (nonatomic, strong) ASImageNode *topImageNode;
@property (nonatomic, strong) ASTextNode *likeLabel;

@property (nonatomic, strong) ASDisplayNode *underLineNode;

@property (nonatomic, strong) NSMutableArray *cells;

@end

@implementation HXExpandNode

- (HXExpandNode *)initWithModel:(HXWCDynamic *)model
{
    if (self = [super init]) {
        _model = model;
        self.userInteractionEnabled = YES;
        if (model.praiseArray.count || model.commentArray.count) {
            [self setUpView];
        }
    }
    return self;
}

- (void)setUpView
{
    _topImageNode = [[ASImageNode alloc] init];
    _topImageNode.image = [UIImage imageNamed:@"icon_circle_like"];
    [self addSubnode:_topImageNode];
    
    _likeLabel = [[ASTextNode alloc] init];
    _likeLabel.userInteractionEnabled = YES;
    _likeLabel.maximumNumberOfLines = 0;
    _likeLabel.style.maxWidth = self.style.maxWidth;
    [self addSubnode:_likeLabel];
    
    NSMutableAttributedString *likeText = [[NSMutableAttributedString alloc] init];
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor colorWithHex:0x292929]};
    NSDictionary *specialForeground = @{NSForegroundColorAttributeName:[UIColor colorWithHex:0x046363]};
    UIFont *font = [UIFont systemFontOfSize:15];

    
    for (HXWCPraise *praise in self.model.praiseArray) {
        
        if (likeText.length) {
            [likeText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，" attributes:attributes]];
        }
        
        if (praise.nickname) {
            NSAttributedString *substr = [[NSAttributedString alloc] initWithString:praise.nickname
                                                                         attributes:specialForeground];
            [likeText appendAttributedString:substr];
        }
    }
    
    [likeText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, likeText.length)];
    _likeLabel.attributedText = likeText;
    
    _cells = [NSMutableArray array];
    for (HXWCComment *comment in self.model.commentArray) {
        
        ASTextNode *commentLabel = [[ASTextNode alloc] init];
        commentLabel.userInteractionEnabled = YES;
        
        commentLabel.maximumNumberOfLines = 0;
        [self addSubnode:commentLabel];
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
        
        if (comment.nickname) {
            
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:comment.nickname attributes:specialForeground]];
            
            BOOL isAnswer = comment.replyuid.length;
            if (isAnswer) {
                if ([comment.replyuid isEqualToString:self.model.userinfoid]) {
                    [text appendAttributedString:
                     [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" 说：%@",comment.content] attributes:attributes]];
                }
                else {
                    [text appendAttributedString:
                     [[NSAttributedString alloc] initWithString:@" 回复 " attributes:attributes]];
                    
                    [text appendAttributedString:
                     [[NSAttributedString alloc] initWithString:comment.replynickname attributes:specialForeground]];
                    
                    [text appendAttributedString:
                     [[NSAttributedString alloc] initWithString:comment.content attributes:attributes]];
                    
                }
            }
            else {
                [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" 说：%@",comment.content]]];
            }
        }
        
        [text addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
        commentLabel.attributedText = text;
        [_cells addObject:commentLabel];
    }
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc]init];
    underLineNode.layerBacked = YES;
    underLineNode.backgroundColor = RGB(223, 223, 223);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    BOOL isShow = self.model.praiseArray.count || self.model.commentArray.count;
    NSMutableArray *verticals;
    
    if (isShow) {
        verticals = @[].mutableCopy;
        _topImageNode.style.preferredSize = _topImageNode.image.size;
        [verticals addObject:_topImageNode];
    }
    else {
        return nil;
    }
    
    self.cornerRadius = 5;
    CGFloat margar = 10;
    CGFloat insetsMargar = 5;
    UIEdgeInsets insets = UIEdgeInsetsMake(insetsMargar, insetsMargar, insetsMargar, insetsMargar);
    
    _underLineNode.style.preferredSize = CGSizeMake(self.style.maxWidth.value, 0.5);
    
    if (self.model.praiseArray.count) {
        self.likeLabel.style.width = ASDimensionMakeWithPoints(self.style.maxWidth.value -
                                                               margar * 2 -
                                                               _topImageNode.image.size.width);
        [verticals addObject:self.likeLabel];
    }
    
    for (ASTextNode *commentLabel in self.cells) {
        commentLabel.style.width = ASDimensionMakeWithPoints(self.style.maxWidth.value - margar * 2 );
    }
    
    ASInsetLayoutSpec *horizontalInsetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(insetsMargar, insetsMargar, 0, 0)
                                                                                      child:verticals.firstObject];
    ASStackLayoutSpec *newLayou = nil;
    if (self.model.praiseArray.count) {
        newLayou = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                           spacing:insetsMargar+2
                                                    justifyContent:ASStackLayoutJustifyContentSpaceAround
                                                        alignItems:ASStackLayoutAlignItemsStart
                                                          children:@[horizontalInsetLayout,verticals[1]]];
        
        if (self.model.commentArray.count) {
            newLayou = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                               spacing:insetsMargar
                                                        justifyContent:ASStackLayoutJustifyContentStart
                                                            alignItems:ASStackLayoutAlignItemsStart
                                                              children:@[newLayou,_underLineNode]];
        }
    }
    
    if (isShow) {
        
        NSMutableArray *array = @[newLayou ? newLayou : horizontalInsetLayout].mutableCopy;
        if (self.cells.count) {
            [array addObjectsFromArray:self.cells];
        }
        ASStackLayoutSpec *verticalLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                    spacing:self.model.praiseArray.count ? insetsMargar : margar
                                                                             justifyContent:ASStackLayoutJustifyContentStart
                                                                                 alignItems:ASStackLayoutAlignItemsStart
                                                                                   children:array];
        ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:verticalLayout];
        return insetLayout;
        
    }
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:newLayou ? newLayou : horizontalInsetLayout];
    return insetLayout;
}



@end
