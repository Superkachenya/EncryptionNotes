//
//  ECNoteViewController.h
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECNote, ECNoteViewController;

@protocol ECNoteDetailsDelegate <NSObject>

- (void)detailsViewController:(ECNoteViewController *)controller saveNote:(ECNote *)note;

@end

@interface ECNoteViewController : UIViewController

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) ECNote *currentNote;
@property (weak, nonatomic) id<ECNoteDetailsDelegate>delegate;

@end
