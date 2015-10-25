# Layout Expressions [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

LayoutExpressions is a lightweight and easy-to-use framework for Auto Layout, designed for Swift.
Its DSL lets you describe Auto Layout constraints expressively, so you can write them like this:

```swift
view.addLayoutExpression( subviewB.lexLeft >= subviewA.lexRight + 10 )
```

...instead of this:

```swift
let constraint = NSLayoutConstraint(item: subviewB,
                               attribute: .Left,
                               relatedBy: .GreaterThanOrEqual,
                                  toItem: subviewA,
                               attribute: .Right,
                              multiplier: 1.0,
                                constant: 10.0)
view.addConstraint(constraint)
```

## Usage

Add `NSLayoutConstraints` to your views by coding your constraints as `view1.attribute1 == multiplier × view2.attribute2 + constant`.
You can use any of `==`, `>=`, or `<=` as relations, and you can omit the multiplier and constant if they aren't needed (they default to `× 1.0` and `+ 0.0`):

```swift
// A basic expression:
view.addLayoutExpression( subview.lexTop == container.lexTop )

// With multiplier and constant:
view.addLayoutExpression( subview2.lexWidth >= 2.0 * subview1.lexWidth + 10 )
```

Multiple expressions can be grouped together in the same call. The `NSLayoutConstraints` are returned so you can keep a reference to them:

```swift
self.constraints = container.addLayoutExpression(
    subview.lexTop == container.lexTop + 10,
    subview.lexLeft == container.lexLeft + 15,
    subview.lexBottom == container.lexBottom - 10,
    subview.lexRight == container.lexRight - 15
)
```

Set priorities for your constraints by using the `<~` operator after your expression. Priorities can be `.Required`, `.DefaultHigh`, `.DefaultLow`, `.FittingSizeLevel`, or any integer `0...1000`:

```swift
view.addLayoutExpression( subview1.lexWidth >= subview2.lexWidth <~ .DefaultHigh )
```

LayoutExpressions provides the following `UIView` properties to use as arguments:

`UIView` Property      | `NSLayoutAttribute`
-----------------------|------------------
`view.lexTop`          | `.Top`
`view.lexLeft`         | `.Left`
`view.lexBottom`       | `.Bottom`
`view.lexRight`        | `.Right`
`view.lexLeading`      | `.Leading`
`view.lexTrailing`     | `.Trailing`
`view.lexCenterX`      | `.CenterX`
`view.lexCenterY`      | `.CenterY`
`view.lexWidth`        | `.Width`
`view.lexHeight`       | `.Height`
`view.lexBaseline`     | `.Baseline`

### Composite Expressions

LayoutExpressions makes common layout patterns even easier with composite expressions.
Composite expressions are expressions that evaluate to more than one `NSLayoutConstraint`.

For example, `subview.lexEdges == container.lexEdges` will pin all edges of `subview` to `container`. 
This expression evaluates to four distinct `NSLayoutConstraints`: one for each edge. Use them to make your code even more concise and clear.

#### Edges

`view.lexEdges` evaluates to constraints for `.Top`, `.Left`, `.Bottom`, and `.Right`. All relations are supported: `==`, `>=`, `<=`.

```swift
// Pin the edges of subview to container.
subview.lexEdges == container.lexEdges

// Use the '-' operator to inset the top and bottom edges of subview by 10 pts, and the right and left edges by 20 pts.
subview.lexEdges == container.lexEdges - EdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

// Use the '-' operator to inset all edges of subview by 10 pts.
subview.lexEdges == container.lexEdges - 10.0
```

#### Size

`view.lexSize` evaluates to constraints for `.Width` and `.Height`. All relations are supported: `==`, `>=`, `<=`.

```swift
// Pin the size of subview to the size of container.
subview.lexSize == container.lexSize

// Pin the size of subview to the size of container, with an offset.
subview.lexSize == container.lexSize + SizeOffset(width: -20, height: -10)

// Pin the size of subview to a fixed size.
subview.lexSize == CGSize(width: 320, height: 200)
```

#### Center

`lexCenter` evaluates to constraints for `.CenterX` and `.CenterY`. Only the `==` relation is supported.

```swift
// Pin the center of subview to the center of container.
subview.lexCenter == container.lexCenter

// Pin the center of subview to the center of container, with an offset.
subview.lexCenter == container.lexCenter + PointOffset(horizontal: 0, vertical: -10)
```

### Layout Guides

`UIViewController` has layout guides for its top and bottom edges to assist with Auto Layout. Layout guides are objects that conform to the `UILayoutSupport` protocol.
There are two ways to use layout guides in your expressions:

#### UIViewController Extensions

If you're using UIViewController's `topLayoutGuide` or `bottomLayoutGuide`, you can use the `lex`-prefixed equivalents in your expressions:

```swift
subview.lexTop == viewController.lexTopLayoutGuide
```

The expression will use the layout guide's _opposite_ attribute as the `NSLayoutConstraint`'s `secondAttribute`. This example would evaluate to `subview.top == topLayoutGuide.bottom`.

The "_opposite_" attributes map to `NSLayoutAttributes` as follows:

Layout Guide                | `secondAttribute`
----------------------------|-----------------------------
`.lexTopLayoutGuide`        | `.Bottom`
`.lexBottomLayoutGuide`     | `.Top`

#### UILayoutSupport Extensions

Alternatively, you can use the `UILayoutSupport` arguments directly:

`UILayoutSupport` Property  | NSLayoutAttribute
----------------------------|------------------
`layoutGuide.lexTop`        | `.Top`
`layoutGuide.lexBottom`     | `.Bottom`

## Installation

If you’re using [Carthage](https://github.com/Carthage/Carthage), simply add
LayoutExpressions to your `Cartfile`:

```
github "stevebrambilla/LayoutExpressions"
```

Otherwise, you can manually install it by following these steps:

1. Add the LayoutExpressions repository as a submodule of your project's repository.
2. Drag and drop **LayoutExpressions.xcodeproj** into your Xcode project or workspace.
3. In the “General” tab of your application target’s settings, add `LayoutExpressions.framework` to the “Embedded Binaries” section.

Now `import LayoutExpressions` and you're all set.

## TODO

- Add support for OS X.

## Contact

- [Steve Brambilla](http://github.com/stevebrambilla)

## License

LayoutExpressions is available under the MIT license. See the LICENSE file for more info.