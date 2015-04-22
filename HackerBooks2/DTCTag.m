#import "DTCTag.h"
#import "DTCBook.h"
#import "AGTCoreDataStack.h"

#define FAVORITE @"Favorite"

@import CoreData;


@implementation DTCTag

#pragma mark - Properties
// Inherited from base class
+(NSArray *) observableKeys{
    // Observo propiedades
    return @[DTCTagAttributes.name,DTCTagRelationships.books];
}

-(BOOL) isFavorite{
    if ([self.name isEqualToString:FAVORITE]) {
        return YES;
    }
    return NO;
}


#pragma mark - Factory init

+(instancetype) tagWithName:(NSString *) tagName
                      stack:(AGTCoreDataStack *) stack{

    DTCTag *tag = [NSEntityDescription insertNewObjectForEntityForName:[DTCTag entityName]
                                                inManagedObjectContext:stack.context];
    tag.name = tagName;
    return tag;
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Con cualquier cambio en las propiedades observables    
}

@end
