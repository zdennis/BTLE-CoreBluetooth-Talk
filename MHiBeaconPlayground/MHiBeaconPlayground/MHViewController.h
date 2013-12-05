//
//  MHViewController.h
//  MHiBeaconPlayground
//
//  Created by Zach Dennis on 12/4/13.
//  Copyright (c) 2013 Zach Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MHViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
