//
//  HXImagesView.m
//  HongXun
//
//  Created by 张炯 on 2018/4/3.
//

#import "HXImagesView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

#define     WIDTH_SCREEN  [UIScreen mainScreen].bounds.size.width
#define     HEIGHT_SCREEN  [UIScreen mainScreen].bounds.size.height

#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define     WIDTH_IMAGE_ONE     (WIDTH_SCREEN - 70) * 0.4
#define     WIDTH_IMAGE         (WIDTH_SCREEN - 70) * 0.31
#define     SPACE               4.0

@interface HXImagesView ()
@property (nonatomic, strong) NSMutableDictionary *imageDict;

@end

@implementation HXImagesView

- (void)setUpView
{
    _imageDict = [NSMutableDictionary dictionaryWithCapacity:9];
    for (int i = 0; i < 9; ++i)
    {
        ASNetworkImageNode *headImageView = [[ASNetworkImageNode alloc] init];
        headImageView.layerBacked = YES;
        headImageView.URL = [NSURL URLWithString: @"http://c.hiphotos.baidu.com/image/pic/item/fc1f4134970a304e9fcf65dfddc8a786c9175c22.jpg"];
        [self addSubnode:headImageView];
        [_imageDict addEntriesFromDictionary:@{[NSString stringWithFormat:@"key_%d",i] : headImageView}];
        [headImageView addTarget:self action:@selector(buttonClicked:) forControlEvents:(ASControlNodeEventTouchUpInside)];
    }
}

- (void)buttonClicked:(UIImageView *)imageView
{

}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    CGFloat imageWidth;
    CGFloat imageHeight;
    CGFloat margar = 7;
    NSMutableArray *verticals = [NSMutableArray array];
    if (self.spicpaths.count == 1) {
        imageWidth = WIDTH_IMAGE_ONE - 10;
        imageHeight = imageWidth / WIDTH_SCREEN * HEIGHT_SCREEN;
    }
    else {
        imageHeight = imageWidth = ((WIDTH_SCREEN-(40+10*2)-19)/3-margar);
    }
    for (int i = 0 ; i< self.spicpaths.count; i++)
    {
        ASNetworkImageNode *headImageView = _imageDict[[NSString stringWithFormat:@"key_%d",i]];
        headImageView.style.preferredSize = CGSizeMake(imageWidth, imageHeight);
        headImageView.hidden = NO;
        headImageView.backgroundColor = RGB(223, 223, 223);
        [verticals addObject:headImageView];
    }
    if (verticals.count == 0) {
        return nil;
    }
   
    ASStackLayoutSpec *verticalLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                spacing:margar
                                                                         justifyContent:ASStackLayoutJustifyContentStart
                                                                             alignItems:ASStackLayoutAlignItemsStart
                                                                               children:@[]];
    NSMutableArray *mutableArray = [NSMutableArray array];
    if (verticals.count <= 3) {
        [mutableArray addObject:verticals];
    }
    else if (verticals.count > 3 && verticals.count <= 6) {
        [mutableArray addObject:@[verticals[0],verticals[1],verticals[2]]];
        [mutableArray addObject:[verticals subarrayWithRange:NSMakeRange(3, verticals.count-3)]];
    }
    else {
        [mutableArray addObject:@[verticals[0],verticals[1],verticals[2]]];
        [mutableArray addObject:@[verticals[3],verticals[4],verticals[5]]];
        [mutableArray addObject:[verticals subarrayWithRange:NSMakeRange(6, verticals.count-6)]];
    }
    
    NSInteger count = 0;
    NSMutableArray *verticalLayouts = [NSMutableArray array];
    for (NSArray *array in mutableArray) {
        
        ASStackLayoutSpec *horizontalLayout_new = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                      spacing:margar
                                                                               justifyContent:ASStackLayoutJustifyContentStart
                                                                                   alignItems:ASStackLayoutAlignItemsStart
                                                                                     children: @[]];
        horizontalLayout_new.children = array;
        
        [verticalLayouts addObject:horizontalLayout_new];
        if (mutableArray.count - 1 == count) {
            verticalLayout.children = verticalLayouts;
            return verticalLayout;
        }
        ++count;
    }
    
    return nil;
}

- (void)setSpicpaths:(NSArray *)spicpaths
{
    _spicpaths = spicpaths;
    
    [self setUpView];
    
    for (int i = 0 ; i< self.spicpaths.count; i++)
    {
        ASNetworkImageNode *headImageView = _imageDict[[NSString stringWithFormat:@"key_%d",i]];
        NSString *url = [NSString stringWithFormat:@"%@",self.spicpaths[i]];
        headImageView.URL = [NSURL URLWithString:url];
        headImageView.hidden = NO;
    }
    
    for (int i = self.spicpaths.count; i < 9; ++i)
    {
        ASNetworkImageNode *headImageView = _imageDict[[NSString stringWithFormat:@"key_%d",i]];
        headImageView.hidden = YES;
    }
}

@end
