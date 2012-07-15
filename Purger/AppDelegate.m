//
//  AppDelegate.m
//  Purger
//
//  Created by Steve McKenzie on 12-07-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()


@property (nonatomic, strong) IBOutlet NSMenuItem *purgeItem;
@property (nonatomic, strong) IBOutlet NSMenuItem *quitItem;
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) IBOutlet NSMenu *statusMenu;


- (void)purgeAction;
- (void)quitAction;


@end


@implementation AppDelegate


@synthesize purgeItem = _purgeItem;
@synthesize quitItem = _quitItem;
@synthesize statusItem = _statusItem;
@synthesize statusMenu = _statusMenu;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.purgeItem.action = @selector(purgeAction);
  self.purgeItem.target = self;

  self.quitItem.action = @selector(quitAction);
  self.quitItem.target = self;
}


- (void)awakeFromNib {
  self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  self.statusItem.menu = self.statusMenu;
  self.statusItem.image = [NSImage imageNamed:@"Icon.png"];
  self.statusItem.highlightMode = YES;
}


- (void)purgeAction {
  NSLog(@"Purging memory...");

  NSPipe *pipe = [[NSPipe alloc] init];
  NSTask *task = [[NSTask alloc] init];
  task.launchPath = @"/usr/bin/purge";
  task.standardOutput = pipe;
  [task launch];

  NSLog(@"Memory purge complete.");
}


- (void)quitAction {
  NSLog(@"Purger go bye bye!");
  exit(0);
}


@end

