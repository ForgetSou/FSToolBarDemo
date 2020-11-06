//
//  FSTabbarBtn.h
//  FSToolBarDemo
//
//  Created by forget on 2020/11/2.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSTabbarBtn : NSButton

//是否被选中
@property (nonatomic,assign) BOOL selected;

//两种状态的图片名称
@property (copy,nonatomic) NSString *downImageName;

@property (copy,nonatomic) NSString *normalImageName;

@end

NS_ASSUME_NONNULL_END
