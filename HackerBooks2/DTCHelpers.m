//
//  DTCHelpers.m
//  HackerBooks2
//
//  Created by David de Tena on 15/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCHelpers.h"

@implementation DTCHelpers

#pragma mark - Utils

// Utility method to extrac authors/tags from NSString and add to an array
+(NSArray *) arrayOfItemsFromString:(NSString *)string
                        separatedBy:(NSString *) separator{
    NSArray *arrayStrings = [string componentsSeparatedByString:separator];
    return arrayStrings;
}

// Returns a string containing all the objects in the array, separated by comma
+(NSString *) stringOfItemsFromArray:(NSArray *) anArray
                         separatedBy:(NSString *) separator{
    NSString *string = @"";
    for (NSString *str in anArray) {
        string = [string stringByAppendingString:str];
        string = [string stringByAppendingString:separator];
    }
    NSString *stringOfItems = [string substringWithRange:NSMakeRange(0,[string length]-2)];
    return stringOfItems;
}

+(NSString *) urlPathWithBackslashesDeletedFromPath: (NSURL *) aPath{
    // Clean slashes from remote url filepath
    NSMutableString *path = [NSMutableString stringWithString:[aPath absoluteString]];
    NSString *clearPath = [path stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return clearPath;
}

@end
