// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DTCPdf.m instead.

#import "_DTCPdf.h"

const struct DTCPdfAttributes DTCPdfAttributes = {
	.pdfData = @"pdfData",
	.url = @"url",
};

const struct DTCPdfRelationships DTCPdfRelationships = {
	.book = @"book",
};

@implementation DTCPdfID
@end

@implementation _DTCPdf

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pdf" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pdf";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pdf" inManagedObjectContext:moc_];
}

- (DTCPdfID*)objectID {
	return (DTCPdfID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic pdfData;

@dynamic url;

@dynamic book;

@end

