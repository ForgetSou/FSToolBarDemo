//
//  FSCustomBtn.h
//  FSToolBarDemo
//
//  Created by forget on 2020/10/29.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    FSRectCornerTopLeft     = 1 << 0,
    FSRectCornerTopRight    = 1 << 1,
    FSRectCornerBottomLeft  = 1 << 2,
    FSRectCornerBottomRight = 1 << 3,
    FSRectCornerAllCorners  = ~0UL
} FSRectCorner;

typedef enum {
    FSTextAlignmentLeft  = 0, //左对齐
    FSTextAlignmentCenter,    //居中
    FSTextAlignmentRight      //右对齐
    
}FSTextAlignment;

typedef enum {
    FSTextUnderLineStyleNone  = 0,     //无下划线
    FSTextUnderLineStyleSingle,        //单下划线
    FSTextUnderLineStyleDouble,        //双下划线
    FSTextUnderLineStyleDeleteSingle,  //单删除线
    FSTextUnderLineStyleDeleteDouble   //双删除线
    
}FSTextUnderLineStyle;

@interface FSCustomBtn : NSView

@property (nullable, weak) id target;
@property (nullable) SEL action;

/// 当鼠标移动到控件时，是否显示"小手"
@property (assign, nonatomic) BOOL isHandCursor;

///圆角
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) FSRectCorner rectCorners;

///按钮文字
@property (nonatomic, nullable, strong) NSString *title;
@property (nonatomic, nullable, strong) NSString *selectedTitle;

///按钮文字对齐方式
@property (nonatomic, assign) FSTextAlignment textAlignment;

///按钮文字下划线样式
@property (nonatomic, assign) FSTextUnderLineStyle textUnderLineStyle;

///按钮文字颜色
@property (nonatomic, nullable, strong) NSColor *titleColor;
@property (nonatomic, nullable, strong) NSColor *selectedTitleColor;

///按钮字体
@property (nonatomic, nullable, strong) NSFont *font;
@property (nonatomic, nullable, strong) NSFont *selectedFont;

///当背景图片存在时，背景色无效
@property (nonatomic, nullable, strong) NSImage *backgroundImage;
@property (nonatomic, nullable, strong) NSImage *selectedBackgroundImage;

///当背景图片不存在时，显示背景色
@property (nonatomic, nullable, strong) NSColor *backgroundColor;
@property (nonatomic, nullable, strong) NSColor *selectedBackgroundColor;

@end

NS_ASSUME_NONNULL_END
