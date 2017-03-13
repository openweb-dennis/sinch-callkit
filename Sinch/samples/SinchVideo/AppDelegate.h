#import <UIKit/UIKit.h>
#import <Sinch/Sinch.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, SINClientDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id<SINClient> client;

@end
