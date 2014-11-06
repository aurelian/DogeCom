//
//  DogePreferencesController.m
//  DogeCom
//
//  Created by Aurelian Oancea on 28/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import "DogePreferencesController.h"

@implementation DogePreferencesController

@synthesize sendNotificationCheckbox;
@synthesize duplicateFileCheckbox;
@synthesize duplicateDestination;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    
    return self;
}

/*
- (void)windowDidLoad {
    NSLog(@"---> window loaded");
    
    [super windowDidLoad];
}
*/

-(void) awakeFromNib {
    NSLog(@"---> awake from nib");
    
    [self.sendNotificationCheckbox
            setState:[[NSUserDefaults standardUserDefaults] boolForKey:@"SendNotification" ]];
    
    [self.duplicateFileCheckbox
            setState:[[NSUserDefaults standardUserDefaults] boolForKey:@"DuplicateFile" ]];
    
    [self.duplicateDestination setStringValue:@"Hello!"]; // NOO
}

-(IBAction) toggleSendNotification:(id)sender {
    [[NSUserDefaults standardUserDefaults]
            setBool:[self.sendNotificationCheckbox state] forKey:@"SendNotification" ];
}

-(IBAction) toggleDuplicateFile:(id)sender {
    [[NSUserDefaults standardUserDefaults]
     setBool:[self.duplicateFileCheckbox state] forKey:@"DuplicateFile" ];
}

-(IBAction) selectDupicateDestination:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:YES];
    [panel setAllowsMultipleSelection:NO];
    [panel setPrompt:@"Select"];

    if ([panel runModal] == NSModalResponseOK) {
        NSURL* url = [panel URL];
        NSLog(@"url: %@",url);
    }
}

@end
