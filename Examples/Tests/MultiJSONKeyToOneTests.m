//
//  MultiJSONKeyToOneTests.m
//  iOSTests
//
//  Created by LinXi on 2019/8/13.
//  Copyright © 2019 JSONModel. All rights reserved.
//

@import XCTest;
@import JSONModel;

@interface MultiJSONKeysToOneKeyModel : JSONModel

@property NSString *name;

@end

@implementation MultiJSONKeysToOneKeyModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}

+ (JSONKeyMapper *)keyMapper {
	return [[JSONKeyMapper alloc] initWithMultiJSONKeysToOneModelBlock:^NSString *(NSDictionary *jsonDictionary, NSString *keyName) {
		if ([keyName isEqualToString:@"name"]) {
			if (jsonDictionary && jsonDictionary[@"name2"]) {
				return @"name2";
			}
		}
		return keyName;
	}];
}

@end

@interface MultiJSONKeyToOneTests : XCTestCase
@end

@implementation MultiJSONKeyToOneTests

- (void)testJsonModel
{
	NSString *json = @"{\"name\":\"bar\"}";
	
	NSError *error = nil;
	MultiJSONKeysToOneKeyModel *obj = [[MultiJSONKeysToOneKeyModel alloc] initWithString:json error:&error];
	
	XCTAssertNil(error);
	XCTAssertNotNil(obj);
	
	XCTAssertEqualObjects(obj.name, @"bar");
	
	json = @"{\"name2\":\"bar2\"}";
	
	obj = [[MultiJSONKeysToOneKeyModel alloc] initWithString:json error:&error];
	
	XCTAssertNil(error);
	XCTAssertNotNil(obj);
	
	XCTAssertEqualObjects(obj.name, @"bar2");
}

@end
