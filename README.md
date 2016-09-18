# Codeditor-IOS
[![Build Status](https://travis-ci.org/QKTeam/Codeditor-IOS.svg?branch=master)](https://travis-ci.org/QKTeam/Codeditor-IOS)

<a href="https://itunes.apple.com/app/codeditor/id1147022827"><img src="http://blog.qkteam.com/resources/AppStoreBadge.png" width="150px"></a>

## Introduction
<img src="https://raw.githubusercontent.com/QKTeam/Codeditor-IOS/master/doc/AppIcon.png" width="150px">

Code Editor for iOS

You can use it to easily edit code with highlight and auto indent. Compiling will also be supported in the future!

## Url Scheme
If you want to open `Codeditor` in your app and create a code file at the same time, use the following url scheme:
```
codeditor://new/language/code
```
`language` and `code` both need `base64(with url safe)` encode, an example below
```
NSString* base64Encode(NSString* str) {
    NSData* base64Data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [base64Data base64EncodedStringWithOptions:0];
}
NSString* base64EncodeUrlsafe(NSString* str) {
    NSString* strBase64 = base64Encode(str);
    return [strBase64 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
}


NSURL* url = [NSURL URLWithString:STRF(@"codeditor://new/%@/%@", base64EncodeUrlsafe(filename), base64EncodeUrlsafe(content))];
if([[UIApplication sharedApplication] canOpenURL:url]) {
    [[UIApplication sharedApplication] openURL:url];
}
```

## Features
- [x] Grammar highlight
- [x] Auto indent
- [ ] compile code online
- [ ] compile code offline
- [ ] Vim/Emacs mode

## Languages supported
- [x] C/C++
- [x] Pascal
- [x] Java
- [ ] Markdown

## Feedback
http://www.qkteam.com/feedback?project=codeditor-ios
