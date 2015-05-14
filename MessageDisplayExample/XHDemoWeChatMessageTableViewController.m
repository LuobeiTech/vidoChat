
#import "XHDemoWeChatMessageTableViewController.h"

#import "XHDisplayTextViewController.h"
#import "XHDisplayMediaViewController.h"
#import "XHDisplayLocationViewController.h"
#import "XHEmotionManager.h"

#import "XHAudioPlayerHelper.h"



@interface XHDemoWeChatMessageTableViewController () <XHAudioPlayerHelperDelegate>

@property (nonatomic, strong) NSArray *emotionManagers;

@property (nonatomic, strong) XHMessageTableViewCell *currentSelectedCell;

@end

@implementation XHDemoWeChatMessageTableViewController

- (XHMessage *)getTextMessageWithBubbleMessageType:(XHBubbleMessageType)bubbleMessageType {
    XHMessage *textMessage = [[XHMessage alloc] initWithText:@"Call Me 10086. 这是Demo，Chat啦！" sender:@"Windy" timestamp:[NSDate distantPast]];
    textMessage.avator = [UIImage imageNamed:@"avator"];
    textMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    textMessage.bubbleMessageType = bubbleMessageType;
    
    return textMessage;
}

- (XHMessage *)getPhotoMessageWithBubbleMessageType:(XHBubbleMessageType)bubbleMessageType {
    XHMessage *photoMessage = [[XHMessage alloc] initWithPhoto:[UIImage imageNamed:@"placeholderImage"] thumbnailUrl:@"http://d.hiphotos.baidu.com/image/pic/item/30adcbef76094b361721961da1cc7cd98c109d8b.jpg" originPhotoUrl:nil sender:@"Jack" timestamp:[NSDate date]];
    photoMessage.avator = [UIImage imageNamed:@"avator"];
    photoMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    photoMessage.bubbleMessageType = bubbleMessageType;
    
    return photoMessage;
}

- (XHMessage *)getVideoMessageWithBubbleMessageType:(XHBubbleMessageType)bubbleMessageType {
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"IMG_1555.MOV" ofType:@""];
    XHMessage *videoMessage = [[XHMessage alloc] initWithVideoConverPhoto:[XHMessageVideoConverPhotoFactory videoConverPhotoWithVideoPath:videoPath] videoPath:videoPath videoUrl:nil sender:@"Jayson" timestamp:[NSDate date]];
    videoMessage.avator = [UIImage imageNamed:@"avator"];
    videoMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    videoMessage.bubbleMessageType = bubbleMessageType;
    
    return videoMessage;
}

- (XHMessage *)getVoiceMessageWithBubbleMessageType:(XHBubbleMessageType)bubbleMessageType {
    XHMessage *voiceMessage = [[XHMessage alloc] initWithVoicePath:nil voiceUrl:nil voiceDuration:@"1" sender:@"Jayson" timestamp:[NSDate date]];
    voiceMessage.avator = [UIImage imageNamed:@"avator"];
    voiceMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    voiceMessage.bubbleMessageType = bubbleMessageType;
    
    return voiceMessage;
}

- (XHMessage *)getEmotionMessageWithBubbleMessageType:(XHBubbleMessageType)bubbleMessageType {
    XHMessage *emotionMessage = [[XHMessage alloc] initWithEmotionPath:[[NSBundle mainBundle] pathForResource:@"Demo0.gif" ofType:nil] sender:@"Jayson" timestamp:[NSDate date]];
    emotionMessage.avator = [UIImage imageNamed:@"avator"];
    emotionMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    emotionMessage.bubbleMessageType = bubbleMessageType;
    
    return emotionMessage;
}

- (XHMessage *)getGeolocationsMessageWithBubbleMessageType:(XHBubbleMessageType)bubbleMessageType {
    XHMessage *localPositionMessage = [[XHMessage alloc] initWithLocalPositionPhoto:[UIImage imageNamed:@"Fav_Cell_Loc"] geolocations:@"中国广东省广州市天河区东圃二马路121号" location:[[CLLocation alloc] initWithLatitude:23.110387 longitude:113.399444] sender:@"Jack" timestamp:[NSDate date]];
    localPositionMessage.avator = [UIImage imageNamed:@"avator"];
    localPositionMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    localPositionMessage.bubbleMessageType = bubbleMessageType;
    
    return localPositionMessage;
}

