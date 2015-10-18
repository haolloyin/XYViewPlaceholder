XYViewPlaceholder
----

A simple solution to set a placeholder or show UIView's size, written in Swift.

`XYViewPlaceholder` is a Swift version of [MMPlaceHolder](https://github.com/adad184/MMPlaceHolder), which written in objc (Thanks [@adad184](https://github.com/adad184)).

See the original [MMPlaceHolder](https://github.com/adad184/MMPlaceHolder) for more introduction.

`XYViewPlaceholder` implemented by using [method swizzling](http://nshipster.com/swift-objc-runtime/) (中文翻译[见这里](http://nshipster.cn/swift-objc-runtime/)).

### Screenshot
----

![screenshots](https://raw.githubusercontent.com/haolloyin/XYViewPlaceholder/master/Screenshot.png)


### Installation
----

Just drag `XYViewPlaceholder.swift` file to your Swfit project.


### Usage
----

```Swift

// show
yourView.showPlaceholder()
yourView.showPlaceholderWith(lineColor: UIColor)
yourView.showPlaceholderWith(lineColor: UIColor, backColor: UIColor)
yourView.showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat)
yourView.showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat, lineWidth: CGFloat)
yourView.showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat, lineWidth: CGFloat, frameWidth: CGFloat, frameColor: UIColor)

// show all sub views
yourView.showPlaceholderWithAllSubviews()    
yourView.showPlaceHolderWithAllSubviewsWith(maxPath: UInt)

// TODO: hide
yourView.hidePlaceholder()
yourView.hidePlaceholderWithAllSubviews()

// TODO: remove
yourView.removePlaceholder()    
yourView.removePlaceholderWithAllSubviews()
```


### Issues
----

Fix hide and remove placeholders.


### License
----

This code is distributed under the terms and conditions of the MIT license.