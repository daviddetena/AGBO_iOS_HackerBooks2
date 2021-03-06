#import "_DTCPhoto.h"
#import "AGTAsyncImage.h"

@import UIKit;
@class AGTCoreDataStack;

@interface DTCPhoto : _DTCPhoto {}

#pragma mark - Properties
// Propiedad transient para acceder a los datos de imagen a partir de un UIImage.
// Crearemos getter y setter para convertir de UIImage a NSData y viceversa
@property (strong,nonatomic) UIImage *image;

#pragma mark - Factory init
+(instancetype) photoForBookWithURL:(NSURL *) imageURL
                       defaultImage:(UIImage *) defaultImage
                              stack:(AGTCoreDataStack *) stack;


@end
