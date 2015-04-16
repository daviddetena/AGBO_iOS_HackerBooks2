#import "_DTCPdf.h"
@class AGTCoreDataStack;

@interface DTCPdf : _DTCPdf {}


#pragma mark - Init
+(instancetype) pdfWithURL:(NSURL *) url
                     stack:(AGTCoreDataStack *) stack;

@end
