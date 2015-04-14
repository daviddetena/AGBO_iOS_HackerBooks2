// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DTCPhoto.m instead.

#import "_DTCPhoto.h"

const struct DTCPhotoAttributes DTCPhotoAttributes = {
	.photoData = @"photoData",
	.url = @"url",
};

const struct DTCPhotoRelationships DTCPhotoRelationships = {
	.annotations = @"annotations",
	.book = @"book",
};

@implementation DTCPhotoID
@end

@implementation _DTCPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (DTCPhotoID*)objectID {
	return (DTCPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic photoData;

@dynamic url;

@dynamic annotations;

- (NSMutableSet*)annotationsSet {
	[self willAccessValueForKey:@"annotations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"annotations"];

	[self didAccessValueForKey:@"annotations"];
	return result;
}

@dynamic book;

@end

