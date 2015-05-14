

#import "AppDelegate.h"
#import "XHBaseTabBarController.h"
#import "XHBaseNavigationController.h"

#import "XHMessageRootViewController.h"
//#import "XHDiscoverTableViewController.h"
//#import "XHProfileTableViewController.h"

#import "XHMacro.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // message
    XHMessageRootViewController *messageRootViewController = [[XHMessageRootViewController alloc] init];
    messageRootViewController.title = NSLocalizedStringFromTable(@"Chat", @"MessageDisplayKitString", @"Chat");
    messageRootViewController.tabBarItem.image = [UIImage imageNamed:@"Chat"];
    XHBaseNavigationController *messageNavigationController = [[XHBaseNavigationController alloc] initWithRootViewController:messageRootViewController];
    
    // contact
//    XHContactTableViewController *contactTableViewController = [[XHContactTableViewController alloc] init];
//    contactTableViewController.title = NSLocalizedStringFromTable(@"Contact", @"MessageDisplayKitString", @"联系人");
//    contactTableViewController.tabBarItem.image = [UIImage imageNamed:@"Contact"];
//    XHBaseNavigationController *contactNavigationController = [[XHBaseNavigationController alloc] initWithRootViewController:contactTableViewController];
    
    // discover
//    XHDiscoverTableViewController *discoverTableViewController = [[XHDiscoverTableViewController alloc] init];
//    discoverTableViewController.title = NSLocalizedStringFromTable(@"News", @"MessageDisplayKitString", @"发现");
//    discoverTableViewController.tabBarItem.image = [UIImage imageNamed:@"SNS"];
//    XHBaseNavigationController *discoverNavigationController = [[XHBaseNavigationController alloc] initWithRootViewController:discoverTableViewController];
    
    // profile
//    XHProfileTableViewController *profileTableViewController = [[XHProfileTableViewController alloc] init];
//    profileTableViewController.title = NSLocalizedStringFromTable(@"Profile", @"MessageDisplayKitString", @"");
//    profileTableViewController.tabBarItem.image = [UIImage imageNamed:@"Profile"];
//    XHBaseNavigationController *profileNavigationController = [[XHBaseNavigationController alloc] initWithRootViewController:profileTableViewController];
    
    // tab bar
    XHBaseTabBarController *rootTabBarController = [[XHBaseTabBarController alloc] init];
    rootTabBarController.viewControllers = [NSArray arrayWithObjects:messageNavigationController, nil];
    
    // setup UI Image
    UIColor *color = [UIColor colorWithRed:0.176 green:0.576 blue:0.980 alpha:1.000];
    [rootTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@""]];
    [rootTabBarController.tabBar setSelectedImageTintColor:color];
    
    if (CURRENT_SYS_VERSION >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.071 green:0.060 blue:0.086 alpha:1.000]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    } else {
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.071 green:0.060 blue:0.086 alpha:1.000]];
    }
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    
    self.window.rootViewController = rootTabBarController;
    
    [self.window makeKeyAndVisible];
    
    self.dispathProcessor =[[SYNDispatchProcessor alloc] init];
    [ self.dispathProcessor delayTimeGCDbuild];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
