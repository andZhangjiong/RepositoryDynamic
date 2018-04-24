//
//  HXASCellNode.m
//  HongXun
//
//  Created by 张炯 on 2018/4/3.
//

#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define     WIDTH_SCREEN  [UIScreen mainScreen].bounds.size.width

#import "HXASCellNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

#import "HXImagesView.h"
#import "HXExpandNode.h"

#import "HXWCDynamic.h"

#import "UIFont+HXChat.h"
#import "UIColor+hex.h"

@interface HXASCellNode ()

@property (nonatomic, strong) HXWCDynamic *model;

@property (nonatomic, strong) ASNetworkImageNode *headNode;
@property (nonatomic, strong) ASTextNode *titleNode;
@property (nonatomic, strong) ASTextNode *contentNode;
@property (nonatomic, strong) ASButtonNode *adverbButton;
@property (nonatomic, strong) HXImagesView *imagesNode;

@property (nonatomic, strong) ASButtonNode *addresButton;
@property (nonatomic, strong) ASTextNode *timeNode;

@property (nonatomic, strong) HXExpandNode *expandNode;

@property (nonatomic, strong) ASDisplayNode *underLineNode;

@property (nonatomic, assign) BOOL contentSelected;

@end

@implementation HXASCellNode

- (instancetype)initWithModel:(HXWCDynamic *)model
{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = YES;
        _model = model;
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    ASNetworkImageNode *headNode = [[ASNetworkImageNode alloc]init];
    headNode.layerBacked = YES;
    headNode.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.photo]];
    [self addSubnode:headNode];
    _headNode = headNode;
    
    ASTextNode *titleNode = [[ASTextNode alloc]init];
    titleNode.placeholderEnabled = YES;
    titleNode.placeholderColor = RGB(245, 245, 245);
    titleNode.layerBacked = YES;
    titleNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:14] ,NSForegroundColorAttributeName: [UIColor colorWithHex:0x046363]};
    if (self.model.nickname) {
        titleNode.attributedText = [[NSAttributedString alloc]initWithString:self.model.nickname attributes:attrs];
    }
    [self addSubnode:titleNode];
    _titleNode = titleNode;
    
    ASTextNode *contentNode = [[ASTextNode alloc]init];
    contentNode.placeholderEnabled = YES;
    contentNode.placeholderColor = RGB(245, 245, 245);
    contentNode.layerBacked = YES;
    attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.0f] ,NSForegroundColorAttributeName: [UIColor colorWithHex:0x292929]};
    if (self.model.content) {
        contentNode.attributedText = [[NSAttributedString alloc]initWithString:self.model.content attributes:attrs];
    }
    [self addSubnode:contentNode];
    _contentNode = contentNode;
    
    if (self.model.selected) {
        contentNode.maximumNumberOfLines = 0;
    }
    else {
        contentNode.maximumNumberOfLines = contentNode.lineCount < 4 ? 0 : 4;
    }
    
    ASButtonNode *adverbButton = [[ASButtonNode alloc]init];
    [adverbButton setTitle:@"查看" withFont:[UIFont systemFontOfSize:12] withColor:[UIColor colorWithHex:0x046363] forState:UIControlStateNormal];
    [adverbButton setTitle:@"收起" withFont:[UIFont systemFontOfSize:12] withColor:[UIColor colorWithHex:0x046363] forState:UIControlStateSelected];
    [adverbButton addTarget:self action:@selector(adverbButtonAction:) forControlEvents:(ASControlNodeEventTouchUpInside)];
    [self addSubnode:adverbButton];
    _adverbButton = adverbButton;
    
    HXImagesView *imagesNode = [[HXImagesView alloc]init];
    imagesNode.layerBacked = YES;
    [self addSubnode:imagesNode];
    _imagesNode = imagesNode;
    
    imagesNode.spicpaths = self.model.spicpath;
    
    ASButtonNode *addresButton = [[ASButtonNode alloc]init];
    if (self.model.location) {
        [addresButton setTitle:self.model.location withFont:[UIFont systemFontOfSize:12] withColor:[UIColor colorWithHex:0x046363] forState:UIControlStateNormal];
    }
    [addresButton addTarget:self action:@selector(addresButtonAction) forControlEvents:(ASControlNodeEventTouchUpInside)];
    [self addSubnode:addresButton];
    _addresButton = addresButton;
    
    ASTextNode *timeNode = [[ASTextNode alloc]init];
    timeNode.placeholderEnabled = YES;
    timeNode.placeholderColor = RGB(245, 245, 245);
    timeNode.layerBacked = YES;
    timeNode.maximumNumberOfLines = 1;
    attrs = @{ NSFontAttributeName: [UIFont systemFontOfSize:13.0f] ,NSForegroundColorAttributeName: [UIColor colorWithHex:0x8c8c8c]};
    if (self.model.pubdate) {
        timeNode.attributedText = [[NSAttributedString alloc]initWithString:self.model.pubdate attributes:attrs];
    }
    [self addSubnode:timeNode];
    _timeNode = timeNode;
    
    HXExpandNode *expandNode = [[HXExpandNode alloc] initWithModel:self.model];
    expandNode.layerBacked = NO;
    expandNode.backgroundColor = [UIColor colorWithHex:0xf0f1f3];
    [self addSubnode:expandNode];
    _expandNode = expandNode;
    
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc]init];
    underLineNode.layerBacked = YES;
    underLineNode.backgroundColor = RGB(223, 223, 223);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}