- (NSMutableArray *)getTestMessages {
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 2; i ++) {
//        [messages addObject:[self getPhotoMessageWithBubbleMessageType:(i % 5) ? XHBubbleMessageTypeSending : XHBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getVideoMessageWithBubbleMessageType:(i % 6) ? XHBubbleMessageTypeSending : XHBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getVoiceMessageWithBubbleMessageType:(i % 4) ? XHBubbleMessageTypeSending : XHBubbleMessageTypeReceiving]];
//        
//        [messages addObject:[self getEmotionMessageWithBubbleMessageType:(i % 2) ? XHBubbleMessageTypeSending : XHBubbleMessageTypeReceiving]];
        
//        [messages addObject:[self getGeolocationsMessageWithBubbleMessageType:(i % 7) ? XHBubbleMessageTypeSending : XHBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getTextMessageWithBubbleMessageType:(i % 2) ? XHBubbleMessageTypeSending : XHBubbleMessageTypeReceiving]];
    }
    return messages;
}

- (void)loadDemoDataSource {
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *messages = [weakSelf getTestMessages];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.messages = messages;
            [weakSelf.messageTableView reloadData];
            
            [weakSelf scrollToBottomAnimated:NO];
        });
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[XHAudioPlayerHelper shareInstance] stopAudio];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedStringFromTable(@"Chat", @"MessageDisplayKitString", @"聊天");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receveMF1:)
                                                 name:@"MF1" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receveMF3:)
                                                 name:@"MF3" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receveMF4:)
                                                 name:@"MF4" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receveYY2:)
                                                 name:@"YY2" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receveVD2:)
                                                 name:@"VD2" object:nil];

    
    // Custom UI
//    [self setBackgroundColor:[UIColor clearColor]];
//    [self setBackgroundImage:[UIImage imageNamed:@"TableViewBackgroundImage"]];
    
    // 设置自身用户名
    self.messageSender = @"Windy";
    
    // 添加第三方接入数据
    NSMutableArray *shareMenuItems = [NSMutableArray array];
    NSArray *plugIcons = @[@"sharemore_video"];
    NSArray *plugTitle = @[ @"小视频"];
//    
//    NSArray *plugIcons = @[@"sharemore_pic", @"sharemore_video", @"sharemore_location", @"sharemore_friendcard", @"sharemore_myfav", @"sharemore_wxtalk", @"sharemore_videovoip", @"sharemore_voiceinput", @"sharemore_openapi", @"sharemore_openapi", @"avator"];
//    NSArray *plugTitle = @[@"照片", @"拍摄", @"位置", @"名片", @"我的收藏", @"实时对讲机", @"视频聊天", @"语音输入", @"大众点评", @"应用", @"windy"];
    for (NSString *plugIcon in plugIcons) {
        XHShareMenuItem *shareMenuItem = [[XHShareMenuItem alloc] initWithNormalIconImage:[UIImage imageNamed:plugIcon] title:[plugTitle objectAtIndex:[plugIcons indexOfObject:plugIcon]]];
        [shareMenuItems addObject:shareMenuItem];
    }
    
    NSMutableArray *emotionManagers = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++) {
        XHEmotionManager *emotionManager = [[XHEmotionManager alloc] init];
        emotionManager.emotionName = [NSString stringWithFormat:@"表情%ld", (long)i];
        NSMutableArray *emotions = [NSMutableArray array];
        for (NSInteger j = 0; j < 32; j ++) {
            XHEmotion *emotion = [[XHEmotion alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"section%ld_emotion%ld", (long)i , (long)j % 16];
            emotion.emotionPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Demo%ld.gif", (long)j % 2] ofType:@""];
            emotion.emotionConverPhoto = [UIImage imageNamed:imageName];
            [emotions addObject:emotion];
        }
        emotionManager.emotions = emotions;
        
        [emotionManagers addObject:emotionManager];
    }
    
    self.emotionManagers = emotionManagers;
    [self.emotionManagerView reloadData];
    
    self.shareMenuItems = shareMenuItems;
    [self.shareMenuView reloadData];
    
    [self loadDemoDataSource];
    
    
    self.sendSoundMessageIdDic = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.emotionManagers = nil;
    [[XHAudioPlayerHelper shareInstance] setDelegate:nil];
}

