#import "_DTCBook.h"

@interface DTCBook : _DTCBook {}


#pragma mark - Factory inits

+(instancetype) bookWithTitle:(NSString *)title
                      context:(NSManagedObjectContext *) context;

+(instancetype) bookWithDictionary: (NSDictionary *) dict
                           context:(NSManagedObjectContext *) context;


#pragma mark - Instance methods

-(NSString *) stringOfAuthors;
-(NSString *) stringOfTags;

@end
