

#import <Foundation/NSObject.h>
#import <Foundation/NSAutoreleasePool.h>
#import "testLCS.h"

/*
STAssertEquals(object, object, message, ...) 
STAssertEqualObjects(object, object, message, ...) 
STAssertNotNil(object, message, ...) 
STAssertTrue(expression, message, ...) 
STAssertFalse(expression, message, ...) 
STAssertThrowsSpecific(expression, exception, message, ...) 
STAssertNoThrow(expression, message, ...) 
STFail(message, ...)
*/

@implementation TestLCS

- (void) setUp
{
    lcsUT = [[LCS alloc] init];
}

- (void) tearDown
{
    [lcsUT release];
}

- (void) testDumbTest
{
    STAssertEquals(123, 123,
		@"bad amount; 123 != 123");
}

@end

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[SenTestObserver class];
	printf("TODO: LCS Test suite executable\n");
	
	//TestLCS *tests = [[TestLCS alloc] init];
	//Do something
	//[tests release];
	SenTestSuite *lcsSuite = [SenTestSuite testSuiteForTestCaseClass:[TestLCS class]];
	[lcsSuite run];

	[pool release];
	return 0;
}

