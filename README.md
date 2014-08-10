# Layout Expressions

LayoutExpressions is a lightweight and easy-to-use framework for Auto Layout, designed for Swift.
Its DSL lets you describe constraints rather expressively, so you can write them like this:

```swift
view.lex_addExpression( subviewB.lex_left >= subviewA.lex_right + 10 )
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

Add NSLayoutConstraints to your views by coding your constraints as `view1.attribute1 == multiplier × view2.attribute2 + constant`.
You can use any of `==`, `>=`, or `<=` as relations, and you can omit the multiplier and constant if they aren't needed (they default to `× 1.0` and `+ 0.0`):

```swift
// A basic expression:
view.lex_addExpression( subview.lex_top == container.lex_top )

// With multiplier and constant:
view.lex_addExpression( subview2.lex_width >= 2.0 * subview1.lex_width + 10 )
```

Multiple expressions can be grouped together in the same function call. The `NSLayoutConstraints` are returned so you can keep a reference to them:

```swift
self.constraints = container.lex_addExpressions(
    subview.lex_top == container.lex_top + 10,
    subview.lex_left == container.lex_left + 15,
    subview.lex_bottom == container.lex_bottom - 10,
    subview.lex_right == container.lex_right - 15
)
```

Set priorities for your constraints by using the `<~` operator after your expression. Priorities can be `.Required`, `.DefaultHigh`, `.DefaultLow`, `.FittingSizeLevel`, or any number `0...1000`:

```swift
view.lex_addExpression( subview1.lex_width >= subview2.lex_width <~ .DefaultHigh )
```

LayoutExpressions provides the following `UIView` properties to use as arguments:

UIView Property        | NSLayoutAttribute
-----------------------|------------------
`view.lex_top`         | `.Top`
`view.lex_left`        | `.Left`
`view.lex_bottom`      | `.Bottom`
`view.lex_right`       | `.Right`
`view.lex_leading`     | `.Leading`
`view.lex_trailing`    | `.Trailing`
`view.lex_centerX`     | `.CenterX`
`view.lex_centerY`     | `.CenterY`
`view.lex_width`       | `.Width`
`view.lex_height`      | `.Height`
`view.lex_baseline`    | `.Baseline`

### Composite Expressions

LayoutExpressions makes common layout patterns even easier with composite expressions.
Composite expressions are expressions that evaluate to more than one `NSLayoutConstraint`.

For example, `subview.lex_edges == container.lex_edges` will pin all edges of `subview` to `container`. 
This expression evaluates to four distinct `NSLayoutConstraints`: one for each edge. Use them to make your code even more concise and clear.

#### Edges

`view.lex_edges` evaluates to constraints for `.Top`, `.Left`, `.Bottom`, and `.Right`. All relations are supported: `==`, `>=`, `<=`.

```swift
// Pin the edges of subview to container.
subview.lex_edges == container.lex_edges

// Use the '-' operator to inset the top and bottom edges of subview by 10 pts, and the right and left edges by 20 pts.
subview.lex_edges == container.lex_edges - EdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

// Use the '-' operator to inset all edges of subview by 10 pts.
subview.lex_edges == container.lex_edges - 10.0
```

#### Size

`view.lex_size` evaluates to constraints for `.Width` and `.Height`. All relations are supported: `==`, `>=`, `<=`.

```swift
// Pin the size of subview to the size of container.
subview.lex_size == container.lex_size

// Pin the size of subview to the size of container, with an offset.
subview.lex_size == container.lex_size + SizeOffset(width: -20, height: -10)

// Pin the size of subview to a fixed size.
subview.lex_size == CGSize(width: 320, height: 200)
```

#### Center

`lex_center` evaluates to constraints for `.CenterX` and `.CenterY`. Only the `==` relation is supported.

```swift
// Pin the center of subview to the center of container.
subview.lex_center == container.lex_center

// Pin the center of subview to the center of container, with an offset.
subview.lex_center == container.lex_center + PointOffset(horizontal: 0, vertical: -10)
```

### Layout Guides

UIViewController has layout guides for each edge to assist with Auto Layout. Layout guides are objects that conform to the `UILayoutSupport` protocol.
There are two ways to use layout guides in your expressions:

#### UIViewController Extensions

If you're using UIViewController's `topLayoutGuide`, `bottomLayoutGuide`, `leftLayoutGuide`, or `rightLayoutGuide`, you can use the `lex_`-prefixed equivalents in your expressions:

```swift
subview.lex_top == viewController.lex_topLayoutGuide
```

The expression will use the layout guide's _opposite_ attribute as the `NSLayoutConstraint`'s `secondAttribute`. This example would evaluate to `subview.top == topLayoutGuide.bottom`.

The "_opposite_" attributes map to `NSLayoutAttributes` as follows:

Layout Guide                | `secondAttribute`
----------------------------|-----------------------------
`.lex_topLayoutGuide`       | `.Bottom`
`.lex_leftLayoutGuide`      | `.Right`
`.lex_bottomLayoutGuide`    | `.Top`
`.lex_rightLayoutGuide`     | `.Left`

#### UILayoutSupport Functions

Alternatively, you can bring any `UILayoutSupport`-conforming item into a layout expression using one of the functions: `topEdgeOf()`, `leftEdgeOf()`, `bottomEdgeOf()`, `rightEdgeOf()`, `leadingEdgeOf()`, `trailingEdgeOf()`.

```swift
view.lex_leading == trailingEdgeOf(viewController.leftLayoutGuide) + 10
```

## Installation

> This module can only be used with the Xcode 6 beta.

To use LayoutExpressions in your iOS project, follow these steps:

1. Add the LayoutExpressions repository as a submodule of your project's repository.
2. Drag and drop **LayoutExpressions.xcodeproj** into your Xcode workspace.
3. Link **LayoutExpressions.framework** in your project's "Link Binary with Libraries" build phase.

Now just `@import LayoutExpressions` and you're all set.

## TODO

- Add support for OS X.

## Contact

- [Steve Brambilla](http://github.com/stevebrambilla)

## License

LayoutExpressions is available under the MIT license. See the LICENSE file for more info.