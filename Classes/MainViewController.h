//
//  MainViewController.h
//  Jankenpon
//
//  Created by Chase Colburn on 1/8/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "InfoViewController.h"

@interface MainViewController : UIViewController {
}

-(IBAction)startSinglePlayerClassic:(id)sender;
-(IBAction)startSinglePlayerUltimate:(id)sender;
-(IBAction)startMultiPlayerClassic:(id)sender;
-(IBAction)startMultiPlayerUltimate:(id)sender;

-(IBAction)showInfo:(id)sender;

@end
