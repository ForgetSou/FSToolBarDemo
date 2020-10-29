//
//  FSWindowCtl.m
//  FSToolBarDemo
//
//  Created by forget on 2020/10/29.
//

#import "FSWindowCtl.h"

@interface FSWindowCtl ()<NSToolbarDelegate>

@end

static NSToolbarItemIdentifier leftIdentifier = @"left";
static NSToolbarItemIdentifier rightIdentifier = @"right";

@implementation FSWindowCtl

- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"toolbar"];
    [toolbar setSizeMode:NSToolbarSizeModeDefault];
    toolbar.allowsUserCustomization = YES;
    toolbar.autosavesConfiguration = YES;
    toolbar.displayMode = NSToolbarDisplayModeIconAndLabel;
    toolbar.delegate = self;
    [self.window setToolbar:toolbar];
}

#pragma mark - NSToolbarDelegate
- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    NSToolbarItem *toolbarItem = [[NSToolbarItem alloc] init];
    if ([itemIdentifier isEqualToString:leftIdentifier]) {
        toolbarItem = [self setToolbarItem:@"left"
                                     label:@"left"
                              paletteLable:@"left"
                                   toolTip:@"left tip"
                                     image:@"left"];
    } else if ([itemIdentifier isEqualToString:rightIdentifier]) {
        toolbarItem = [self setToolbarItem:@"right"
                                     label:@"right"
                              paletteLable:@"right"
                                   toolTip:@"right tip"
                                     image:@"right"];
    } else {
        return nil;
    }
    return toolbarItem;
}

- (NSToolbarItem *)setToolbarItem:(NSString *)identifier
                            label:(NSString *)label
                     paletteLable:(NSString *)paletteLable
                          toolTip:(NSString *)toolTip
                            image:(NSString *)image {
    NSToolbarItem *toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:identifier];
    toolbarItem.label = label;
    toolbarItem.paletteLabel = paletteLable;
    toolbarItem.toolTip = toolTip;
    toolbarItem.target = self;
    [toolbarItem setAction:@selector(itemClick:)];
    toolbarItem.image = [NSImage imageNamed:image];
    return toolbarItem;
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return @[NSToolbarSpaceItemIdentifier,
             leftIdentifier,
             rightIdentifier,
             NSToolbarSpaceItemIdentifier,
             NSToolbarShowColorsItemIdentifier];
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    return @[leftIdentifier,
             rightIdentifier,
             NSToolbarShowColorsItemIdentifier,
             NSToolbarSpaceItemIdentifier];
}

#pragma mark - Action
- (void)itemClick:(NSToolbarItem *)item {
    
}

@end
