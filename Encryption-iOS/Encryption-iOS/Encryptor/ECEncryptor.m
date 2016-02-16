//
//  ECEncryptor.m
//  Encryption-iOS
//
//  Created by Danil on 16.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECEncryptor.h"

@implementation ECEncryptor

+ (NSString *)encryptMe:(NSString *)string withKey:(NSString *)key {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    char *dataPtr = (char *) [data bytes];
    char *keyData = (char *) [[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    char *keyPtr = keyData;
    int keyIndex = 0;
    for (int x = 0; x < [data length]; x++)
    {
        *dataPtr = *dataPtr ^ *keyPtr;
        dataPtr++;
        keyPtr++;
        if (++keyIndex == [key length])
            keyIndex = 0, keyPtr = keyData;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
