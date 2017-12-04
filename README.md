<p><img align="left" width="100" height="100" src="https://github.com/lscardinali/MatchPoint-iOS/blob/master/MatchPoint/Assets.xcassets/AppIcon.appiconset/iconnnn-1.png?raw=true"></p>
<h1>MatchPoint-iOS</h1>
<p>MatchPoint is an app that improves the way you checkin at Concrete</p>

<p align="center">
  <img width="460" height="300" src="https://github.com/lscardinali/MatchPoint-iOS/blob/master/MatchPoint/Assets.xcassets/tutorial.imageset/tutorial.png">
</p>

## Xcode Server Bots

Tab `Trigger`
`Pre-Integration Scripts`
```
#!/bin/sh
export LC_ALL="en_US.UTF-8"
PATH=$PATH:/usr/local/bin
cd "${XCS_PRIMARY_REPO_DIR}"
gem install bundler --user-install executable-hooks
bundler install
pod install
```

## Fastlane
```
fastlane scan
fastlane lint
fastlane slather
```

## What's left? (Feel free to open Pull Requests!)
- [X] Migrate from ObjectMapper to Swift 4 Codable
- [ ] Migrate from Cocoapods to Carthage
- [X] Migrate from Storyboards to ViewCode
- [X] Write unit tests
- [X] Add support Watch
- [X] Add basic UITests
