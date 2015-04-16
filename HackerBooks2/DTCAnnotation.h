#import "_DTCAnnotation.h"
@class DTCBook;

@interface DTCAnnotation : _DTCAnnotation {}

#pragma mark - Factory init
+(instancetype) annotationWithName:(NSString *)name
                              book:(DTCBook *) book
                           context:(NSManagedObjectContext *) context;


@end
