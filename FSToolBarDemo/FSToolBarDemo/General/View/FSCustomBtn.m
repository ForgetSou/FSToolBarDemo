//
//  FSCustomBtn.m
//  FSToolBarDemo
//
//  Created by forget on 2020/10/29.
//

#import "FSCustomBtn.h"
#import <objc/message.h>

#define FSMsgSend(...)       ((void (*)(void *, SEL, id))objc_msgSend)(__VA_ARGS__)
#define FSMsgTarget(target)  (__bridge void *)(target)
@interface FSCustomBtn () {
    NSTrackingArea *_trackingArea;
}

@property (nonatomic,assign) BOOL mouseDown;

@end

@implementation FSCustomBtn

- (void)setMouseDown:(BOOL)mouseDown {
    if (_mouseDown == mouseDown) return;
    
    _mouseDown = mouseDown;
    [self setNeedsDisplay];
}

///圆角
- (void)setRectCorners:(FSRectCorner)rectCorners {
    if (_rectCorners == rectCorners) return;
    
    _rectCorners = rectCorners;
    [self setNeedsDisplay];
}

///半径
- (void)setRadius:(CGFloat)radius {
    if (_radius == radius) return;
    
    _radius = radius;
    [self setNeedsDisplay];
}

///按钮文字
- (void)setTitle:(NSString *)title {
    if ([_title isEqualToString:title]) return;
    _title = title;
    [self setNeedsDisplay];
}

- (void)setSelectedTitle:(NSString *)selectedTitle {
    if ([_selectedTitle isEqualToString:selectedTitle]) return;
    _selectedTitle = selectedTitle;
    [self setNeedsDisplay];
}

///按钮文字对齐方式
- (void)setTextAlignment:(FSTextAlignment)textAlignment {
    if (_textAlignment == textAlignment) return;
    _textAlignment = textAlignment;
    [self setNeedsDisplay];
}

///按钮文字下划线样式
- (void)setTextUnderLineStyle:(FSTextUnderLineStyle)textUnderLineStyle {
    if (_textUnderLineStyle == textUnderLineStyle) return;
    _textUnderLineStyle = textUnderLineStyle;
    [self setNeedsDisplay];
}

///按钮文字颜色
- (void)setTitleColor:(NSColor *)titleColor {
    if (_titleColor == titleColor) return;
    _titleColor = titleColor;
    [self setNeedsDisplay];
}

- (void)setSelectedTitleColor:(NSColor *)selectedTitleColor {
    if (_selectedTitleColor == selectedTitleColor) return;
    _selectedTitleColor = selectedTitleColor;
    [self setNeedsDisplay];
}

///按钮字体
- (void)setFont:(NSFont *)font {
    if (_font == font) return;
    _font = font;
    [self setNeedsDisplay];
}

- (void)setSelectedFont:(NSFont *)selectedFont {
    if (_selectedFont == selectedFont) return;
    _selectedFont = selectedFont;
    [self setNeedsDisplay];
}

///当背景图片存在时，背景色无效
- (void)setBackgroundImage:(NSImage *)backgroundImage {
    if (_backgroundImage == backgroundImage) return;
    _backgroundImage = backgroundImage;
    [self setNeedsDisplay];
}

- (void)setSelectedBackgroundImage:(NSImage *)selectedBackgroundImage {
    if (_selectedBackgroundImage == selectedBackgroundImage) return;
    _selectedBackgroundImage = selectedBackgroundImage;
    [self setNeedsDisplay];
}

///当背景图片不存在时，显示背景色
- (void)setBackgroundColor:(NSColor *)backgroundColor {
    if (_backgroundColor == backgroundColor) return;
    _backgroundColor = backgroundColor;
    [self setNeedsDisplay];
}

