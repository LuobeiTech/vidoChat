

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

@interface XHVideoOutputSampleBufferFactory : NSObject

+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
