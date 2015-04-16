//
//  DTCHelpers.h
//  HackerBooks2
//
//  Created by David de Tena on 15/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface DTCHelpers : NSObject

#pragma mark - Arrays and Strings

// Utility method to extract items from NSString with a separator and add them to an array
+(NSArray *) arrayOfItemsFromString:(NSString *) string
                        separatedBy:(NSString *) separator;

// Returns a string containing all the objects in the array, separated by a separator
+(NSString *) stringOfItemsFromArray:(NSArray *) anArray
                         separatedBy:(NSString *) separator;

+(NSString *) urlPathWithBackslashesDeletedFromPath: (NSURL *) aPath;

+(BOOL) existsItemFromClass:(id) nameClass
               withProperty:(NSString *) property
                  inContext:(NSManagedObjectContext *) context;

@end
