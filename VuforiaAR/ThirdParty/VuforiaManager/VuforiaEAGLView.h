//
//  VuforiaEAGLView.h
//  VuforiaSampleSwift
//
//  Created by Yoshihiro Kato on 2016/07/02.
//  Copyright © 2016年 Yoshihiro Kato. All rights reserved.
//
/*MIT License
 
 Copyright (c) 2017 Yoshihiro Kato <yoshihiro@sputnik-apps.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.*/


#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <Vuforia/UIGLViewProtocol.h>

#import "VuforiaManager.h"

@class VuforiaManager;
@class VuforiaEAGLView;

@protocol VuforiaEAGLViewSceneSource <NSObject>

- (SCNScene *)sceneForEAGLView:(VuforiaEAGLView *)view userInfo:(NSDictionary<NSString*, id>*)userInfo;

@end

@protocol VuforiaEAGLViewDelegate <NSObject>

- (void)vuforiaEAGLView:(VuforiaEAGLView*)view didTouchDownNode:(SCNNode *)node;
- (void)vuforiaEAGLView:(VuforiaEAGLView*)view didTouchUpNode:(SCNNode *)node;
- (void)vuforiaEAGLView:(VuforiaEAGLView*)view didTouchCancelNode:(SCNNode *)node;

@end


// EAGLView is a subclass of UIView and conforms to the informal protocol
// UIGLViewProtocol
@interface VuforiaEAGLView : UIView <UIGLViewProtocol>

@property (weak, nonatomic)id<VuforiaEAGLViewSceneSource> sceneSource;
@property (weak, nonatomic)id<VuforiaEAGLViewDelegate> delegate;
@property (nonatomic, assign)CGFloat objectScale;

- (id)initWithFrame:(CGRect)frame manager:(VuforiaManager *) manager;

- (void)setNearPlane:(CGFloat) near farPlane:(CGFloat) far;

- (void)setupRenderer;
- (void)setNeedsChangeSceneWithUserInfo: (NSDictionary*)userInfo;

- (void)finishOpenGLESCommands;
- (void)freeOpenGLESResources;

- (void)setOffTargetTrackingMode:(BOOL) enabled;
@end
