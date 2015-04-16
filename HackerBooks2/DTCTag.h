#import "_DTCTag.h"
@class AGTCoreDataStack;

@interface DTCTag : _DTCTag {}

#pragma mark - Factory init

+(instancetype) tagWithName:(NSString *) name
                      stack:(AGTCoreDataStack *) stack;


-(NSString *) stringOfBooks;

@end
