# Layout Expressions [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Travis CI](https://api.travis-ci.org/stevebrambilla/LayoutExpressions.svg?branch=master)](https://travis-ci.org/stevebrambilla/LayoutExpressions)

LayoutExpressions is a lightweight and easy-to-use library for Auto Layout, designed for Swift. It lets you describe Auto Layout constraints expressively and with type safety, so you can add layout constraints like this:

```swift
view.addLayoutExpression( subviewB.anchors.left >= subviewA.anchors.right + 10 )
```

...instead of this:

```swift
let constraint = NSLayoutConstraint(item: subviewB,
                               attribute: .left,
                               relatedBy: .greaterThanOrEqual,
                                  toItem: subviewA,
                               attribute: .right,
                              multiplier: 1.0,
                                constant: 10.0)
view.addConstraint(constraint)
```

## Usage

Add `NSLayoutConstraints` to your views by coding your constraints as `view1.attribute1 == view2.attribute2 × multiplier + constant`.
You can use any of `==`, `>=`, or `<=` as relations, and you can omit the multiplier and constant if they aren't needed (they default to `× 1.0` and `+ 0.0`):

```swift
// A basic layout expression for the y-axis:
view.addLayoutExpression( subview.anchors.top == container.anchors.top )

// With multiplier and constant:
view.addLayoutExpression( subview2.anchors.width >= subview1.anchors.width * 2 + 10 )
```

Multiple expressions can be grouped together in the same function call. The `NSLayoutConstraints` are returned so you can keep a reference to them:

```swift
self.constraints = container.addLayoutExpression(
    subview.anchors.top == container.anchors.top + 10,
    subview.anchors.left == container.anchors.left + 15,
    subview.anchors.bottom == container.anchors.bottom - 10,
    subview.anchors.right == container.anchors.right - 15
)
```

Set priorities for your constraints by using the `<~` operator after your expression. Priorities can be `.required`, `.defaultHigh`, `.defaultLow`, `.fittingSizeLevel`, or any number `0...1000`:

```swift
view.addLayoutExpression( subview1.anchors.width >= subview2.anchors.width <~ .defaultHigh )
```

LayoutExpressions provides the following UIKit extensions for layout anchors:

UIView Anchors               | UILayoutGuide Anchors    |
-----------------------------|--------------------------|
`view.anchors.top`           | `guide.anchors.top`      |
`view.anchors.bottom`        | `guide.anchors.bottom`   |
`view.anchors.leading`       | `guide.anchors.leading`  |
`view.anchors.trailing`      | `guide.anchors.trailing` |
`view.anchors.left`          | `guide.anchors.left`     |
`view.anchors.right`         | `guide.anchors.right`    |
`view.anchors.centerX`       | `guide.anchors.centerX`  |
`view.anchors.centerY`       | `guide.anchors.centerY`  |
`view.anchors.width`         | `guide.anchors.width`    |
`view.anchors.height`        | `guide.anchors.height`   |
`view.anchors.firstBaseline` |                          |
`view.anchors.lastBaseline`  |                          |

As well as convenience shorthands for accessing anchors for common layout guides:

**UIView**

------------------------|----------------------------|
 Layout Margins         |  `view.anchors.margins.*`  |
 Readable Content Guide |  `view.anchors.readable.*` |

These shorthands can further simplify layout expressions that use layout guides, for example: `subview.anchors.left == container.anchors.margins.left`

### Composite Expressions

LayoutExpressions makes common layout patterns even easier with composite expressions. Composite expressions are expressions that evaluate to more than one `NSLayoutConstraint`.

For example, `subview.anchors.edges == container.anchors.edges` will pin all edges of `subview` to `container`. This expression evaluates to four distinct `NSLayoutConstraints`, one for each edge. Use them to make your code even more concise and clear.

LayoutExpressions provides the following UIKit extensions for _composite_ layout anchors:

UIView Anchors        | UILayoutGuide Anchors  |
----------------------|------------------------|
`view.anchors.edges`  | `guide.anchors.edges`  |
`view.anchors.center` | `guide.anchors.center` |
`view.anchors.size`   | `guide.anchors.size`   |

#### Edges

`view.anchors.edges` evaluates to constraints for `.top`, `.left`, `.bottom`, and `.right`. All relations are supported: `==`, `>=`, `<=`.

```swift
// Pin the edges of subview to container.
subview.anchors.edges == container.anchors.edges

// Use the '-' operator to inset the top and bottom edges of subview by 10 pts, and the right and left edges by 20 pts.
subview.anchors.edges == container.anchors.edges - Insets(top: 10, left: 20, bottom: 10, right: 20)

// Use the '-' operator to inset all edges of subview by 10 pts.
subview.anchors.edges == container.anchors.edges - 10.0
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

If you’re using [Carthage](https://github.com/Carthage/Carthage), simply add LayoutExpressions to your `Cartfile`:

```
github "stevebrambilla/LayoutExpressions"
```

Otherwise, you can manually install it by following these steps:

1. Add the LayoutExpressions repository as a submodule of your project's repository.
2. Drag and drop **LayoutExpressions.xcodeproj** into your Xcode project or workspace.
3. In the “General” tab of your application target’s settings, add `LayoutExpressions.framework` to the “Embedded Binaries” section.

Now `import LayoutExpressions` and you're all set.

## Contact

- [Steve Brambilla](http://github.com/stevebrambilla)

## License

LayoutExpressions is available under the MIT license. See the LICENSE file for more info.