

#import <UIKit/UIKit.h>
#import "XHMessageVideoConverPhotoFactory.h"

typedef void (^ablock)(UIImage *image ,NSURL *pathUrl);

@interface PlayViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withVideoFileURL:(NSURL *)videoFileURL;



@property (nonatomic, copy) ablock block;

@end
