//
//  FSContactVC.m
//  FSToolBarDemo
//
//  Created by forget on 2020/11/3.
//

#import "FSContactVC.h"

@interface FSContactVC ()<NSSplitViewDelegate>

@property (strong, nonatomic) NSSplitView *splitView;

@end

@implementation FSContactVC

- (NSSplitView *)splitView {
    if (!_splitView) {
        _splitView = [[NSSplitView alloc] initWithFrame:CGRectMake(10, 100, 600, 400)];
        _splitView.delegate = self;
        _splitView.vertical = YES;
        _splitView.dividerStyle = NSSplitViewDividerStylePaneSplitter;
        _splitView.wantsLayer = YES;
        _splitView.layer.backgroundColor = NSColor.whiteColor.CGColor;
        _splitView.toolTip = @"代码创建SplitView";
    }
    return _splitView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.lightGrayColor.CGColor;
    
    [self addSplitView];
}

- (void)addSplitView {
    NSView *leftView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, 100, 400)];
    [self.splitView addArrangedSubview:leftView];
    
    NSView *rightView = [[NSView alloc] initWithFrame:CGRectMake(100, 0, 500, 400)];
    [self.splitView addArrangedSubview:rightView];
    
    [self.view addSubview:self.splitView];
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 100;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return 200;
}

/// 能否折叠子视图
- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview {
    return YES;
}

#pragma mark - IBAction

- (IBAction)openPanelClick:(NSButton *)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.prompt = @"选择";
    openPanel.title = @"NSSplitView Demo";
    openPanel.message = @"你是谁的谁";
    openPanel.canChooseFiles = YES;
    openPanel.canChooseDirectories = YES;
    openPanel.allowsMultipleSelection = YES;
    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            NSLog(@"%@", openPanel.URLs);
        }
        sender.state = NSControlStateValueOff;
    }];
}

@end
