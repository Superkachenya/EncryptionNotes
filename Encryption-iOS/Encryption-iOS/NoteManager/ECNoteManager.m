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

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

+ (void)saveNote:(ECNote *)note {
    NSString *path = [[self applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:@".txt"];
    [NSKeyedArchiver archiveRootObject:note toFile:path];
}

+ (ECNote *)loadNote {
    ECNote *loadedNote = nil;
    NSString *filePath = [[self applicationDocumentsDirectory].path
                          stringByAppendingPathComponent:@"note"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        loadedNote = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return loadedNote;
}
@end
