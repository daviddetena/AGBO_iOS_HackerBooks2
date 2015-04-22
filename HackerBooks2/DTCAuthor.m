#import "DTCAuthor.h"
#import "AGTCoreDataStack.h"

@interface DTCAuthor ()

// Private interface goes here.

@end

@implementation DTCAuthor

#pragma mark - Properties inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[DTCAuthorAttributes.name, DTCAuthorRelationships.books];
}

#pragma mark - Factory init
+(instancetype) authorWithName:(NSString *) name
                         stack:(AGTCoreDataStack *) stack{

    DTCAuthor *author = [NSEntityDescription insertNewObjectForEntityForName:[DTCAuthor entityName]
                                                      inManagedObjectContext:stack.context];
    author.name = name;
    return author;
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Cualquier cambio en las propiedades observables
}

@end
