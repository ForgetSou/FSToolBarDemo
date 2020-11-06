//
//  FSTabbarView.h
//  FSToolBarDemo
//
//  Created by forget on 2020/11/2.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSTabbarView : NSView

@property (copy, nonatomic) void(^tabbarClickBlock)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
