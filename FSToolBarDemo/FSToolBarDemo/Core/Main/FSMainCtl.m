//
//  ViewContFSMainCtlroller.m
//  FSToolBarDemo
//
//  Created by forget on 2020/10/29.
//

#import "FSMainCtl.h"
#import "FSCustomBtn.h"
#import "FSMessageVC.h"
#import "FSContactVC.h"
#import "FSMoreVC.h"
#import "FSTabbarView.h"

@interface FSMainCtl ()

@property (weak) IBOutlet FSTabbarView *tabbarView;
@property (weak) IBOutlet NSView *baseView;

@property (strong, nonatomic) NSView *oldView;

@end

@implementation FSMainCtl

- (void)viewDidLoad {
    [super viewDidLoad];
/**
    FSCustomBtn *btn = [[FSCustomBtn alloc] initWithFrame:CGRectMake(10, 10, 100, 60)];
    btn.isHandCursor = YES;
    btn.target = self;
    btn.backgroundColor = NSColor.blueColor;
    btn.selectedBackgroundColor = NSColor.lightGrayColor;
    btn.titleColor = NSColor.redColor;
    btn.selectedTitleColor = NSColor.greenColor;
    btn.textAlignment = FSTextAlignmentCenter;
    btn.rectCorners = FSRectCornerTopLeft | FSRectCornerBottomRight;
    btn.radius = 20;
    [btn setAction:@selector(btnClick:)];
    [self.view addSubview:btn];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
*/
    NSView *tmpView = [[NSView alloc] initWithFrame:self.baseView.bounds];
    [self.baseView addSubview:tmpView];
    self.baseView.wantsLayer = YES;
    self.baseView.layer.backgroundColor = NSColor.whiteColor.CGColor;
    self.oldView = tmpView;
    [self addChildVCWith:100];
    
    self.tabbarView.tabbarClickBlock = ^(NSInteger tag) {
        [self addChildVCWith:tag];
    };
}

//- (void)btnClick:(FSCustomBtn *)sender {
//    NSLog(@"...");
//}

- (void)addChildVCWith:(NSInteger)tag {
    NSViewController *vc;
    if (tag == 100) {
        vc = [[NSStoryboard storyboardWithName:@"message" bundle:nil] instantiateControllerWithIdentifier:@"message"];
    } else
    if (tag == 200) {
        vc = [[NSStoryboard storyboardWithName:@"contact" bundle:nil] instantiateControllerWithIdentifier:@"contact"];
    } else {
        vc = [[NSStoryboard storyboardWithName:@"more" bundle:nil] instantiateControllerWithIdentifier:@"more"];
    }
    [self addChildViewController:vc];

    NSView *tmpView = vc.view;
    [self.baseView replaceSubview:self.oldView with:tmpView];
    self.oldView = tmpView;
    [self addConstraintWithView:tmpView];
}

- (void)addConstraintWithView:(NSView *)tmpView {
    tmpView.translatesAutoresizingMaskIntoConstraints = NO;
    [[tmpView.topAnchor constraintEqualToAnchor:self.baseView.topAnchor] setActive:YES];
    [[tmpView.bottomAnchor constraintEqualToAnchor:self.baseView.bottomAnchor] setActive:YES];
    [[tmpView.leftAnchor constraintEqualToAnchor:self.baseView.leftAnchor] setActive:YES];
    [[tmpView.rightAnchor constraintEqualToAnchor:self.baseView.rightAnchor] setActive:YES];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
