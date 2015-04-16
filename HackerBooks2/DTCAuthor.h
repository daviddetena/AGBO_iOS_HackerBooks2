#import "_DTCAuthor.h"
@class AGTCoreDataStack;

@interface DTCAuthor : _DTCAuthor {}

#pragma mark - Factory init
+(instancetype) authorWithName:(NSString *) name
                         stack:(AGTCoreDataStack *) stack;


@end
