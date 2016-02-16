//
//  ECNote.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNote.h"

NSString *const kCreationDate = @"creationDate";
NSString *const kNoteText = @"noteText";


@interface ECNote ()

//@property (strong, nonatomic, readwrite) NSDate *creationDate;

@end

@implementation ECNote

- (NSDate *)creationDate {
    if (!_creationDate) {
        _creationDate = [NSDate date];
    }
    return _creationDate;
}

//- (void)encodeWithCoder:(NSCoder *)coder {
//    [coder encodeObject:self.creationDate forKey:kCreationDate];
//    [coder encodeObject:self.noteText forKey:kNoteText];
//}
//
//- (instancetype)initWithCoder:(NSCoder *)decoder {
//    if (self = [super init]) {
//        self.creationDate = [decoder decodeObjectForKey:kCreationDate];
//        self.noteText = [decoder decodeObjectForKey:kNoteText];
//    }
//    return self;
//}
@end
