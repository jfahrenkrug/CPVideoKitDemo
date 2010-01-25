/*
 * AppController.j
 * CPVideoKitDemo
 *
 * Created by Johannes Fahrenkrug on January 25, 2010.
 * Copyright 2010, Springenwerk All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <CPVideoKit/CPVideoKit.j>


@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPVideoView videoView;
    @outlet CPButton playButton;
    @outlet CPButton pauseButton;
    @outlet CPButton stopButton;
    @outlet CPCheckBox muteCheckBox;
    @outlet CPSlider volumeSlider;
    @outlet CPTextField seekTextField;
    @outlet CPTextField startSecondsTextField;
    @outlet CPPopUpButton videosPopUpButton;
    @outlet CPTextField durationLabel;
    @outlet CPTextField currentTimeLabel;
    @outlet CPTextField percentLoadedLabel;

    CPArray demoVideoTitles;
    CPArray demoVideoIDs;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    [videoView addObserver:self
                forKeyPath:@"duration"
                   options:(CPKeyValueObservingOptionNew)
                   context:NULL];
    [videoView addObserver:self
                forKeyPath:@"currentTime"
                   options:(CPKeyValueObservingOptionNew)
                   context:NULL];
    [videoView addObserver:self
                forKeyPath:@"percentageLoaded"
                   options:(CPKeyValueObservingOptionNew)
                   context:NULL];
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.
    demoVideoTitles = ["Keyboard Cat", "Dance, Monkeyboy", "Mr. W", "Born to be alive", "Commodores - Brick House", "Al Green - Sha La La"];
    demoVideoIDs = ["J---aiyznGQ", "wvsboPUjrGc", "2mTLO2F_ERY", "BVgM7qeAlko", "-5EmnQp3V48", "sjBChRG-nok"];

    [theWindow setFrameOrigin:CGPointMake(5.0, 35.0)]; 
    [videosPopUpButton removeAllItems];
    [videosPopUpButton addItemsWithTitles:demoVideoTitles];
}

// KVO change notification
- (void)observeValueForKeyPath:(CPString)keyPath
                      ofObject:(id)object
                        change:(CPDictionary)change
                       context:(void)context
{
    if ([keyPath isEqual:@"duration"]) 
    {
        [durationLabel setStringValue:[videoView duration]];
        [durationLabel setNeedsDisplay:YES];
    } 
    else if ([keyPath isEqual:@"currentTime"]) 
    {
        [currentTimeLabel setStringValue:[videoView currentTime]];
        [currentTimeLabel setNeedsDisplay:YES];
    } 
    else if ([keyPath isEqual:@"percentageLoaded"]) 
    {
        [percentLoadedLabel setStringValue:[videoView percentageLoaded].toFixed(2) + "%"];
    }
}
    


- (IBAction)toggleMute:(id)sender
{
    [videoView setMuted:([sender state] == CPOnState)];
}

- (IBAction)changeVolume:(id)sender
{
    [videoView setVolume:[sender intValue]];
}

- (IBAction)seek:(id)sender
{
    [videoView seekTo:[[seekTextField stringValue] intValue]];
}

- (IBAction)loadVideo:(id)sender
{
    [videoView loadVideo:[demoVideoIDs objectAtIndex:[videosPopUpButton indexOfSelectedItem]] startSeconds:[[startSecondsTextField stringValue] intValue]];
}

- (IBAction)queueVideo:(id)sender
{
    [videoView cueVideo:[demoVideoIDs objectAtIndex:[videosPopUpButton indexOfSelectedItem]] startSeconds:[[startSecondsTextField stringValue] intValue]];
}
@end
