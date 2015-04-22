#import "_DTCTag.h"
@class AGTCoreDataStack;

@interface DTCTag : _DTCTag{}

#pragma mark - Properties
// Transient property
@property (nonatomic, readonly) BOOL isFavorite;

#pragma mark - Factory init
+(instancetype) tagWithName:(NSString *) tagName
                      stack:(AGTCoreDataStack *) stack;

@end
