//
//  AppDelegate.m
//  FSToolBarDemo
//
//  Created by forget on 2020/10/29.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[NSApplication sharedApplication] setAutomaticCustomizeTouchBarMenuItemEnabled:YES];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
