#import "DTCAnnotation.h"

@interface DTCAnnotation ()

+(NSArray *) observableKeys;

@end

@implementation DTCAnnotation

#pragma mark - Properties inherited from base class
+(NSArray *) observableKeys{
    return @[DTCAnnotationAttributes.creationDate,DTCAnnotationAttributes.name,DTCAnnotationAttributes.text,@"photo.photoData"];
}

#pragma mark - Factory init
+(instancetype) annotationWithName:(NSString *) name
                              book:(DTCBook *) book
                           context:(NSManagedObjectContext *) context{
    
    DTCAnnotation *annotation = [NSEntityDescription insertNewObjectForEntityForName:[DTCAnnotation entityName]
                                                              inManagedObjectContext:context];
    annotation.name = name;
    annotation.book = book;
    annotation.creationDate = [NSDate date];
    annotation.modificationDate = [NSDate date];
    
    return annotation;
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Con cualquier cambio en las propiedades observables
    // de la anotación, cambio la fecha de modificación
    self.modificationDate = [NSDate date];
}

@end
