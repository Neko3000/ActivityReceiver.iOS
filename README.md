# StarryTarget
![License: Mozilla](https://img.shields.io/github/license/Neko3000/ActivityReceiver.iOS)
![Platforms: iOS](https://img.shields.io/badge/Platform-iOS-lightgrey)
![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)
![Version: v0.90](https://img.shields.io/badge/version-v1.1-lightgrey)

ActivityReceiver.iOS is a mobile application based on iOS.</br>
This is the client side of ActivityReceiver, users need to solve word reordering problems, and Learning Records including Acceleration/Force would be uploaded to server side triggered by ActivityReceiver.</br>
</br>

## Installation
Simple clone it by:

```
$ git clone https://github.com/Neko3000/ActivityReceiver.iOS
```
Or</br>
<a href="https://apps.apple.com/jp/app/英単語並べ替え問題/id1461578282">
<img width="250" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/available-on-app-store-material.png" alt="screen-record-1">
</a>

## How to use
<p align="center"> 
<img width="300" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-sr1.gif" alt="screen-record-1">
<img width="300" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-sr2.gif" alt="screen-record-2">
</p>

<p align="center"> 
<img src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-s1.png" width="200" alt="">
<img src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-s2.png" width="200" alt="">
<img src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-s3.png" width="200" alt="">
<img src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-s4.png" width="200" alt="">
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
You should build your own server using [ActivityReceiver]().</br>

Here's the path:
```
// RealmManager.swift
print(Realm.Configuration.defaultConfiguration.fileURL!)
```

## Contact To Me
E-mail: sheran_chen@outlook.com </br>
Weibo: @妖绀

## License
Distributed under the MIT license. See LICENSE for more information.
