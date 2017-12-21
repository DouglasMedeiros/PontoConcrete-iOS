[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=5a144ecae2978a000134c466&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/5a144ecae2978a000134c466/build/latest?branch=master)
<p><img align="left" width="100" height="100" src="https://github.com/lscardinali/PontoConcrete-iOS/blob/master/PontoConcrete/Assets.xcassets/AppIcon.appiconset/iconnnn-1.png?raw=true"></p>
<h1>PontoConcrete</h1> 
<p>PontoConcrete is an iOS app that improves the way you check-in at Concrete</p>

<p align="center">
  <img width="460" height="300" src="https://github.com/lscardinali/PontoConcrete-iOS/blob/master/PontoConcrete/Assets.xcassets/tutorial.imageset/tutorial.png">
</p>

## Start

After cloning this repo, you should run ```carthage bootstrap``` to begin working on the project

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
