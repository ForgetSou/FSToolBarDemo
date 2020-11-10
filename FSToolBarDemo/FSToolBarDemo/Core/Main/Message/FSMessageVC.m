//
//  FSMessageVC.m
//  FSToolBarDemo
//
//  Created by forget on 2020/11/3.
//

#import "FSMessageVC.h"
#import "FSChatCell.h"
#import "FSChatHeaderView.h"

@interface FSMessageVC ()
<
NSSplitViewDelegate,
NSCollectionViewDelegate,
NSCollectionViewDataSource,
NSCollectionViewDelegateFlowLayout
>

@property (weak) IBOutlet NSSplitView *splitView;
@property (weak) IBOutlet NSCollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (strong, nonatomic) NSCollectionViewFlowLayout *flowLayout;

@end

@implementation FSMessageVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"张三", @"李四", @"王五", @"崔六", @"1", @"2", @"3", @"4"]];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.splitView.delegate = self;
    
    self.flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = NSMakeSize(self.collectionView.width, 60);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = self.flowLayout;
    self.collectionView.layer.backgroundColor = NSColor.redColor.CGColor;
    self.collectionView.wantsLayer = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.selectable = YES;
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([FSChatCell class]) bundle:nil]
               forItemWithIdentifier:@"kChatItem"];
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:@"FSChatHeaderView" bundle:nil]
          forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader
                      withIdentifier:@"kChatHeader"];
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 200;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 300;
}

- (void)splitViewDidResizeSubviews:(NSNotification *)notification {
    self.flowLayout.itemSize = NSMakeSize(self.collectionView.width, 60);
}

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (nonnull NSCollectionViewItem *)collectionView:(nonnull NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FSChatCell *cell = (FSChatCell *)[collectionView makeItemWithIdentifier:@"kChatItem" forIndexPath:indexPath];
    cell.name = self.dataSource[indexPath.item];
    return cell;
}

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    NSIndexPath *indexPath = indexPaths.allObjects.firstObject;
    FSChatCell *cell = (FSChatCell *)[collectionView itemAtIndexPath:indexPath];
    cell.view.wantsLayer = YES;
    cell.view.layer.backgroundColor = NSColor.lightGrayColor.CGColor;
}

- (void)collectionView:(NSCollectionView *)collectionView didDeselectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    NSIndexPath *indexPath = indexPaths.allObjects.firstObject;
    FSChatCell *cell = (FSChatCell *)[collectionView itemAtIndexPath:indexPath];
    cell.view.wantsLayer = YES;
    cell.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
}

- (BOOL)commitEditingAndReturnError:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    return YES;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return NSMakeSize(self.collectionView.width, 40);
}

- (NSView *)collectionView:(NSCollectionView *)collectionView
viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind
               atIndexPath:(NSIndexPath *)indexPath {
    FSChatHeaderView *headerView = [collectionView makeSupplementaryViewOfKind:NSCollectionElementKindSectionHeader
                                                                withIdentifier:@"kChatHeader"
                                                                  forIndexPath:indexPath];
    headerView.headerClick = ^{
        NSLog(@"%ld", (long)indexPath.section);
    };
    return headerView;
}

@end
