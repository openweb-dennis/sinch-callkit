#import "MainViewController.h"
#import "CallViewController.h"

#import <Sinch/Sinch.h>

@interface MainViewController () <SINCallClientDelegate>
@end

@implementation MainViewController

- (id<SINClient>)client {
  return [(AppDelegate *)[[UIApplication sharedApplication] delegate] client];
}

- (void)awakeFromNib {
    [super awakeFromNib];
  self.client.callClient.delegate = self;
}

- (IBAction)call:(id)sender {
  if ([self.destination.text length] > 0 && [self.client isStarted]) {
    id<SINCall> call = [self.client.callClient callUserVideoWithId:self.destination.text];
    [self performSegueWithIdentifier:@"callView" sender:call];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  CallViewController *callViewController = [segue destinationViewController];
  callViewController.call = sender;
}

#pragma mark - SINCallClientDelegate

- (void)client:(id<SINCallClient>)client didReceiveIncomingCall:(id<SINCall>)call {
  [self performSegueWithIdentifier:@"callView" sender:call];
}

- (SINLocalNotification *)client:(id<SINClient>)client localNotificationForIncomingCall:(id<SINCall>)call {
  SINLocalNotification *notification = [[SINLocalNotification alloc] init];
  notification.alertAction = @"Answer";
  notification.alertBody = [NSString stringWithFormat:@"Incoming call from %@", [call remoteUserId]];
  return notification;
}

@end
