//
//  FSMessageVC.m
//  FSToolBarDemo
//
//  Created by forget on 2020/11/3.
//

#import "FSMessageVC.h"

@interface FSMessageVC ()<NSSplitViewDelegate>
@property (weak) IBOutlet NSSplitView *splitView;

@end

@implementation FSMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.'
    self.splitView.delegate = self;
    
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 200;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 300;
}

@end
