//
//  ECNoteManager.h
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ECNote;

@interface ECNoteManager : NSObject

- (void)saveNote:(ECNote *)note;

@end
