//
//  DTCCoreDataQueries.m
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCCoreDataQueries.h"
#import "AGTCoreDataStack.h"

@implementation DTCCoreDataQueries

#pragma mark - Factory methods

// Method with the objects matching a request
+(NSArray *) resultsFromFetchForEntityName:(NSString *) entityName
                                  sortedBy:(NSString *) sortingField
                                 ascending:(BOOL) ascending
                                   inStack:(AGTCoreDataStack *) stack{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityName];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortingField
                                                          ascending:ascending
                                                           selector:@selector(caseInsensitiveCompare:)]];
    
    NSArray *results = [stack executeFetchRequest:req errorBlock:^(NSError *error) {
        NSLog(@"Error %@", error.localizedDescription);
    }];
    
    return results;
}

// Method with the objects matching a request with predicate
+(NSArray *) resultsFromFetchForEntityName:(NSString *) entityName
                                  sortedBy:(NSString *) sortingField
                                 ascending:(BOOL) ascending
                             withPredicate:(NSPredicate *) predicate
                                   inStack:(AGTCoreDataStack *) stack{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entityName];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortingField
                                                          ascending:ascending
                                                           selector:@selector(caseInsensitiveCompare:)]];
    req.predicate = predicate;
    
    NSArray *results = [stack executeFetchRequest:req errorBlock:^(NSError *error) {
        NSLog(@"Error %@", error.localizedDescription);
    }];
    
    return results;
}


@end
