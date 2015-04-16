#import "DTCAuthor.h"

@interface DTCAuthor ()

// Private interface goes here.

@end

@implementation DTCAuthor

#pragma mark - Properties inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[];
}

#pragma mark - Factory init
+(instancetype) authorWithName:(NSString *) name
                       context:(NSManagedObjectContext *) context{

    DTCAuthor *author = [NSEntityDescription insertNewObjectForEntityForName:[DTCAuthor entityName]
                                                      inManagedObjectContext:context];
    author.name = name;
    return author;
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Con cualquier cambio en las propiedades observables
    
}

@end
