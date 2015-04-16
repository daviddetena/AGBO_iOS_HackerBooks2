#import "DTCPdf.h"

@interface DTCPdf ()

// Private interface goes here.

@end

@implementation DTCPdf


#pragma mark - Property inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[];
}


#pragma mark - Factory Init
// Creamos un objeto pdf con datos vacíos a partir de la url
+(instancetype) pdfWithURL:(NSURL *) url
                   context:(NSManagedObjectContext *) context{

    DTCPdf *pdf = [NSEntityDescription insertNewObjectForEntityForName:[DTCPdf entityName]
                                                inManagedObjectContext:context];
    pdf.url = [url absoluteString];
    pdf.pdfData = nil;
    return pdf;
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Con cualquier cambio en las propiedades observables
    
}

@end