- (void)addresButtonAction
{
    
}

- (void)adverbButtonAction:(ASButtonNode *)button
{
    button.selected = !button.selected;
    self.model.selected = button.selected;
    
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _underLineNode.style.layoutPosition = CGPointMake(0, constrainedSize.max.height-0.5);
    _underLineNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    CGFloat margar = 10;
    CGFloat insetsMargar = 19;
    UIEdgeInsets insets = UIEdgeInsetsMake(insetsMargar, insetsMargar, insetsMargar, insetsMargar);

    self.headNode.style.preferredSize = CGSizeMake(40, 40);
    self.contentNode.style.maxWidth = ASDimensionMakeWithPoints(WIDTH_SCREEN-(40+margar*2)-insetsMargar);
    self.expandNode.style.maxWidth = self.contentNode.style.maxWidth;
    self.imagesNode.style.maxWidth = self.contentNode.style.maxWidth;
    self.adverbButton.style.maxHeight = ASDimensionMakeWithPoints(45);

    NSInteger index = self.contentNode.lineCount;
    NSMutableArray *verticals = @[self.titleNode].mutableCopy;
    
    if (self.model.content.length) {
        [verticals addObject:self.contentNode];
    }
    if (self.contentNode.lineCount > 4) {
        [verticals addObject:self.adverbButton];
    }
    if (self.model.spicpath.count) {
        [verticals addObject:self.imagesNode];
    }
    if (self.model.location.length) {
        [verticals addObject:self.addresButton];
    }
    
    [verticals addObject:self.timeNode];
    
    if (self.model.praiseArray.count || self.model.commentArray.count) {
        [verticals addObject:self.expandNode];
    }

    ASStackLayoutSpec *verticalLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                               spacing:margar
                                                                        justifyContent:ASStackLayoutJustifyContentStart
                                                                            alignItems:ASStackLayoutAlignItemsStart
                                                                              children:verticals];
    
    ASStackLayoutSpec *contentLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                             spacing:margar
                                                                      justifyContent:ASStackLayoutJustifyContentStart
                                                                          alignItems:ASStackLayoutAlignItemsStart
                                                                            children:@[self.headNode, verticalLayout]];
    
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:contentLayout];
    
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                spacing:0
                                                                         justifyContent:ASStackLayoutJustifyContentStart
                                                                             alignItems:ASStackLayoutAlignItemsStart
                                                                               children:@[insetLayout,_underLineNode]];
    return verStackLayout;
}


@end
