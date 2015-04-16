// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DTCAnnotation.m instead.

#import "_DTCAnnotation.h"

const struct DTCAnnotationAttributes DTCAnnotationAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
	.text = @"text",
};

const struct DTCAnnotationRelationships DTCAnnotationRelationships = {
	.book = @"book",
	.location = @"location",
	.photo = @"photo",
};

@implementation DTCAnnotationID
@end

@implementation _DTCAnnotation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Annotation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:moc_];
}

- (DTCAnnotationID*)objectID {
	return (DTCAnnotationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic name;

@dynamic text;

@dynamic book;

@dynamic location;

@dynamic photo;

@end

