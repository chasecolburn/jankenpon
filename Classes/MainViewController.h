//
//  MainViewController.h
//  Jankenpon
//
//  Created by Chase Colburn on 1/8/11.
//  Copyright 2011 Cerego. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	UIImageView *multiPlayerPanel;
}

@property(nonatomic, retain) IBOutlet UIImageView *multiPlayerPanel;

- (IBAction)showInfo:(id)sender;

@end
