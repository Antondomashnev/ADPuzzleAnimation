## 1.0.0 (2016-05-10)

##### Enhancements

* None.  

##### Bug Fixes

* Don't print the invocation of `/bin/date`.  
  [Samuel Giddins](https://github.com/segiddins)


## 1.0.0.rc.1 (2016-04-30)

##### Enhancements

* Make the error loading a specification during `pod trunk push` more
  informative.  
  [Samuel Giddins](https://github.com/segiddins)
  [#63](https://github.com/CocoaPods/cocoapods-trunk/issues/63)

##### Bug Fixes

* None.  


## 1.0.0.beta.4 (2016-04-15)

##### Enhancements

* None.  

##### Bug Fixes

* Compatibility With CocoaPods 1.0.0.beta.8.  
  [Samuel Giddins](https://github.com/segiddins)
  [#61](https://github.com/CocoaPods/cocoapods-trunk/issues/61)


## 1.0.0.beta.3 (2016-04-14)

##### Enhancements

* The failure reason is printed when validation fails during `pod trunk push`.  
  [Samuel Giddins](https://github.com/segiddins)
  [CocoaPods#5073](https://github.com/CocoaPods/CocoaPods/issues/5073)

##### Bug Fixes

* None.  


## 1.0.0.beta.2 (2016-02-03)

##### Bug Fixes

* Send a body with the `PATCH` request to deprecate a pod.  
  [Samuel Giddins](https://github.com/segiddins)
  [#52](https://github.com/CocoaPods/cocoapods-trunk/issues/52)


## 1.0.0.beta.1 (2015-12-30)

##### Enhancements

* The `pod deprecate PODNAME` command has been added to deprecate all versions
  of a pod.  
  [Samuel Giddins](https://github.com/segiddins)
  [#31](https://github.com/CocoaPods/cocoapods-trunk/issues/31)

* The `pod delete PODNAME VERSION` command has been added to delete a single
  version of a pod.  
  [Samuel Giddins](https://github.com/segiddins)

##### Bug Fixes

* If the master repo has not been setup when pushing a spec, run `pod setup`
  instead of failing.  
  [Samuel Giddins](https://github.com/segiddins)
  [#48](https://github.com/CocoaPods/cocoapods-trunk/issues/48)


## 0.6.4 (2015-08-28)

##### Bug Fixes

* This release fixes installation compatibility issues when using the RubyGem
  due to an incompatible dependency on `nap`.  
  [Samuel Giddins](https://github.com/segiddins)


## 0.6.3 (2015-08-28)

##### Bug Fixes

* This release fixes a file permissions error when using the RubyGem.  
  [Samuel Giddins](https://github.com/segiddins)


## 0.6.2 (2015-08-26)

##### Enhancements

* The `--allow-warnings` flag to `pod trunk push` is now propagated to the trunk
  server.  
  [Samuel Giddins](https://github.com/segiddins)
  [CocoaPods#3855](https://github.com/CocoaPods/CocoaPods/issues/3855)


## 0.6.1 (2015-05-27)

##### Enhancements

* The `master` specs repo is updated before and after pushing a new spec to
  trunk.  
  [Samuel Giddins](https://github.com/segiddins)
  [#43](https://github.com/CocoaPods/cocoapods-trunk/issues/43)


## 0.6.0 (2015-03-11)

##### Enhancements

* Allow specifying a Trunk token via the `COCOAPODS_TRUNK_TOKEN` environment
  variable.  
  [Samuel Giddins](https://github.com/segiddins)
  [CocoaPods#3224](https://github.com/CocoaPods/CocoaPods/issues/3224)


## 0.5.1 (2015-02-25)

##### Enhancements

* Lint as a framework automatically. If needed, the `--use-libraries`
  option allows linting as a static library.  
  [Boris Bügling](https://github.com/neonichu)
  [#2912](https://github.com/CocoaPods/CocoaPods/issues/2912)

##### Bug Fixes

* Fix the detection of spec validation errors, and present the proper error
  (and messages) to the user.  
  [Orta Therox](https://github.com/orta)
  [#39](https://github.com/CocoaPods/cocoapods-trunk/issues/39)


## 0.5.0 (2014-12-25)

##### Enhancements

* Added `pod trunk remove-owner` command to remove an owner from a pod.  
  [Samuel Giddins](https://github.com/segiddins)
  [#35](https://github.com/CocoaPods/cocoapods-trunk/issues/35)

* Added `pod trunk info` command to get information for a pod, including the
  owners.  
  [Kyle Fuller](https://github.com/kylef)
  [#15](https://github.com/CocoaPods/cocoapods-trunk/issues/15)


## 0.4.1 (2014-11-19)

##### Enhancements

* Improved code readability and structure by splitting subcommands
  into individual files.  
  [Olivier Halligon](https://github.com/alisoftware)
  [#21](https://github.com/CocoaPods/CocoaPods/issues/21)

##### Bug Fixes

* Updates for changes in CocoaPods regarding `--allow-warnings`.  
  [Kyle Fuller](https://github.com/kylef)
  [Cocoapods#2831](https://github.com/CocoaPods/CocoaPods/pull/2831)


## 0.4.0 (2014-11-06)

##### Bug Fixes

* Fixes installation issues with the JSON dependency.  
  [Eloy Durán](https://github.com/alloy)
  [CocoaPods#2773](https://github.com/CocoaPods/CocoaPods/issues/2773)

## 0.3.1 (2014-10-15)

##### Bug Fixes

* Fixes an issue introduced with the release of `netrc 0.7.8`.  
  [Samuel Giddins](https://github.com/segiddins)
  [CocoaPods#2674](https://github.com/CocoaPods/CocoaPods/issues/2674)


## 0.3.0 (2014-10-07)

##### Enhancements

* When linting, only allow dependencies from the 'master' specs repository.  
  [Samuel Giddins](https://github.com/segiddins)
  [#28](https://github.com/CocoaPods/cocoapods-trunk/issues/28)

##### Bug Fixes

* Fixes an issue where `pod trunk push` doesn't show which validation errors
  and just stated it failed.  
  [Kyle Fuller](https://github.com/kylef)
  [#26](https://github.com/CocoaPods/cocoapods-trunk/issues/26)


## 0.2.0 (2014-09-11)

##### Enhancements

* Network errors are now gracefully handled.  
  [Samuel E. Giddins](https://github.com/segiddins)

* Adopted new argument format of CLAide.  
  [Olivier Halligon](https://github.com/AliSoftware)


## 0.1.0 (2014-05-19)

* Initial release.