/*
 [self removeMessageAtIndexPath:indexPath];
 [self insertOldMessages:self.messages];
 */

#pragma mark - XHMessageTableViewCell delegate

- (void)multiMediaMessageDidSelectedOnMessage:(id<XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath onMessageTableViewCell:(XHMessageTableViewCell *)messageTableViewCell {
    UIViewController *disPlayViewController;
    switch (message.messageMediaType) {
        case XHBubbleMessageMediaTypeVideo:
        case XHBubbleMessageMediaTypePhoto: {
            DLog(@"message : %@", message.photo);
            DLog(@"message : %@", message.videoConverPhoto);
            XHDisplayMediaViewController *messageDisplayTextView = [[XHDisplayMediaViewController alloc] init];
            messageDisplayTextView.message = message;
            disPlayViewController = messageDisplayTextView;
            break;
        }
            break;
        case XHBubbleMessageMediaTypeVoice: {
            DLog(@"message : %@", message.voicePath);
            [[XHAudioPlayerHelper shareInstance] setDelegate:self];
            if (_currentSelectedCell) {
                [_currentSelectedCell.messageBubbleView.animationVoiceImageView stopAnimating];
            }
            if (_currentSelectedCell == messageTableViewCell) {
                [messageTableViewCell.messageBubbleView.animationVoiceImageView stopAnimating];
                [[XHAudioPlayerHelper shareInstance] stopAudio];
                self.currentSelectedCell = nil;
            } else {
                self.currentSelectedCell = messageTableViewCell;
                [messageTableViewCell.messageBubbleView.animationVoiceImageView startAnimating];
                [[XHAudioPlayerHelper shareInstance] managerAudioWithFileName:message.voicePath toPlay:YES];
            }
            break;
        }
        case XHBubbleMessageMediaTypeEmotion:
            DLog(@"facePath : %@", message.emotionPath);
            break;
        case XHBubbleMessageMediaTypeLocalPosition: {
            DLog(@"facePath : %@", message.localPositionPhoto);
            XHDisplayLocationViewController *displayLocationViewController = [[XHDisplayLocationViewController alloc] init];
            displayLocationViewController.message = message;
            disPlayViewController = displayLocationViewController;
            break;
        }
        default:
            break;
    }
    if (disPlayViewController) {
        [self.navigationController pushViewController:disPlayViewController animated:YES];
    }
}

- (void)didDoubleSelectedOnTextMessage:(id<XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath {
    DLog(@"text : %@", message.text);
    XHDisplayTextViewController *displayTextViewController = [[XHDisplayTextViewController alloc] init];
    displayTextViewController.message = message;
    [self.navigationController pushViewController:displayTextViewController animated:YES];
}

- (void)didSelectedAvatorOnMessage:(id<XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath {
    DLog(@"indexPath xmcheng : %@", indexPath);
//    XHContact *contact = [[XHContact alloc] init];
//    contact.contactName = [message sender];
//    contact.contactIntroduction = @"自定义描述，这个需要和业务逻辑挂钩";
//    XHContactDetailTableViewController *contactDetailTableViewController = [[XHContactDetailTableViewController alloc] initWithContact:contact];
//    [self.navigationController pushViewController:contactDetailTableViewController animated:YES];
}

- (void)menuDidSelectedAtBubbleMessageMenuSelecteType:(XHBubbleMessageMenuSelecteType)bubbleMessageMenuSelecteType {
    
}

#pragma mark - XHAudioPlayerHelper Delegate

- (void)didAudioPlayerStopPlay:(AVAudioPlayer *)audioPlayer {
    if (!_currentSelectedCell) {
        return;
    }
    [_currentSelectedCell.messageBubbleView.animationVoiceImageView stopAnimating];
    self.currentSelectedCell = nil;
}

#pragma mark - XHEmotionManagerView DataSource

- (NSInteger)numberOfEmotionManagers {
    return self.emotionManagers.count;
}

- (XHEmotionManager *)emotionManagerForColumn:(NSInteger)column {
    return [self.emotionManagers objectAtIndex:column];
}

- (NSArray *)emotionManagersAtManager {
    return self.emotionManagers;
}

#pragma mark - XHMessageTableViewController Delegate

- (BOOL)shouldLoadMoreMessagesScrollToTop {
    return YES;
}

- (void)loadMoreMessagesScrollTotop {
    if (!self.loadingMoreMessage) {
        self.loadingMoreMessage = YES;
        
        WEAKSELF
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *messages = [weakSelf getTestMessages];
            sleep(2);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf insertOldMessages:messages];
                weakSelf.loadingMoreMessage = NO;
            });
        });
    }
}

