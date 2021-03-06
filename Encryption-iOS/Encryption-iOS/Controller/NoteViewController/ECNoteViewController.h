//
//  ECNoteViewController.h
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ECNote;

typedef void(^SavedNote)(ECNote *note);

@interface ECNoteViewController : UIViewController

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) ECNote *currentNote;
@property (copy, nonatomic) SavedNote newNote;


@end
