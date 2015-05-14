
#import <UIKit/UIKit.h>
#import "LKBadgeView.h"

@interface XHCircleView : UIView

@end

@interface UIView (XHBadgeView)

@property (nonatomic, assign) CGRect badgeViewFrame;
@property (nonatomic, strong, readonly) LKBadgeView *badgeView;

- (XHCircleView *)setupCircleBadge;

@end
