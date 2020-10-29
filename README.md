# NSToolBar

## 1 简述

工具栏，用于管理窗口标题栏下方和应用程序的自定义内容上方的空间，以快速访问应用程序功能。

## 2 源码注解

```objective-c
@interface NSToolbar : NSObject
```

### 2.1 **初始化创建**

```objective-c
- (instancetype)initWithIdentifier:(NSToolbarIdentifier)identifier NS_DESIGNATED_INITIALIZER;
- (instancetype)init API_AVAILABLE(macos(10.13));
```

### 2.2 **代理**

```objective-c
@property (nullable, weak) id<NSToolbarDelegate> delegate;

@protocol NSToolbarDelegate <NSObject>

@optional
- (nullable NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag;
// 返回默认情况下在工具栏中显示的项目的有序列表。
- (NSArray<NSToolbarItemIdentifier> *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar;
// 按标识符返回所有允许项的列表。
- (NSArray<NSToolbarItemIdentifier> *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar;

@optional

- (NSArray<NSToolbarItemIdentifier> *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar;

- (void)toolbarWillAddItem:(NSNotification *)notification;

- (void)toolbarDidRemoveItem:(NSNotification *)notification;
```

### 2.3 **属性**

```objective-c
// 接收者的标识符
@property (readonly, copy) NSToolbarIdentifier identifier;
// 工具类显示模式
@property NSToolbarDisplayMode displayMode;
typedef NS_ENUM(NSUInteger, NSToolbarDisplayMode) {
    NSToolbarDisplayModeDefault,
    NSToolbarDisplayModeIconAndLabel,
    NSToolbarDisplayModeIconOnly,
    NSToolbarDisplayModeLabelOnly
} API_AVAILABLE(ios(13.0));
// 是否显示工具栏和主窗口内容之间的分割线
@property BOOL showsBaselineSeparator;
// 是否允许用户修改工具栏
@property BOOL allowsUserCustomization;
// 是否为拓展添加item
@property BOOL allowsExtensionItems API_AVAILABLE(macos(10.10)) API_UNAVAILABLE(ios);
// item数组
@property (readonly, copy) NSArray<__kindof NSToolbarItem *> *items;
// 可见的item数组
@property (nullable, readonly, copy) NSArray<__kindof NSToolbarItem *> *visibleItems;
// 尺寸模式
@property NSToolbarSizeMode sizeMode API_UNAVAILABLE(ios);
typedef NS_ENUM(NSUInteger, NSToolbarSizeMode) {
    NSToolbarSizeModeDefault,
    NSToolbarSizeModeRegular,
    NSToolbarSizeModeSmall
};
```

### 2.4 **管理item**

```objective-c
// 添加指定的item到索引处
- (void)insertItemWithItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier atIndex:(NSInteger)index;
// 删除item
- (void)removeItemAtIndex:(NSInteger)index;
```

## 3 重点解析

### 3.1 **sizeMode**

设置工具栏图标大小

- NSToolbarSizeModeDefault // 默认大小
- NSToolbarSizeModeRegular // 常规尺寸 32*32像素
- NSToolbarSizeModeSmall // 小尺寸24*24像素

```objective-c
[toolBar setSizeMode:NSToolbarSizeModeSmall];

NSToolbar *toolBar = [[NSToolbar alloc] initWithIdentifier:@"toolBar"];
    [self.view.window setToolbar:toolBar];
    switch (toolBar.sizeMode) {
        case NSToolbarSizeModeDefault:
            
            break;
        case NSToolbarSizeModeRegular:
            
            break;
        case NSToolbarSizeModeSmall:
            
            break;
            
        default:
            break;
    }
```

### 3.2 **displayMode**

设置工具栏显示模式

- NSToolbarDisplayModeDefault // 默认
- NSToolbarDisplayModeIconAndLabel // 显示图标和标签
- NSToolbarDisplayModeIconOnly // 只显示图标
- NSToolbarDisplayModeLabelOnly // 只显示标签

```objective-c
[toolBar setDisplayMode:NSToolbarDisplayModeIconOnly];
```

## 4 示例

### 4.1 代码

1. 创建继承`NSWindowController`的窗口控制器FSWindowCtl，并在Main.storyboard中修改为FSWindowCtl，如下图

   ![image-20201029120715448](https://tva1.sinaimg.cn/large/0081Kckwly1gk62qi6od1j30t10gn0uj.jpg)

2. 在`FSWindowCtl`添加`item`标识符

   ```objective-c
   static NSToolbarItemIdentifier leftIdentifier = @"left";
   static NSToolbarItemIdentifier rightIdentifier = @"right";
   ```

3. `windowDidLoad`中添加并设置`NSToolBar`

   ```objective-c
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
   ```

4. 实现toolbar的代理方法

   ```objective-c
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
   ```

### 4.2 storyboard

直接在storyboard拖拽NSToolbarItem，并添加即可，不再详述。

![image-20201029121653274](https://tva1.sinaimg.cn/large/0081Kckwly1gk630gzcbqj30f40bddgj.jpg)

---

[FSToolbarDemo](