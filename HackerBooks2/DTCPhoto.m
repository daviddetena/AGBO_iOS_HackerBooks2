#import "DTCPhoto.h"
#import "AGTCoreDataStack.h"
#import "AGTAsyncImage.h"


@implementation DTCPhoto

#pragma mark - Properties

// Property inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[DTCPhotoAttributes.url,DTCPhotoAttributes.photoData];
}

-(UIImage *) image{
    return [UIImage imageWithData:self.photoData];
}

-(void) setImage:(UIImage *)image{
    // Convertimos UIImage en NSData entendible por Core Data
    self.photoData = UIImageJPEGRepresentation(image, 0.9);
}



#pragma mark - Factory init
+(instancetype) photoForBookWithURL:(NSURL *) imageURL
                       defaultImage:(UIImage *) defaultImage
                              stack:(AGTCoreDataStack *) stack{

    // Cargamos la imagen con imagen por defecto
    DTCPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:[DTCPhoto entityName]
                                                    inManagedObjectContext:stack.context];
    
    // Iniciamos imagen por defecto. Al terminar la carga en segundo plano
    // se cargará automáticamente en el UIImage
    photo.url = [imageURL path];
    photo.photoData = nil;
    photo.image = defaultImage;
    
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
