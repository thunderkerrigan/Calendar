//
//  FilmShowView.h
//  Calendar
//
//  Created by Joseph on 14/09/2015.
//  Copyright © 2015 ADDE. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MovieShowView : NSView{
    IBOutlet NSButton *ingestButton;
    IBOutlet NSButton *KDMButton;
    IBOutlet NSView *firstPartView;
    IBOutlet NSView *CPLView;
    IBOutlet NSTextField *titleLabel;
    IBOutlet NSTextField *dateShowLabel;
    IBOutlet NSTextField *movieLengthLabel;
    IBOutlet NSButton *lockShowButton;
}

@end
