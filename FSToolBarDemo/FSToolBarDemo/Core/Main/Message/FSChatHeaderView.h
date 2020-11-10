//
//  FSChatHeaderView.h
//  FSToolBarDemo
//
//  Created by forget on 2020/11/10.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSChatHeaderView : NSView

@property (strong, nonatomic) NSString *header;
@property (copy, nonatomic) void(^headerClick)(void);

@end

NS_ASSUME_NONNULL_END
