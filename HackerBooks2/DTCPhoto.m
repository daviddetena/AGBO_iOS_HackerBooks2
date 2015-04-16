#import "DTCPhoto.h"

@interface DTCPhoto ()

@end

@implementation DTCPhoto

#pragma mark - Properties

-(void) setImage:(UIImage *) image{
    // Sincronizar con photoData
    self.photoData = UIImageJPEGRepresentation(image, 0.9);
}

-(UIImage *) image{
    return [UIImage imageWithData:self.photoData];
}


// Property inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[];
}


#pragma mark - Factory init
+(instancetype) photoWithImage:(UIImage *) image
                      imageURL:(NSURL *) imageURL
                       context:(NSManagedObjectContext *) context{
    
    DTCPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:[DTCPhoto entityName]
                                                    inManagedObjectContext:context];
    photo.photoData = UIImageJPEGRepresentation(image, 0.9);
    photo.url = [imageURL absoluteString];
    
    return photo;
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Con cualquier cambio en las propiedades observables
    
}

@end
