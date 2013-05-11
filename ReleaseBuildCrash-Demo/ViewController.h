//
//  ViewController.h
//  ReleaseBuildCrash-Demo
//
//  Created by Osamu Noguchi on 5/11/13.
//  Copyright (c) 2013 Osamu Noguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSOperationQueue *operationQueue;
}

@property (strong, nonatomic) NSOperationQueue *operationQueue;

- (IBAction)buttonPressed:(id)sender;

@end
