//
//  WHHSoudMp3Util.h
//  WoHeiHei
//
//  Created by apple on 14/12/3.
//  Copyright (c) 2014年 ___xmcheng__. All rights reserved.
//

//2014.12.29 zk 增加SoundMp3Delegate的两个代理

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol SoundMp3Delegate <NSObject>

@optional
- (void)playStart:(NSString*)filePath;
- (void)playing:(NSString*)filePath;
- (void)playEnd:(NSString*)filePath;

@end

@interface WHHSoudMp3Util : NSObject<AVAudioPlayerDelegate,AVAudioSessionDelegate>
{

    AVAudioSession *session;
    
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
  
}

@property (nonatomic,assign) id<SoundMp3Delegate> delegate;
@property NSTimeInterval duration;

-(void)recordeSound:(NSString*)filePath;
-(void)cancelRecorder:(NSString *)filePath;
-(void)stopRecorder:(NSString*) filePath;

-(void)playMp3:(NSString*) filePath;

-(void)playOrPause;

-(void)stop;

+(NSString*) toMp3Path:(NSString*)filePath;
- (NSString*)audio_PCMtoMP3:(NSString* )filePath;

@end
