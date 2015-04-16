#import "DTCTag.h"

@interface DTCTag ()

@end

@implementation DTCTag


#pragma mark - Properties inherited from base class
+(NSArray *) observableKeys{
// Observo las propiedades de las relaciones
return @[];
}



#pragma mark - Factory init

+(instancetype) tagWithName:(NSString *) name
                    context:(NSManagedObjectContext *) context{

    DTCTag *tag = [NSEntityDescription insertNewObjectForEntityForName:[DTCTag entityName]
                                                inManagedObjectContext:context];
    tag.name = name;
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
