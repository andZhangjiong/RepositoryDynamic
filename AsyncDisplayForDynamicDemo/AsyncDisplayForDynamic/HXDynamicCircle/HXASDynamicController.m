//
//  HXASDynamicController.m
//  HongXun
//
//  Created by 张炯 on 2018/4/3.
//

#import "HXASDynamicController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "HXASCellNode.h"
#import "HXWCDynamic.h"
//#import <AFNetworking.h>


static NSString *kCellReuseIdentifier = @"CellReuseIdentifier";

@interface HXASDynamicController ()<ASTableDataSource,ASTableDelegate>
@property (nonatomic, strong) ASTableNode *tableNode;

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) BOOL haveMore;


@end

@implementation HXASDynamicController

- (instancetype)init
{
    if (self = [super initWithNode:[ASDisplayNode new]]) {
        [self setUpView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HXWCDynamic createTable];
    
    [self configureTableView];
    
    self.datas = [[HXWCDynamic findFormatSqlConditionsWithUserinfoid:@"393d698640fb424282d78e1c460060cd"] mutableCopy];
    [self.tableNode reloadData];
    
    // 模拟网络数据
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self performSelector:@selector(getNewData) withObject:self afterDelay:2];
}

- (void)getNewData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self loadMoreDataWithContext:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableNode.frame = self.node.bounds;
}

- (void)dealloc
{
    self.tableNode.delegate = nil;
    self.tableNode.dataSource = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privately

- (void)setUpView
{
    _tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    _tableNode.dataSource = self;
    _tableNode.delegate = self;
    _tableNode.backgroundColor = [UIColor whiteColor];
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableNode.view.leadingScreensForBatching =  1.0;
    [self.node addSubnode:_tableNode];
    
    _pageCount = 0;
}

- (void)configureTableView
{
    if (_extendedTabBarInset) {
        _tableNode.view.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableNode.view.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    }
    _tableNode.view.tableFooterView = [[UIView alloc]init];
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)insertNewRowsInTableNode:(NSArray<NSDictionary*>*)array
{
    NSInteger section = 0;
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSUInteger row = _datas.count-array.count; row < _datas.count; row++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:path];
    }
    [_tableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (void)loadMoreDataWithContext:(ASBatchContext *)context
{
    if (context) {
        _pageCount += 1;
        [context beginBatchFetching];
    }
    
    if (_pageCount == 0) {
        [self.datas removeAllObjects];
    }
    
    NSMutableArray *data = @[].mutableCopy;
    int count = arc4random() % 50;
    for (int i = 0; i < count ; ++i) {
        HXWCDynamic *wcModel = [HXWCDynamic keyValues:nil];
        [self.datas addObject:wcModel];
        [data addObject:@""];
    }
    
    [self.tableNode reloadData];

    
//    NSArray *data = response[@"data"];
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    NSString *url  = @"";
//
//    params[@"friendid"] = @"393d698640fb424282d78e1c460060cd";
//    params[@"userinfoid"] = @"393d698640fb424282d78e1c460060cd";
//    params[@"pageCurrent"] = @(_pageCount);
//    params[@"orderField"] = @"createtime";
//    params[@"orderDirection"] = @"1";
//    params[@"pageSize"] = @"100";
//    params[@"terminal"] = @"ios";
//    params[@"version"] = @"1.01";
//
//    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
//    requestSerializer.timeoutInterval = 20.0f;
//    sessionManager.requestSerializer = requestSerializer;
//
//    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
//    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
//    sessionManager.responseSerializer = responseSerializer;
//
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
//    [sessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (responseObject) {
//
//            NSData *responseData = responseObject;
//            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//
//            if ([response[@"retCode"]  isEqualToString:@"000"]) {
//
//                NSArray *data = response[@"data"];
//
//                if (_pageCount == 0) {
//                    [self.datas removeAllObjects];
//                }
//
//                for (NSDictionary* dictionary in data) {
//                    HXWCDynamic *wcModel = [HXWCDynamic keyValues:dictionary];
//                    [self.datas addObject:wcModel];
//                }
//                if (context) { // 加载更多
//                    if (data.count > 0) {
//                        [self insertNewRowsInTableNode:data];
//                    }
//                    [context completeBatchFetching:YES];
//                }
//                else {
//                    [self.tableNode reloadData];
//                }
//            }
//        }
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (context) {
//            [context completeBatchFetching:YES];
//        }
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    }];
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

#pragma mark - Delegate
#pragma mark ASTableDataSource

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXWCDynamic* model = self.datas[indexPath.row];
    
    ASCellNode *(^ASCellNodeBlock)() = ^ASCellNode *() {
        HXASCellNode *cellNode = [[HXASCellNode alloc] initWithModel:model];
        return cellNode;
    };
    
    return ASCellNodeBlock;
}

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode
{
    return 1;
}

#pragma mark ASTableDelegate

- (BOOL)shouldBatchFetchForTableNode:(ASTableNode *)tableNode
{
    return YES;
}


- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context
{
//    [self loadMoreDataWithContext:context];
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
    
    
}



@end
