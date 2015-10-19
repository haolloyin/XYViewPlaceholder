XYViewPlaceholder
----

A simple solution to set a placeholder or show UIView's size. It's a Swift version of [MMPlaceHolder](https://github.com/adad184/MMPlaceHolder), which written in objc (Now `MMPlaceHolder` has its own official Swfit version [XXPlaceHolder](https://github.com/adad184/XXPlaceHolder)).

Please see the original [MMPlaceHolder](https://github.com/adad184/MMPlaceHolder) for more introduction.

`XYViewPlaceholder` implemented by using [method swizzling](http://nshipster.com/swift-objc-runtime/) (中文翻译[见这里](http://nshipster.cn/swift-objc-runtime/)).

### Screenshot
----

![screenshots](https://raw.githubusercontent.com/haolloyin/XYViewPlaceholder/master/Screenshot.png)


### Installation
----

Just drag `XYViewPlaceholder.swift` file to your Swfit project.


### Usage
----

Simply write one line code.

```Swift

yourView.showPlaceholder()
```

or customize yourself.

```Swift

// show
showPlaceholderWith(lineColor: UIColor)
showPlaceholderWith(lineColor: UIColor, backColor: UIColor)
showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat)
showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat, lineWidth: CGFloat)
showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat, lineWidth: CGFloat, frameWidth: CGFloat, frameColor: UIColor)

// show all sub views
yourView.showPlaceholderWithAllSubviews()    
yourView.showPlaceHolderWithAllSubviewsWith(maxPath: UInt)

// hide
yourView.hidePlaceholder()
yourView.hidePlaceholderWithAllSubviews()

// remove
yourView.removePlaceholder()    
yourView.removePlaceholderWithAllSubviews()
```


### Issues
----

~~Fix hide and remove placeholders.~~(Thanks [@adad184](https://github.com/adad184) for telling me this bug)


### License
----

This code is distributed under the terms and conditions of the MIT license.