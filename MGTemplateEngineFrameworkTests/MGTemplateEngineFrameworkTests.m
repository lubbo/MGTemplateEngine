//
//  MGTemplateEngineFrameworkTests.m
//  MGTemplateEngineFrameworkTests
//
//  Created by Davide Ramo on 19/02/16.
//
//

#import <XCTest/XCTest.h>
#import "MGTemplateEngine.h"
#import "ICUTemplateMatcher.h"

@interface MGTemplateEngineFrameworkTests : XCTestCase <MGTemplateEngineDelegate>

@end

@implementation MGTemplateEngineFrameworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    MGTemplateEngine *engine = [MGTemplateEngine templateEngine];
    [engine setDelegate:self];
    [engine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:engine]];
    
    // Set up any needed global variables.
    // Global variables persist for the life of the engine, even when processing multiple templates.
    [engine setObject:@"Hi there!" forKey:@"hello"];
    
    // Get path to template.
    NSString *templatePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"sample_template" ofType:@"txt"];
    
    // Set up some variables for this specific template.
    NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSArray arrayWithObjects:
                                @"matt", @"iain", @"neil", @"chris", @"steve", nil], @"guys",
                               [NSDictionary dictionaryWithObjectsAndKeys:@"baz", @"bar", nil], @"foo",
                               nil];
    
    // Process the template and display the results.
    NSString *result = [engine processTemplateInFileAtPath:templatePath withVariables:variables];
    NSLog(@"Processed template:\r%@", result);
}

- (void)templateEngine:(MGTemplateEngine *)engine blockStarted:(NSDictionary *)blockInfo
{
    //NSLog(@"Started block %@", [blockInfo objectForKey:BLOCK_NAME_KEY]);
}


- (void)templateEngine:(MGTemplateEngine *)engine blockEnded:(NSDictionary *)blockInfo
{
    //NSLog(@"Ended block %@", [blockInfo objectForKey:BLOCK_NAME_KEY]);
}


- (void)templateEngineFinishedProcessingTemplate:(MGTemplateEngine *)engine
{
    //NSLog(@"Finished processing template.");
}


- (void)templateEngine:(MGTemplateEngine *)engine encounteredError:(NSError *)error isContinuing:(BOOL)continuing;
{
    NSLog(@"Template error: %@", error);
}

@end
