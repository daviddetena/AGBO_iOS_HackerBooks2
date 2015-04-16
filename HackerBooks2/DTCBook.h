#import "_DTCBook.h"
@class AGTCoreDataStack;

@interface DTCBook : _DTCBook {}


#pragma mark - Factory inits
+(instancetype) bookWithDictionary:(NSDictionary *) dict
                             stack:(AGTCoreDataStack *) stack;


#pragma mark - Instance methods

-(NSString *) stringOfAuthors;
-(NSString *) stringOfTags;

@end
