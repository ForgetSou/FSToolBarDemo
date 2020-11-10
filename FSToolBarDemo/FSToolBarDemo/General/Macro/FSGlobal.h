//
//  FSGlobal.h
//  FSToolBarDemo
//
//  Created by forget on 2020/11/10.
//

#ifndef FSGlobal_h
#define FSGlobal_h

#pragma mark - 色值
#define RGBA(r,g,b,a)                       [NSColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
#define RGB(r,g,b)                          [NSColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]


#pragma mark - 判空
#define kStringIsEmpty(string)              (string == NULL || [string isKindOfClass:[NSNull class]] || string == nil || [string length] < 1)
#define kArrayIsEmpty(array)                (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define kDictionaryIsEmpty(dictionary)      (dictionary == nil || [dictionary isKindOfClass:[NSNull class]] || dictionary.allKeys.count == 0)
#define kObjectIsEmpty(object)              (object == nil||[object isKindOfClass:[NSNull class]]||([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0)|| ([object respondsToSelector:@selector(count)] && [(NSArray *)object count] == 0))

#pragma mark - 注册Nib
#define kRegisterNibCollectionView(collectionView, cell, indetifier)    [collectionView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([cell class]) bundle:nil] forItemWithIdentifier:indetifier]
#define kRegisterNibTableView(tableView, cell, indetifier)              [tableView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([cell class]) bundle:nil] forCellReuseIdentifier:indetifier]


#pragma mark - 强弱引用
// 推荐使用（摘自YYKit）
/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#ifdef DEBUG
#define NSLog(format,...) printf("\n[%s] %s [第%d行] %s\n",__TIME__,__FUNCTION__,__LINE__,[[NSString stringWithFormat:format,## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif


#endif /* FSGlobal_h */