/**
 *  发送文本消息的回调方法
 *
 *  @param text   目标文本字符串
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date {
    XHMessage *textMessage = [[XHMessage alloc] initWithText:text sender:sender timestamp:date];
    textMessage.avator = [UIImage imageNamed:@"avator"];
    textMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    [self addMessage:textMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
    
    AppDelegate* myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat =  @"yyyy-MM-dd HH:mm:ss";
    NSString *time = [fmt stringFromDate:date];
    
    NSMutableDictionary *MF1 = [[NSMutableDictionary alloc] init];
    MF1[@"userId"] = myDelegate.nSocket.fromId;
    MF1[@"toUserId"] = toDevice;
    MF1[@"messageContent"] = text;
    MF1[@"time"] = time;
    MF1[@"messageType"]=@"0";
    NSData* MF1Data = [NSJSONSerialization dataWithJSONObject:MF1 options:0 error:nil];
    [myDelegate.nSocket sendId:@"MF1" Data:MF1Data];
}

/**
 *  发送图片消息的回调方法
 *
 *  @param photo  目标图片对象，后续有可能会换
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendPhoto:(UIImage *)photo fromSender:(NSString *)sender onDate:(NSDate *)date {
    XHMessage *photoMessage = [[XHMessage alloc] initWithPhoto:photo thumbnailUrl:nil originPhotoUrl:nil sender:sender timestamp:date];
    photoMessage.avator = [UIImage imageNamed:@"avator"];
    photoMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    [self addMessage:photoMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypePhoto];
}

/**
 *  发送视频消息的回调方法
 *
 *  @param videoPath 目标视频本地路径
 *  @param sender    发送者的名字
 *  @param date      发送时间
 */
- (void)didSendVideoConverPhoto:(UIImage *)videoConverPhoto videoPath:(NSString *)videoPath fromSender:(NSString *)sender onDate:(NSDate *)date {
    XHMessage *videoMessage = [[XHMessage alloc] initWithVideoConverPhoto:videoConverPhoto videoPath:videoPath videoUrl:nil sender:sender timestamp:date];
    videoMessage.avator = [UIImage imageNamed:@"avator"];
    videoMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    [self addMessage:videoMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeVideo];
    
    NSMutableDictionary*dict = [[NSMutableDictionary alloc] init];
    NSNumber * messageId = [[NSNumber alloc] initWithInt: abs(arc4random())];
    dict[@"path"] = videoPath;
    NSData * voiceData = [self readAudioFile:videoPath];
    [self.sendSoundMessageIdDic setObject:dict forKey:messageId];
    [self sendVD2:voiceData withTimes: messageId];
}


/**
 *  小视频消息的回调方法
 *
 *  @param videoPath 目标视频本地路径
 *  @param sender    发送者的名字
 *  @param date      发送时间
 */
- (void)didSendVideoMinConverPhoto:(UIImage *)videoConverPhoto videoPath:(NSString *)videoPath fromSender:(NSString *)sender onDate:(NSDate *)date {
    XHMessage *videoMessage = [[XHMessage alloc] initWithVideoConverPhoto:videoConverPhoto videoPath:videoPath videoUrl:nil sender:sender timestamp:date];
    videoMessage.avator = [UIImage imageNamed:@"avator"];
    videoMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    [self addMessage:videoMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeVideo];
    

}

- (NSString *)getVideoName
{
    NSString *recorderPath = nil;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd-hh-mm-ss";
    recorderPath = [[NSString alloc] initWithFormat:@"%@-MyVideo.mp4", [dateFormatter stringFromDate:now]];
    return recorderPath;
}

-(void)sendVD2:(NSData*)voiceData withTimes:(NSNumber* )messageId
{
    NSMutableData *nData =[[NSMutableData alloc] initWithData:[self int2Nsdata:(int)[messageId integerValue]]];
    [nData appendData:voiceData];
    
    AppDelegate * myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [myDelegate.nSocket sendId:@"VD2" Data:nData];
}

