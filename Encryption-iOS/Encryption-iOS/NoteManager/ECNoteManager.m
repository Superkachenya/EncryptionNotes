//
//  ECNoteManager.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNoteManager.h"
#import "ECNote.h"

@implementation ECNoteManager

- (void)saveNote:(ECNote *)note {
    NSURL *documentsDirectoryPaths = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                            inDomains:NSUserDomainMask] lastObject];
}

@end