- (void)setSelectedBackgroundColor:(NSColor *)selectedBackgroundColor {
    if (_selectedBackgroundColor == selectedBackgroundColor) return;
    _selectedBackgroundColor = selectedBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setNeedsDisplay {
    if (self.superview) {
        [self setNeedsDisplay:YES];
    }
}

-(void)updateTrackingAreas {
    if (_trackingArea == nil) {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                     options:NSTrackingMouseEnteredAndExited|NSTrackingActiveInKeyWindow
                                                       owner:self
                                                    userInfo:nil];
        [self addTrackingArea:_trackingArea];
    }
}

-(void)mouseEntered:(NSEvent *)theEvent{
    if (_isHandCursor == NO) return;
    [[NSCursor pointingHandCursor] set];
}

-(void)mouseExited:(NSEvent *)theEvent{
    if (_isHandCursor == NO) return;
    [[NSCursor arrowCursor] set];
}

- (void)mouseDown:(NSEvent *)event {
    NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
    if (CGRectContainsPoint(self.bounds, point)) {
        self.mouseDown = YES;
    }
}

- (void)mouseUp:(NSEvent *)event {
    if (self.mouseDown) {
        self.mouseDown = NO;
        [self setNeedsDisplay:YES];
        
        NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
        if (CGRectContainsPoint(self.bounds, point)) {
            
            if (self.target && self.action && [self.target respondsToSelector:self.action]) {
                FSMsgSend(FSMsgTarget(self.target), self.action, self);
            }
        }
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    
    NSString *title      = nil;
    NSFont   *font       = nil;
    NSColor  *titleColor = nil;
    NSColor  *backgroundColor = nil;
    NSImage  *backgroundImage = nil;
    
    if (self.mouseDown) {
        title = self.selectedTitle;
        font  = self.selectedFont;
        titleColor = self.selectedTitleColor;
        backgroundColor = self.selectedBackgroundColor;
        backgroundImage = self.selectedBackgroundImage;
        
        if (title == nil) {
            title = self.title;
        }
        if (font == nil) {
            font  = self.font;
        }
        if (titleColor == nil) {
            titleColor = self.titleColor;
        }
        if (backgroundColor == nil) {
            backgroundColor = self.backgroundColor;
        }
        if (backgroundImage == nil) {
            backgroundImage = self.backgroundImage;
        }
    }
    else {
        title = self.title;
        font  = self.font;
        titleColor = self.titleColor;
        backgroundColor = self.backgroundColor;
        backgroundImage = self.backgroundImage;
    }
    
    if (title == nil) {
        title = @"按钮";
    }
    if (font == nil) {
        font = [NSFont systemFontOfSize:17];
    }
    if (titleColor == nil) {
        titleColor = [NSColor blackColor];
    }
    if (backgroundImage) {
        backgroundColor = [NSColor colorWithPatternImage:backgroundImage];
    }
    else {
        if (backgroundColor == nil) {
            backgroundColor = [NSColor clearColor];
        }
    }
    
    if (_rectCorners) {
        NSBezierPath *bezierPath;
        if (_rectCorners == FSRectCornerAllCorners) {
            bezierPath = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:_radius yRadius:_radius];
        }
        else {
            bezierPath = [NSBezierPath bezierPath];
            
            CGFloat topRightRadius = 0.0, topLeftRadius = 0.0, bottomLeftRadius = 0.0, bottomRightRadius = 0.0;
            
            if (_rectCorners & FSRectCornerTopRight) {
                topRightRadius = _radius;
            }
            if (_rectCorners & FSRectCornerTopLeft) {
                topLeftRadius = _radius;
            }
            if (_rectCorners & FSRectCornerBottomLeft) {
                bottomLeftRadius = _radius;
            }
            if (_rectCorners & FSRectCornerBottomRight) {
                bottomRightRadius = _radius;
            }
            
            //右上
            CGPoint topRightPoint = CGPointMake(dirtyRect.origin.x+dirtyRect.size.width, dirtyRect.origin.y+dirtyRect.size.height);
            topRightPoint.x -= topRightRadius;
            topRightPoint.y -= topRightRadius;
            [bezierPath appendBezierPathWithArcWithCenter:topRightPoint radius:topRightRadius startAngle:0 endAngle:90];
            
            //左上
            CGPoint topLeftPoint = CGPointMake(dirtyRect.origin.x, dirtyRect.origin.y+dirtyRect.size.height);
            topLeftPoint.x += topLeftRadius;
            topLeftPoint.y -= topLeftRadius;
            [bezierPath appendBezierPathWithArcWithCenter:topLeftPoint radius:topLeftRadius startAngle:90 endAngle:180];
            
            //左下
            CGPoint bottomLeftPoint = dirtyRect.origin;
            bottomLeftPoint.x += bottomLeftRadius;
            bottomLeftPoint.y += bottomLeftRadius;
            [bezierPath appendBezierPathWithArcWithCenter:bottomLeftPoint radius:bottomLeftRadius startAngle:180 endAngle:270];
            
            //右下
            CGPoint bottomRightPoint = CGPointMake(dirtyRect.origin.x+dirtyRect.size.width, dirtyRect.origin.y);
            bottomRightPoint.x -= bottomRightRadius;
            bottomRightPoint.y += bottomRightRadius;
            [bezierPath appendBezierPathWithArcWithCenter:bottomRightPoint radius:bottomRightRadius startAngle:270 endAngle:360];
        }
        [backgroundColor setFill];
        [bezierPath fill];
    }
    else {
        [backgroundColor setFill];
        NSRectFill(dirtyRect);
    }
    
    if (title) {
        
        //绘制文字
        NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = 1;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                     NSForegroundColorAttributeName:titleColor};
        
        [attTitle addAttributes:attributes range:NSMakeRange(0, attTitle.length)];
        
        if (self.textUnderLineStyle == FSTextUnderLineStyleSingle) {
            NSUnderlineStyle style = NSUnderlineStyleSingle;
            [attTitle addAttributes:@{NSUnderlineStyleAttributeName:@(style)} range:NSMakeRange(0, attTitle.length)];
            [attTitle addAttributes:@{NSUnderlineColorAttributeName:titleColor} range:NSMakeRange(0, attTitle.length)];
        }
        else if (self.textUnderLineStyle == FSTextUnderLineStyleDouble) {
            NSUnderlineStyle style = NSUnderlineStyleDouble;
            [attTitle addAttributes:@{NSUnderlineStyleAttributeName:@(style)} range:NSMakeRange(0, attTitle.length)];
            [attTitle addAttributes:@{NSUnderlineColorAttributeName:titleColor} range:NSMakeRange(0, attTitle.length)];
        }
        else if (self.textUnderLineStyle == FSTextUnderLineStyleDeleteSingle) {
            [attTitle addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle),
                                      NSStrikethroughColorAttributeName:titleColor}
                          range:NSMakeRange(0, attTitle.length)];
        }
        else if (self.textUnderLineStyle == FSTextUnderLineStyleDeleteDouble) {
            [attTitle addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleDouble),
                                      NSStrikethroughColorAttributeName:titleColor}
                              range:NSMakeRange(0, attTitle.length)];
        }
        
        CGSize titleSize = [attTitle.string boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        CGRect titleRect;
        if (self.textAlignment == FSTextAlignmentLeft) {
            titleRect = CGRectMake(0,
                                   (self.bounds.size.height-titleSize.height)/2.0,
                                   titleSize.width,
                                   titleSize.height);
        }
        else if (self.textAlignment == FSTextAlignmentCenter) {
            titleRect = CGRectMake((self.bounds.size.width-titleSize.width)/2.0,
                                   (self.bounds.size.height-titleSize.height)/2.0,
                                   titleSize.width,
                                   titleSize.height);
        }
        else {
            titleRect = CGRectMake((self.bounds.size.width-titleSize.width),
                                   (self.bounds.size.height-titleSize.height)/2.0,
                                   titleSize.width,
                                   titleSize.height);
        }
        [attTitle drawInRect:titleRect];
    }
}

- (void)removeFromSuperview {
    if (_trackingArea) {
        [self removeTrackingArea:_trackingArea];
    }
    [super removeFromSuperview];
}

@end
