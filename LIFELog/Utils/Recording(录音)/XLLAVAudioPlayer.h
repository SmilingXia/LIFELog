//
//  XLLAVAudioPlayer.h
//  LIFELog
//
//  Created by 夏江福 on 2018/8/18.
//  Copyright © 2018年 夏江福. All rights reserved.
//

#import "XLLBaseVM.h"

@interface XLLAVAudioPlayer : XLLBaseVM

- (void)audioPlayerPlay:(NSString *)filePath;

- (void)play;            /* sound is played asynchronously. */
- (void)pause;            /* pauses playback, but remains ready to play. */
- (void)stop;            /* stops playback. no longer ready to play. */

@end
