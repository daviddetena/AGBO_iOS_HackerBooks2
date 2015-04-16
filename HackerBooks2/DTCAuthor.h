#import "_DTCAuthor.h"

@interface DTCAuthor : _DTCAuthor {}

#pragma mark - Factory init
+(instancetype) authorWithName:(NSString *) name
                       context:(NSManagedObjectContext *) context;


@end
