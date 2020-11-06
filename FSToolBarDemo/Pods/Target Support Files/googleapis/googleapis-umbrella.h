#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "google/api/Annotations.pbobjc.h"
#import "google/api/HTTP.pbobjc.h"
#import "google/api/Label.pbobjc.h"
#import "google/api/MonitoredResource.pbobjc.h"
#import "google/cloud/speech/v1p1beta1/CloudSpeech.pbobjc.h"
#import "google/cloud/texttospeech/v1beta1/CloudTts.pbobjc.h"
#import "google/cloud/translate/v3beta1/TranslationService.pbobjc.h"
#import "google/longrunning/Operations.pbobjc.h"
#import "google/protobuf/Descriptor.pbobjc.h"
#import "google/rpc/Code.pbobjc.h"
#import "google/rpc/ErrorDetails.pbobjc.h"
#import "google/rpc/Status.pbobjc.h"
#import "google/cloud/speech/v1p1beta1/CloudSpeech.pbrpc.h"
#import "google/cloud/texttospeech/v1beta1/CloudTts.pbrpc.h"
#import "google/cloud/translate/v3beta1/TranslationService.pbrpc.h"
#import "google/longrunning/Operations.pbrpc.h"

FOUNDATION_EXPORT double googleapisVersionNumber;
FOUNDATION_EXPORT const unsigned char googleapisVersionString[];

