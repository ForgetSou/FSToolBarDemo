//
//  NSView+Extension.h
//  FSToolBarDemo
//
//  Created by forget on 2020/11/10.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Extension)

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat x;

@property (assign, nonatomic) CGSize size;

@end

NS_ASSUME_NONNULL_END