/**
 *  发送语音消息的回调方法
 *
 *  @param voicePath        目标语音本地路径
 *  @param voiceDuration    目标语音时长
 *  @param sender           发送者的名字
 *  @param date             发送时间
 */
- (void)didSendVoice:(NSString *)voicePath voiceDuration:(NSString *)voiceDuration fromSender:(NSString *)sender onDate:(NSDate *)date {
    XHMessage *voiceMessage = [[XHMessage alloc] initWithVoicePath:voicePath voiceUrl:nil voiceDuration:voiceDuration sender:sender timestamp:date];
    voiceMessage.avator = [UIImage imageNamed:@"avator"];
    voiceMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    [self addMessage:voiceMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeVoice];
    
    NSMutableDictionary*dict = [[NSMutableDictionary alloc] init];
    NSNumber * messageId = [[NSNumber alloc] initWithInt: abs(arc4random())];
    dict[@"times"] = voiceDuration;
    dict[@"path"] = voicePath;
    NSData * soundData = [self readAudioFile:voicePath];
    [self.sendSoundMessageIdDic setObject:dict forKey:messageId];
    [self sendYY2:soundData withTimes: messageId];
    
}

- (NSString*)getAudioPath
{
    return [[NSString alloc] initWithFormat:@"%@/Documents/", NSHomeDirectory()];
}

- (NSString *)getVoiceName
{
    NSString *recorderPath = nil;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd-hh-mm-ss";
    recorderPath = [[NSString alloc] initWithFormat:@"%@-MySound.mp3", [dateFormatter stringFromDate:now]];
    return recorderPath;
}

- (NSString *)writeFilePath:(NSString*)path withFileName:(NSString *)fileName withData:(NSData*)nData;
{
    NSFileManager* deufileManager =  [NSFileManager defaultManager];
    if (![deufileManager fileExistsAtPath:path])
    {
        [deufileManager createDirectoryAtPath:path
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:NULL];
    }
    
    if (![deufileManager fileExistsAtPath: [path stringByAppendingString:fileName] ]) {
        [nData writeToFile:[path stringByAppendingPathComponent:fileName] atomically:YES ];
        
        return [path stringByAppendingString:fileName];
    }
    
    NSFileHandle  *outFile = [NSFileHandle fileHandleForWritingAtPath:[path stringByAppendingString:fileName]];
    NSLog(@"paaa is %@",[path stringByAppendingString:fileName]);
    if(outFile == nil)
    {
        NSLog(@"Open of file for writing failed");
    }
    
    //找到并定位到outFile的末尾位置(在此后追加文件)
    [outFile seekToEndOfFile];
    //读取inFile并且将其内容写到outFile中
    
    [outFile writeData:nData];
    //关闭读写文件
    [outFile closeFile];
    return [path stringByAppendingString:fileName];
}

-(NSData*) readAudioFile:(NSString*)path
{
    NSFileHandle *inFile = [[NSFileHandle alloc]init];
    inFile = [NSFileHandle fileHandleForReadingAtPath:path];
    if(inFile == nil)
    {
        NSLog(@"Open of %@ for reading failed!" ,path);
    }
    
    inFile = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData* nData =  [inFile readDataToEndOfFile];
    [inFile closeFile];
    return nData;
}

-(NSData *)int2Nsdata:(int)sId
{
    NSMutableData *sIdData = [NSMutableData dataWithBytes: &sId length: sizeof(sId)];
    unsigned char tmp1 = ((unsigned char*)sIdData.mutableBytes)[0] ;
    unsigned char tmp2 = ((unsigned char*)sIdData.mutableBytes)[1] ;
    unsigned char tmp3 = ((unsigned char*)sIdData.mutableBytes)[2] ;
    unsigned char tmp4 = ((unsigned char*)sIdData.mutableBytes)[3] ;
    
    ((unsigned char*)sIdData.mutableBytes)[0] = tmp4;
    ((unsigned char*)sIdData.mutableBytes)[1] = tmp3;
    ((unsigned char*)sIdData.mutableBytes)[2] = tmp2;
    ((unsigned char*)sIdData.mutableBytes)[3] = tmp1;
    return sIdData;
}

-(void)sendYY2:(NSData*)soundData withTimes:(NSNumber* )messageId
{
    NSMutableData *nData =[[NSMutableData alloc] initWithData:[self int2Nsdata:(int)[messageId integerValue]]];
    [nData appendData:soundData];
    
    AppDelegate * myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [myDelegate.nSocket sendId:@"YY2" Data:nData];
}

