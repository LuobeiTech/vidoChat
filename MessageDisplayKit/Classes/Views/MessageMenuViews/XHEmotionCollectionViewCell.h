

#import <UIKit/UIKit.h>
#import "XHEmotion.h"

#define kXHEmotionCollectionViewCellIdentifier @"XHEmotionCollectionViewCellIdentifier"

@interface XHEmotionCollectionViewCell : UICollectionViewCell

/**
 *  需要显示和配置的gif表情对象
 */
@property (nonatomic, strong) XHEmotion *emotion;

@end
