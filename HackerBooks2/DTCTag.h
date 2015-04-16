#import "_DTCTag.h"

@interface DTCTag : _DTCTag {}

#pragma mark - Factory init

//+(instancetype) tagWithName:(NSString *) name;
+(instancetype) tagWithName:(NSString *) name
                    context:(NSManagedObjectContext *) context;

@end
