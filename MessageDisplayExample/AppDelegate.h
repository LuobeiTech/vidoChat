
#import <UIKit/UIKit.h>
#import "SYNNetSocket.h"
#import "SYNDispatchProcessor.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property SYNNetSocket* nSocket;

@property SYNDispatchProcessor* dispathProcessor;


@end
