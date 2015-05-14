

#import <Foundation/Foundation.h>

#define kXHEmotionImageViewSize 60
#define kXHEmotionMinimumLineSpacing 16

@interface XHEmotion : NSObject

/**
 *  gif表情的封面图
 */
@property (nonatomic, strong) UIImage *emotionConverPhoto;

/**
 *  gif表情的路径
 */
@property (nonatomic, copy) NSString *emotionPath;

@end
