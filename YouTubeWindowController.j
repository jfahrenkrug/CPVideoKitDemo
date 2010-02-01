
@import <Foundation/CPObject.j>

@implementation YouTubeWindowController : CPObject
{
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

- (void)setup
{

    demoVideoTitles = ["Keyboard Cat", "Dance, Monkeyboy", "Mr. W", "Born to be alive", "Commodores - Brick House", "Al Green - Sha La La"];
    demoVideoIDs = ["J---aiyznGQ", "wvsboPUjrGc", "2mTLO2F_ERY", "BVgM7qeAlko", "-5EmnQp3V48", "sjBChRG-nok"];

    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    console.log("blaaaa");

    [videoView addObserver:self
                forKeyPath:@"player.duration"
                   options:(CPKeyValueObservingOptionNew)
                   context:NULL];
    [videoView addObserver:self
                forKeyPath:@"player.currentTime"
                   options:(CPKeyValueObservingOptionNew)
                   context:NULL];
    [videoView addObserver:self
                forKeyPath:@"player.percentageLoaded"
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
    else if ([keyPath isEqual:@"player.percentageLoaded"]) 
    {
        [percentLoadedLabel setStringValue:[[videoView player] percentageLoaded].toFixed(2) + "%"];
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

@end
