# Layout Expressions

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-orange.svg)](#swift-package-manager) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Travis CI](https://api.travis-ci.org/stevebrambilla/LayoutExpressions.svg?branch=master)](https://travis-ci.org/stevebrambilla/LayoutExpressions)

LayoutExpressions is a lightweight and easy-to-use library for defining Auto Layout constraints, designed for Swift. It lets you describe constraints expressively and with type safety:

```swift
NSLayoutConstraint.activateLayout {
    subviewB.anchors.allEdges == subviewA.anchors.allEdges - 10
}
```

instead of:

```swift
let top = subview.topAnchor.constraint(equalTo: container.topAnchor, constant: 10)
let bottom = subview.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
let leading = subview.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10)
let trailing = subview.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
NSLayoutConstraint.activate([top, bottom, leading, trailing])
```

This example uses a _Composite Expression_ to create four constraints from a single expression. More details below.

## Usage

Add `NSLayoutConstraints` to your views by typing your constraints as `view1.attribute1 == view2.attribute2 × multiplier + constant`.
You can use any of `==`, `>=`, or `<=` as relations, and you can omit the multiplier and constant if they aren't needed:

```swift
// A basic layout expression for the y-axis:
subview.anchors.top == container.anchors.top

// With multiplier and constant:
subview2.anchors.width >= subview1.anchors.width * 2 + 10
```

LayoutExpressions supports Swift 5.1 function builders, allowing you to easily create dynamic layouts:

```swift
NSLayoutConstraint.activateLayout {
    if pinTopAndBottomToSafeArea {
        subview.anchors.verticalEdges == container.anchors.safeArea.verticalEdges
    } else {
        subview.anchors.verticalEdges == container.anchors.verticalEdges
    }
    subview.anchors.horizontalEdges == container.anchors.horizontalEdges
)
```

To access the constraints without activating them you can use `evaluateLayout()` instead of `activateLayout()`:

```swift
let constraints = NSLayoutConstraint.evaluateLayout {
    subview.anchors.center == container.anchors.center
}
// `constraints` contains a .centerX constraint and a .centerY constraint
```

Set priorities for your constraints by using the `<~` operator after your expression:

```swift
subview1.anchors.width >= subview2.anchors.width <~ .defaultHigh
```

LayoutExpressions provides the following extensions for layout anchors:

View Anchors                 |  Layout Guide Anchors      |
-----------------------------|----------------------------|
`view.anchors.top`           | `guide.anchors.top`        |
`view.anchors.bottom`        | `guide.anchors.bottom`     |
`view.anchors.leading`       | `guide.anchors.leading`    |
`view.anchors.trailing`      | `guide.anchors.trailing`   |
`view.anchors.left`          | `guide.anchors.left`       |
`view.anchors.right`         | `guide.anchors.right`      |
`view.anchors.centerX`       | `guide.anchors.centerX`    |
`view.anchors.centerY`       | `guide.anchors.centerY`    |
`view.anchors.width`         | `guide.anchors.width`      |
`view.anchors.height`        | `guide.anchors.height`     |
`view.anchors.firstBaseline` |                            |
`view.anchors.lastBaseline`  |                            |

As well as convenience shorthands for accessing the anchors of common layout guides:

UIView                  |                           |
------------------------|---------------------------|
Safe Area               | `view.anchors.safeArea.*` |
Layout Margins          | `view.anchors.margins.*`  |
Readable Content Guide  | `view.anchors.readable.*` |

These shorthands can further simplify layout expressions that use layout guides, for example: `subview.anchors.top == container.anchors.safeArea.top`

### Composite Expressions

LayoutExpressions makes common layout patterns even easier with composite expressions. Composite expressions are expressions that evaluate to more than one `NSLayoutConstraint`.

For example, `subview.anchors.allEdges == container.anchors.allEdges` will pin all edges of `subview` to `container`. This expression evaluates to four distinct `NSLayoutConstraints` -- one for each edge. Use them to make your code even more concise and clear.

LayoutExpressions provides the following extensions for _composite_ layout anchors:

View Anchors                    | LayoutGuide Anchors              |
--------------------------------|----------------------------------|
`view.anchors.allEdges`         | `guide.anchors.allEdges`         |
`view.anchors.verticalEdges`    | `guide.anchors.verticalEdges`    |
`view.anchors.horizontalEdges`  | `guide.anchors.horizontalEdges`  |
`view.anchors.center`           | `guide.anchors.center`           |
`view.anchors.size`             | `guide.anchors.size`             |

#### Edges

`view.anchors.allEdges` evaluates to constraints for `.top`, `.bottom`, `.leading`, and `.trailing`. All relations are supported: `==`, `>=`, `<=`.

```swift
// Pin the edges of subview to container.
subview.anchors.allEdges == container.anchors.allEdges

// Use the '-' operator to inset all edges of subview by 10 pts.
subview.anchors.allEdges == container.anchors.allEdges - 10
```

`view.anchors.verticalEdges` evaluates to constraints for `.top` and `.bottom`; and `view.anchors.horizontalEdges` evaluates to constraints for `.leading` and `.trailing`. All relations are supported: `==`, `>=`, `<=`.

```swift
// Pin the vertical edges of subview to the container's safe area.
subview.anchors.verticalEdges == container.anchors.allEdges

// Pin the horizontal edges of subview to the container, inset by 10 pts.
subview.anchors.horizontalEdges == container.anchors.horizontalEdges - 10
```

#### Size

`view.anchors.size` evaluates to constraints for `.width` and `.height`. All relations are supported: `==`, `>=`, `<=`.

```swift
// Pin the size of subview to the size of container.
subview.anchors.size == container.anchors.size

// Pin the size of subview to the size of container, with an offset.
subview.anchors.size == container.anchors.size + Size(width: -20, height: -10)

// Pin the size of subview to a fixed size.
subview.anchors.size == Size(width: 320, height: 200)
```

#### Center

`anchors.center` evaluates to constraints for `.centerX` and `.centerY`. Only the `==` relation is supported.

```swift
// Pin the center of subview to the center of container.
subview.anchors.center == container.anchors.center

// Pin the center of subview to the center of container, with an offset.
subview.anchors.center == container.anchors.center + Offset(horizontal: 0, vertical: -10)
```

## Installation

LayoutExpressions supports macOS 10.13+, iOS 9.0+, and tvOS 9.0+.

### Swift Package

In Xcode 11, use the repository URL in the Swift Packages screen:

```text
https://github.com/stevebrambilla/LayoutExpressions
```

### Carthage

If you’re using [Carthage](https://github.com/Carthage/Carthage), simply add LayoutExpressions to your `Cartfile`:

```
github "stevebrambilla/LayoutExpressions" ~> 2.0
```

## Contact

- [Steve Brambilla](http://github.com/stevebrambilla)

## License

LayoutExpressions is available under the MIT license. See the LICENSE file for more info.
