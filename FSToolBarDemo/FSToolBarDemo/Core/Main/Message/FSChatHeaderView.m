//
//  FSChatHeaderView.m
//  FSToolBarDemo
//
//  Created by forget on 2020/11/10.
//

#import "FSChatHeaderView.h"

@implementation FSChatHeaderView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    self.wantsLayer = YES;
    self.layer.backgroundColor = NSColor.redColor.CGColor;
    [self addGestureRecognizer:[[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)]];
}

- (void)setHeader:(NSString *)header {
    _header = header;
    
    
}

- (void)headClick {
    if (self.headerClick) {
        self.headerClick();
    }
}


@end