/**
 *  发送第三方表情消息的回调方法
 *
 *  @param facePath 目标第三方表情的本地路径
 *  @param sender   发送者的名字
 *  @param date     发送时间
 */
- (void)didSendEmotion:(NSString *)emotionPath fromSender:(NSString *)sender onDate:(NSDate *)date {
    XHMessage *emotionMessage = [[XHMessage alloc] initWithEmotionPath:emotionPath sender:sender timestamp:date];
    emotionMessage.avator = [UIImage imageNamed:@"avator"];
    emotionMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    [self addMessage:emotionMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeEmotion];
}

/**
 *  发送地理位置
 */
- (void)didSendGeoLocationsPhoto:(UIImage *)geoLocationsPhoto geolocations:(NSString *)geolocations location:(CLLocation *)location fromSender:(NSString *)sender onDate:(NSDate *)date {
    XHMessage *geoLocationsMessage = [[XHMessage alloc] initWithLocalPositionPhoto:geoLocationsPhoto geolocations:geolocations location:location sender:sender timestamp:date];
    geoLocationsMessage.avator = [UIImage imageNamed:@"avator"];
    geoLocationsMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    [self addMessage:geoLocationsMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeLocalPosition];
}

/**
 *  是否显示时间轴Label的回调方法
 *
 *  @param indexPath 目标消息的位置IndexPath
 *
 *  @return 根据indexPath获取消息的Model的对象，从而判断返回YES or NO来控制是否显示时间轴Label
 */
- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2)
        return YES;
    else
        return NO;
}

/**
 *  配置Cell的样式或者字体
 *
 *  @param cell      目标Cell
 *  @param indexPath 目标Cell所在位置IndexPath
 */
- (void)configureCell:(XHMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

}

/**
 *  协议回掉是否支持用户手动滚动
 *
 *  @return 返回YES or NO
 */
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling {
    return YES;
}

//------------------收协议---------------------
- (void)receveMF1:(NSNotification*)notification
{
    NSData* nsData =  [notification object];
    [self performSelectorOnMainThread:@selector(updateMF1:) withObject:nsData waitUntilDone:YES];
}

- (void)updateMF1:(id)data
{
    NSDictionary* MF1Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    AppDelegate *myDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    if (![MF1Dict[@"userId"] isEqualToString:myDelegate.nSocket.fromId]) {
        //发给我的
        NSLog(@"发给我的");
        XHMessage *textMessage = [[XHMessage alloc]
                                  initWithText:MF1Dict[@"messageContent"]
                                  sender:MF1Dict[@"userName"]
                                  timestamp: [NSDate date] ];
        textMessage.avator = [UIImage imageNamed:@"avator"];
        textMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
        textMessage.bubbleMessageType = XHBubbleMessageTypeReceiving;
        [self addMessage:textMessage];
        [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
    } else {
        NSLog(@"我发送的");
    }
}

- (void)receveMF3:(NSNotification*)notification
{
    NSData* nsData = [notification object];
    
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];
    AppDelegate *myDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    if (![dict[@"userId"] isEqualToString:myDelegate.nSocket.fromId]) {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"messageContent"]]];
        NSString *audioPath = [self writeFilePath:[self getAudioPath] withFileName:[self getVoiceName] withData:data];
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc ] initWithDictionary:dict];
        muDic[@"audioLocalPath"] = audioPath;
        [self performSelectorOnMainThread:@selector(updateMF3:) withObject:muDic waitUntilDone:YES];
    }
}

- (void)updateMF3:(id)dict
{
    XHMessage *voiceMessage = [[XHMessage alloc] initWithVoicePath:dict[@"audioLocalPath"]
                                                          voiceUrl:dict[@"content"]
                                                     voiceDuration:dict[@"audioLength"]
                                                            sender:dict[@"userName"]
                                                         timestamp:[NSDate date]];
    voiceMessage.avator = [UIImage imageNamed:@"avator"];
    voiceMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    
    voiceMessage.bubbleMessageType = XHBubbleMessageTypeReceiving;
    [self addMessage:voiceMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeVoice];
}

