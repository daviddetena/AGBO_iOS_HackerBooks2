#import "_DTCPdf.h"

@interface DTCPdf : _DTCPdf {}


#pragma mark - Init
+(instancetype) pdfWithURL:(NSURL *) url
                   context:(NSManagedObjectContext *) context;

@end
