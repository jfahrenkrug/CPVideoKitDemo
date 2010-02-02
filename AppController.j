/*
 * AppController.j
 * CPVideoKitDemo
 *
 * Created by Johannes Fahrenkrug on January 25, 2010.
 * Copyright 2010, Springenwerk All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <CPVideoKit/CPVideoKit.j>
@import "YouTubeWindowController.j"
@import "VimeoWindowController.j"


@implementation AppController : CPObject
{
    @outlet CPWindow    youTubeWindow;
    @outlet CPWindow    vimeoWindow;
    @outlet YouTubeWindowController youTubeWindowController;
    @outlet VimeoWindowController vimeoWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    [youTubeWindow setFrameOrigin:CGPointMake(5.0, 35.0)];
    [vimeoWindow setFrameOrigin:CGPointMake(205.0, 35.0)];
    // This is called when the application is done loading.
    [youTubeWindowController setup];
    [vimeoWindowController setup];
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things. 
}

@end
