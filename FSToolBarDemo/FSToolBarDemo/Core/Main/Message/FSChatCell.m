//
//  FSChatCell.m
//  FSToolBarDemo
//
//  Created by forget on 2020/11/9.
//

#import "FSChatCell.h"

@interface FSChatCell ()

@property (weak) IBOutlet NSTextField *nameLab;

@end

@implementation FSChatCell

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
}

- (void)setName:(NSString *)name {
    _name = name;
    
    self.nameLab.stringValue = name;
}

- (void)setSelected:(BOOL)selected {
    super.selected = selected;
    [self changeBgViewColor];
}

- (void)changeBgViewColor {
    if (self.selected) {
        if (self.highlightState == NSCollectionViewItemHighlightForSelection) {
            self.view.layer.backgroundColor = NSColor.lightGrayColor.CGColor;
        } else if (self.highlightState == NSCollectionViewItemHighlightNone ||
                   self.highlightState == NSCollectionViewItemHighlightForDeselection) {
            self.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
        }
    } else {
        self.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
    }
}

@end
