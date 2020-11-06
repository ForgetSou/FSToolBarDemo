//
//  FSTabbarView.m
//  FSToolBarDemo
//
//  Created by forget on 2020/11/2.
//

#import "FSTabbarView.h"
#import "FSTabbarBtn.h"

@interface FSTabbarView () {
    FSTabbarBtn *_lastSelectBtn;
}

@property (weak) IBOutlet FSTabbarBtn *messageBtn;
@property (weak) IBOutlet FSTabbarBtn *contactBtn;
@property (weak) IBOutlet FSTabbarBtn *moreBtn;

//关联同一个方法
- (IBAction)itemButtonClicked:(FSTabbarBtn *)sender;

@end

@implementation FSTabbarView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self){
        [self setup];
    }
    return self;
}

- (void)setup {
    //从xib中加载控件
    [[NSBundle mainBundle]loadNibNamed:@"FSTabbarView" owner:self topLevelObjects:nil];
    [self addSubview:self.messageBtn];
    [self addSubview:self.contactBtn];
    [self addSubview:self.moreBtn];
    
    //图片赋值
    self.messageBtn.normalImageName = @"menu-message-normal";
    self.messageBtn.downImageName = @"menu-message-down";
    self.messageBtn.toolTip = @"会话";
    self.messageBtn.selected = YES;
    _lastSelectBtn = self.messageBtn;
    
    self.contactBtn.normalImageName = @"menu-contact-normal";
    self.contactBtn.downImageName = @"menu-contact-down";
    self.contactBtn.toolTip = @"好友";
    
    self.moreBtn.normalImageName = @"menu-more-normal";
    self.moreBtn.downImageName = @"menu-more-down";
    self.moreBtn.toolTip = @"应用";
    
    //取消按钮高亮状态，去掉点击时的灰色背景
    [self.messageBtn.cell setHighlightsBy:NSNoCellMask];
    [self.contactBtn.cell setHighlightsBy:NSNoCellMask];
    [self.moreBtn.cell setHighlightsBy:NSNoCellMask];
 }

- (IBAction)itemButtonClicked:(FSTabbarBtn *)sender {
    //新旧选中状态切换
    _lastSelectBtn.selected = NO;
    sender.selected = YES;
    _lastSelectBtn = sender;
    if (self.tabbarClickBlock) {
        self.tabbarClickBlock(sender.tag);
    }
}

@end