- (void)receveMF4:(NSNotification*)notification
{
    NSData* nsData =  [notification object];
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingMutableContainers error:nil];
    AppDelegate *myDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    if (![dict[@"userId"] isEqualToString:myDelegate.nSocket.fromId]) {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"messageContent"]]];
        NSString *audioPath = [self writeFilePath:[self getAudioPath] withFileName:[self getVideoName] withData:data];
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc ] initWithDictionary:dict];
        muDic[@"voiceLocalPath"] = audioPath;
        
        [self performSelectorOnMainThread:@selector(updateMF4:) withObject:muDic waitUntilDone:YES];
    }
}

- (void)updateMF4:(id)dict
{
    //发给我的
    NSLog(@"发给我的");
    
//    XHMessage *vidoMessage = [[XHMessage alloc]
//                              initWithText:dict[@"voiceLocalPath"]
//                              sender:dict[@"userName"]
//                              timestamp: [NSDate date]];
    
     XHMessage *videoMessage = [[XHMessage alloc] initWithVideoConverPhoto:[XHMessageVideoConverPhotoFactory videoConverPhotoWithVideoPath:dict[@"voiceLocalPath"]] videoPath:dict[@"voiceLocalPath"] videoUrl:nil sender:dict[@"userName"] timestamp:[NSDate date]];
    videoMessage.avator = [UIImage imageNamed:@"avator"];
    videoMessage.avatorUrl = @"http://f.hiphotos.baidu.com/image/pic/item/95eef01f3a292df58d38be12bf315c6034a87339.jpg";
    videoMessage.bubbleMessageType = XHBubbleMessageTypeReceiving;
    [self addMessage:videoMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeVideo];
}

- (void) receveYY2:(NSNotification*) anotification
{
    NSData* nsData =  [anotification object];
    [self performSelectorOnMainThread:@selector(updateResgContollerYY2:) withObject:nsData waitUntilDone:YES];
}

-(void) updateResgContollerYY2:(id) data
{
    NSDictionary* YY2Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSNumber * code =  YY2Dict[@"code"];
    if([code integerValue]==1)
    {
        AppDelegate *myDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
        
        NSMutableDictionary *MF3 = [[NSMutableDictionary alloc] init];
        MF3[@"userId"] = myDelegate.nSocket.fromId;
        MF3[@"toUserId"] = toDevice;
        MF3[@"messageContent"] = YY2Dict[@"audioUrl"];
        NSNumber *key = YY2Dict[@"key"];
        NSMutableDictionary * tmpDict =  [self.sendSoundMessageIdDic objectForKey:key];
        NSNumber *times =  tmpDict[@"times"];
        MF3[@"audioLength"] = [[NSString alloc] initWithFormat:@"%d", [times integerValue]];
        MF3[@"messageType"]=@"2";
        NSData* MF3Data = [NSJSONSerialization dataWithJSONObject:MF3 options:0 error:nil];
       [myDelegate.nSocket sendId:@"MF3" Data:MF3Data];
        [self.sendSoundMessageIdDic removeObjectForKey:key];
    }
}

- (void) receveVD2:(NSNotification*) anotification
{
    NSData* nsData =  [anotification object];
    [self performSelectorOnMainThread:@selector(updateResgContollerVD2:) withObject:nsData waitUntilDone:YES];
}

-(void) updateResgContollerVD2:(id) data
{
    NSDictionary* VD2Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSNumber * code =  VD2Dict[@"code"];
    
    if([code integerValue]==1)
    {
        AppDelegate *myDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
        
        NSMutableDictionary *MF4 = [[NSMutableDictionary alloc] init];
        MF4[@"userId"] = myDelegate.nSocket.fromId;
        MF4[@"toUserId"] = toDevice;
        MF4[@"messageContent"] = VD2Dict[@"videoUrl"];
        NSNumber *key = VD2Dict[@"key"];
        NSMutableDictionary * tmpDict =  [self.sendSoundMessageIdDic objectForKey:key];
        NSNumber *times =  @"10";
        MF4[@"audioLength"] = @"0";
//        MF3[@"messageType"]=@"2";
        NSData* MF4Data = [NSJSONSerialization dataWithJSONObject:MF4 options:0 error:nil];
        [myDelegate.nSocket sendId:@"MF4" Data:MF4Data];
        [self.sendSoundMessageIdDic removeObjectForKey:key];
    }
}

@end
