
@import <Foundation/CPObject.j>
@import <CPVideoKit/CPVideoView.j>

@implementation VimeoWindowController : CPObject
{
    @outlet CPView view;
    CPVideoView videoView;
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

    CPArray demoVideoTitles;
    CPArray demoVideoIDs;
}

- (void)setup
{

    demoVideoTitles = ["Keyboard Cat", "3 Wolf Moon", "CPTableView"];
    demoVideoIDs = ["5503845", "5874017", "7396399"];

    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    videoView = [[CPVideoView alloc] initWithFrame:[view frame] service:CPVideoKitServiceVimeo];
    [videoView setAutoresizingMask:CPViewHeightSizable | CPViewWidthSizable];

    [view addSubview:videoView];

    [videoView addObserver:self
                forKeyPath:@"player.duration"
                   options:(CPKeyValueObservingOptionNew)
                   context:NULL];
    [videoView addObserver:self
                forKeyPath:@"player.currentTime"
                   options:(CPKeyValueObservingOptionNew)
                   context:NULL];

    [videosPopUpButton removeAllItems];
    [videosPopUpButton addItemsWithTitles:demoVideoTitles];
}

// KVO change notification
- (void)observeValueForKeyPath:(CPString)keyPath
                      ofObject:(id)object
                        change:(CPDictionary)change
                       context:(void)context
{
    if ([keyPath isEqual:@"player.duration"]) 
    {
        [durationLabel setStringValue:[[videoView player] duration]];
        [durationLabel setNeedsDisplay:YES];
    } 
    else if ([keyPath isEqual:@"player.currentTime"]) 
    {
        [currentTimeLabel setStringValue:[[videoView player] currentTime]];
        [currentTimeLabel setNeedsDisplay:YES];
    } 
}
    
- (IBAction)play:(id)sender
{
    [videoView play:self];
}

- (IBAction)pause:(id)sender
{
    [videoView pause:self];
}

- (IBAction)stop:(id)sender
{
    [videoView stop:self];
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
    [videoView loadVideo:[demoVideoIDs objectAtIndex:[videosPopUpButton indexOfSelectedItem]]];
}

@end
