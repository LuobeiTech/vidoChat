

#import <UIKit/UIKit.h>
#import "XHEmotionManager.h"

@protocol XHEmotionSectionBarDelegate <NSObject>

/**
 *  点击某一类gif表情的回调方法
 *
 *  @param emotionManager 被点击的管理表情Model对象
 *  @param section        被点击的位置
 */
- (void)didSelecteEmotionManager:(XHEmotionManager *)emotionManager atSection:(NSInteger)section;

@end

@interface XHEmotionSectionBar : UIView

@property (nonatomic, weak) id <XHEmotionSectionBarDelegate> delegate;

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *emotionManagers;

- (instancetype)initWithFrame:(CGRect)frame showEmotionStoreButton:(BOOL)isShowEmotionStoreButtoned;


/**
 *  根据数据源刷新UI布局和数据
 */
- (void)reloadData;

@end
