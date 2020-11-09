//
//  FSMessageVC.m
//  FSToolBarDemo
//
//  Created by forget on 2020/11/3.
//

#import "FSMessageVC.h"
#import "FSChatCell.h"

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
        _dataSource = [NSMutableArray arrayWithArray:@[@"张三", @"李四", @"王五", @"崔六"]];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.splitView.delegate = self;
    
    self.flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = NSMakeSize(self.collectionView.frame.size.width, 60);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = self.flowLayout;
    self.collectionView.layer.backgroundColor = NSColor.redColor.CGColor;
    self.collectionView.wantsLayer = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.selectable = YES;
    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:@"FSChatCell" bundle:nil]
               forItemWithIdentifier:@"kChatItem"];
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 200;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 300;
}

- (void)splitViewDidResizeSubviews:(NSNotification *)notification {
    self.flowLayout.itemSize = NSMakeSize(self.collectionView.frame.size.width, 60);
}

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return 1;
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

@end
