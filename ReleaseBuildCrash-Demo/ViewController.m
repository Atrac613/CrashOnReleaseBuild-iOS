//
//  ViewController.m
//  ReleaseBuildCrash-Demo
//
//  Created by Osamu Noguchi on 5/11/13.
//  Copyright (c) 2013 Osamu Noguchi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize operationQueue;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue setMaxConcurrentOperationCount:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    NSArray *params = [NSArray arrayWithObject:@"Hello World!"];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(encodeOperation:) object:params];
    [operation setQueuePriority:NSOperationQueuePriorityHigh];
    [operationQueue addOperation:operation];
}

- (void)encodeOperation:(NSArray*)params {
    @try {
        NSString *string = [params objectAtIndex:0];
        
        NSString *encodeString = [self encodeString:string];
        
        /*
         * Workaround
         *
         
        if (encodeString && encodeString.length > 0) {
            params = [NSArray arrayWithObject:encodeString];
            
            [self performSelectorOnMainThread:@selector(encodeOperationComplete:) withObject:params waitUntilDone:NO];
        }
        
        */
        
        // Crash on Optimization Level Fastest, Smallest [-Os]
        params = [NSArray arrayWithObject:encodeString];
        
        [self performSelectorOnMainThread:@selector(completedEncodeOperation:) withObject:params waitUntilDone:NO];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

- (void)completedEncodeOperation:(NSArray*)params {
    NSString *string = [params objectAtIndex:0];
    
    NSLog(@"Result: %@", string);
}

- (NSString*)encodeString:(NSString*)string {
    if (string == nil || string.length < 32) {
        NSException *exception = [[NSException alloc] initWithName:@"EncodeString" reason:@"String length is invalid." userInfo:nil];
        @throw exception;
    }
    
    return string;
}

@end
