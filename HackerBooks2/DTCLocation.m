#import "DTCLocation.h"

@interface DTCLocation ()

// Private interface goes here.

@end

@implementation DTCLocation

#pragma mark - Properties inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[DTCLocationAttributes.address,DTCLocationAttributes.latitude,DTCLocationAttributes.longitude];
}




#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Al cambiar el address => obtener nueva (longitud,latitud)
}

@end
