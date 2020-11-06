//
//  FSWindowCtl.m
//  FSToolBarDemo
//
//  Created by forget on 2020/10/29.
//

#import "FSWindowCtl.h"

@interface FSWindowCtl ()<NSToolbarDelegate, NSWindowDelegate>

@property (strong, nonatomic) NSToolbar *toolbar;

@end

static NSToolbarItemIdentifier kMessageIdentifier = @"messageID";
static NSToolbarItemIdentifier kConnectIdentifier = @"connectID";
static NSToolbarItemIdentifier kMoreIdentifier = @"moreID";

@implementation FSWindowCtl

- (void)windowDidLoad {
    [super windowDidLoad];
    [self settingWindowStyle];
}

- (void)settingWindowStyle {
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.styleMask = NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskTitled | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskFullSizeContentView;
    [self.window setMovableByWindowBackground:YES];
    [self updateTitleBarOfWindow:false];
}
// 修改关闭、最小化、全屏的位置
- (void)updateTitleBarOfWindow:(BOOL)fullScreen {
    CGFloat kTitlebarH = 54.0;
    CGFloat kFullScreenButtonYOrigin = 3.0;
    NSRect windowFrame = self.window.frame;
    NSView *titlebarContainerView = [self.window standardWindowButton:NSWindowCloseButton].superview.superview;
    NSRect titlebarContainerFrame = titlebarContainerView.frame;
    titlebarContainerFrame.origin.y = windowFrame.size.height - kTitlebarH;
    titlebarContainerFrame.size.height = (CGFloat)kTitlebarH;
    titlebarContainerView.frame = titlebarContainerFrame;
    
    CGFloat buttonX = 12.0;
    NSButton *closeBtn = [self.window standardWindowButton:NSWindowCloseButton];
    NSButton *minimizeBtn = [self.window standardWindowButton:NSWindowMiniaturizeButton];
    NSButton *zoomBtn = [self.window standardWindowButton:NSWindowZoomButton];
    
    for (NSButton *buttonView in @[closeBtn, minimizeBtn, zoomBtn]) {
        NSRect buttonFrame = buttonView.frame;
        buttonFrame.origin.y = fullScreen ? kFullScreenButtonYOrigin : round((kTitlebarH - buttonFrame.size.height)/2.0);
        buttonFrame.origin.x = (CGFloat)buttonX;
        buttonX = buttonFrame.size.width + buttonX + 6;
        [buttonView setFrameOrigin:buttonFrame.origin];
    }
}

- (void)settingToolBar {
    self.toolbar = [[NSToolbar alloc] initWithIdentifier:@"toolbar"];
    [self.toolbar setSizeMode:NSToolbarSizeModeRegular];
    self.toolbar.autosavesConfiguration = YES;
    self.toolbar.allowsUserCustomization = YES;
    self.toolbar.showsBaselineSeparator = NO;
    self.toolbar.delegate = self;
    self.toolbar.displayMode = NSToolbarDisplayModeIconOnly;
    [self.window setToolbar:self.toolbar];
}

#pragma mark - NSWindowDelegate
- (void)windowDidEnterFullScreen:(NSNotification *)notification {
    [self updateTitleBarOfWindow:YES];
}

- (void)windowDidExitFullScreen:(NSNotification *)notification {
    [self updateTitleBarOfWindow:NO];
}

- (void)windowDidResize:(NSNotification *)notification {
    [self updateTitleBarOfWindow:NO];
}

#pragma mark - NSToolbarDelegate
- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    NSToolbarItem *toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
    if ([itemIdentifier isEqualToString:kMessageIdentifier]) {
        toolbarItem.image = [NSImage imageNamed:@"menu-message-normal"];
        toolbarItem.toolTip = @"会话";
    } else if ([itemIdentifier isEqualToString:kConnectIdentifier]) {
        toolbarItem.image = [NSImage imageNamed:@"menu-contact-normal"];
        toolbarItem.toolTip = @"好友";
    } else if ([itemIdentifier isEqualToString:kMoreIdentifier]) {
        toolbarItem.image = [NSImage imageNamed:@"menu-more-normal"];
        toolbarItem.toolTip = @"应用";
    } else {
        return nil;
    }
    toolbarItem.minSize = NSMakeSize(100, 100);
    toolbarItem.target = self;
    [toolbarItem setAction:@selector(itemClick:)];
    return toolbarItem;
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return @[NSToolbarFlexibleSpaceItemIdentifier,
             kMessageIdentifier,
             NSToolbarSpaceItemIdentifier,
             kConnectIdentifier,
             NSToolbarSpaceItemIdentifier,
             kMoreIdentifier,
             NSToolbarFlexibleSpaceItemIdentifier];
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    return @[kMessageIdentifier,
             kConnectIdentifier,
             kMoreIdentifier,
             NSToolbarSpaceItemIdentifier,
             NSToolbarFlexibleSpaceItemIdentifier];
}

#pragma mark - Action
- (void)itemClick:(NSToolbarItem *)item {
    if ([item.itemIdentifier isEqualToString:kMessageIdentifier]) {
        item.image = [NSImage imageNamed:@"menu-message-down"];
        for (NSToolbarItem *fItem in self.toolbar.items) {
            if ([fItem.itemIdentifier isEqualToString:kConnectIdentifier]) {
                fItem.image = [NSImage imageNamed:@"menu-contact-normal"];
            }
            if ([fItem.itemIdentifier isEqualToString:kMoreIdentifier]) {
                fItem.image = [NSImage imageNamed:@"menu-more-normal"];
            }
        }
    }
    if ([item.itemIdentifier isEqualToString:kConnectIdentifier]) {
        item.image = [NSImage imageNamed:@"menu-contact-down"];
        for (NSToolbarItem *fItem in self.toolbar.items) {
            if ([fItem.itemIdentifier isEqualToString:kMessageIdentifier]) {
                fItem.image = [NSImage imageNamed:@"menu-message-normal"];
            }
            if ([fItem.itemIdentifier isEqualToString:kMoreIdentifier]) {
                fItem.image = [NSImage imageNamed:@"menu-more-normal"];
            }
        }
    }
    if ([item.itemIdentifier isEqualToString:kMoreIdentifier]) {
        item.image = [NSImage imageNamed:@"menu-more-down"];
        for (NSToolbarItem *fItem in self.toolbar.items) {
            if ([fItem.itemIdentifier isEqualToString:kMessageIdentifier]) {
                fItem.image = [NSImage imageNamed:@"menu-message-normal"];
            }
            if ([fItem.itemIdentifier isEqualToString:kConnectIdentifier]) {
                fItem.image = [NSImage imageNamed:@"menu-contact-normal"];
            }
        }
    }
}

@end
