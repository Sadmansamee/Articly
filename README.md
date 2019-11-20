[![codebeat badge](https://codebeat.co/badges/a2daf8ab-0a7a-427a-a18d-fb490aec1017)](https://codebeat.co/projects/github-com-sadmansamee-nybestarticles-master)

# Articly
 
* This project was written and tested using **Xcode 11.2.1**, so if it doesn’t compile with previous version of Xcode then please upgarde to **Xcode 11.2.1**.
* This project used [Cocoapod](https://cocoapods.org/) **1.8.4** as a dependency manager.
* This project loads most viewed articles from [NyTimes](https://developer.nytimes.com/) with [most popular APIs](https://developer.nytimes.com/docs/most-popular-product/1/overview). Obtain your own API-KEY and [replace here](https://github.com/Sadmansamee/NyBestArticles/blob/master/NyBestArticles/Shared/Constant/K%2BCredential.swift).(Temporaray it is there for easiness purpose for the reviewer team).

![](demo.gif)


## This project has the following:
* Every pull request,master branch was checked with [Codebeat](https://codebeat.co/). 
* MVVM design pattern.
* [Coordinator pattern](https://www.raywenderlich.com/158-coordinator-tutorial-for-ios-getting-started) for navigation.
* [Quick](https://github.com/Quick/Quick) and [Nimble](https://github.com/Quick/Nimble) for Unit-Test.
* Dependency Injection with [Swinject](https://github.com/Swinject/Swinject)
* [RxSwift](https://github.com/ReactiveX/RxSwift) for MVVM binding.
* [Moya](https://github.com/Moya/Moya) for API call.
* [Realm](https://realm.io/) for persistant storage.
* iOS 13 Dark Mode supported


## How to run
* Clone this project.
* Open your terminal
* **CD** to project folder.
* run ```pod install``` or [bundler](https://bundler.io/) is also configured with this project, for that follow [this instruction](https://mikebuss.com/2017/01/21/dependencies-crash-course/) then run ```bundler exec pod install``` on terminal. 
* Open ```.xcworkspace``` file.
