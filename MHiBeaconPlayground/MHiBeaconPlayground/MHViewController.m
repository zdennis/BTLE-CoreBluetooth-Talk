//
//  MHViewController.m
//  MHiBeaconPlayground
//
//  Created by Zach Dennis on 12/4/13.
//  Copyright (c) 2013 Zach Dennis. All rights reserved.
//

#import "MHViewController.h"

@interface MHViewController ()
@property CLLocationManager *locationManager;
@property CLBeaconRegion *beaconRegion;
@end

@implementation MHViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;

//                                                    E2C56DB5-DFFB-48D2-B060-D0F5A71096E0
  NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
  self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"com.mutuallyhuman"];
  NSLog(@"starting monitoring");
  [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
  NSLog(@"state for region");
 [self.locationManager requestStateForRegion:self.beaconRegion];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  NSLog(@"Failed");
}

- (void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
  switch (state) {
    case CLRegionStateInside:
      NSLog(@"Region inside");
      [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];

      break;
    case CLRegionStateOutside:
    case CLRegionStateUnknown:
    default:
      // stop ranging beacons, etc
      NSLog(@"Region unknown");
  }
}

- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  NSLog(@"did enter region");
}

- (void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
  NSLog(@"did exit region");
}


- (void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
  NSLog(@"did range beacons");
  if([beacons count] > 0){
    CLBeacon *nearest = [beacons objectAtIndex:0];
    if(CLProximityImmediate == nearest.proximity) {
      self.view.backgroundColor = [UIColor greenColor];
      self.titleLabel.text = @"Okay, too close.";
    } else if(CLProximityNear == nearest.proximity) {
      self.view.backgroundColor = [UIColor yellowColor];
      self.titleLabel.text = @"Getting closer";
    } else if(CLProximityFar == nearest.proximity) {
      self.view.backgroundColor = [UIColor blueColor];
      self.titleLabel.text = @"Cold";
    }
  } else {
    self.view.backgroundColor = [UIColor redColor];
    self.titleLabel.text = @"Who knows.";
  }
}

# pragma mark - UI

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
