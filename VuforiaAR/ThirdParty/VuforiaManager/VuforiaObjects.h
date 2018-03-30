//
//  VuforiaObjects.h
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

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VuforiaTrackableResultStatus) {
    VuforiaTrackableResultStatus_Unknown,            ///< The state of the TrackableResult is unknown
    VuforiaTrackableResultStatus_Undefined,          ///< The state of the TrackableResult is not defined
    ///< (this TrackableResult does not have a state)
    VuforiaTrackableResultStatus_Detected,           ///< The TrackableResult was detected
    VuforiaTrackableResultStatus_Tracked,            ///< The TrackableResult was tracked
    VuforiaTrackableResultStatus_Extended_tracked    ///< The Trackable Result was extended tracked
};

@interface VuforiaFrame : NSObject
@end

@interface VuforiaTrackable : NSObject

@property (nonatomic, readonly)NSInteger identifier;
@property (nonatomic, readonly)NSString* name;

@end

@interface VuforiaTrackableResult : NSObject

@property (nonatomic, readonly)NSTimeInterval timeStamp;
@property (nonatomic, readonly)VuforiaTrackableResultStatus status;
@property (nonatomic, readonly)VuforiaTrackable* trackable;

@end

@interface VuforiaState : NSObject

@property (nonatomic, readonly)VuforiaFrame* frame;
@property (nonatomic, readonly)int numberOfTrackables;
@property (nonatomic, readonly)int numberOfTrackableResults;


- (VuforiaTrackable*)trackableAtIndex:(int)index;
- (VuforiaTrackableResult*)trackableResultAtIndex:(int)index;

@end

