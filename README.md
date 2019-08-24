# ActivityReceiver.iOS
![License: Mozilla](https://img.shields.io/github/license/Neko3000/ActivityReceiver.iOS)
![Platforms: iOS](https://img.shields.io/badge/Platform-iOS-lightgrey)
![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)
![Version: v0.90](https://img.shields.io/badge/version-v1.1-lightgrey)

ActivityReceiver.iOS is a mobile application(client-side) based on iOS.</br>
It works with server-side - [ActivityReceiver](https://github.com/Neko3000/ActivityReceiver).</br>

We used Learning Records collected on mobile device while users were solving word reordering problems to calculate parameters from trajeactories produced by Drag&Drop operations. By analyzing parameters using Machine Learning, we could classfier hesitation level for each user.</br>

## Installation
Simple clone it by:

```
$ git clone https://github.com/Neko3000/ActivityReceiver.iOS
```
or download it here:</br>
<a href="https://apps.apple.com/jp/app/英単語並べ替え問題/id1461578282">
<img width="250" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/available-on-app-store-material.png" alt="screen-record-1">
</a>

## How to use
<p align="center"> 
<img width="500" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-sr1.gif" alt="screen-record-1">
<img width="500" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-sr2.gif" alt="screen-record-2">
<img width="500" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-sr3.gif" alt="screen-record-3">
</p>

<p align="center"> 
<img width="400" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-s1.png" alt="screen-shot-1">
<img width="400" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-s2.png" alt="screen-shot-2">
<img width="400" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-s3.png" alt="screen-shot-3">
<img width="400" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-s4.png" alt="screen-shot-4">
<img width="400" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-s5.png" alt="screen-shot-5">
<img width="400" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/activityreceiver-ios-s6.png" alt="screen-shot-6">
</p>

## Features
- [x] Sign In/Sign UP
- [x] Exercise Selection
- [x] Word Reordering Problems Assignment
- [x] Upload Learning Record
- [x] Drag&Drop Operation with Multiple Selection
- [x] DAcceleration/Force Retrievement
- [x] More...

## Dependencies
For handling Network requests, we used famouse [Alamofire](https://github.com/Alamofire/Alamofire) and [SwfityJSON](https://github.com/SwiftyJSON/SwiftyJSON) in this project.</br>

Pods have been included:

```
pod 'Alamofire'
pod 'NVActivityIndicatorView'
```

## Development
You should build your own server service using [ActivityReceiver](https://github.com/Neko3000/ActivityReceiver).</br>

The address of the server should be set in the beginning:
```
// RemoteServiceManager.swift
public static let domain:String = "http://..."
```

## Contact To Me
E-mail: sheran_chen@outlook.com </br>
Weibo: @妖绀

## License
Distributed under the Mozilla license. See LICENSE for more information.
