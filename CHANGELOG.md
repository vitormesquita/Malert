# Change Log

## [3.0](https://github.com/vitormesquita/Malert/tree/3.0) (2018-07-?)
>
>**Implemented enhancements**
>
>- Refactoring the way how to create an ***Malert*** to be more similar with `UIAlertController`
>- Changing `MalertViewController` -> `Malert` to be presented as `UIViewController`
>- Changing `MalertButtonStruct` -> `MalertAction`
>- Removing `MalertViewConfiguration`, `MalertButtonConfiguration`
>- Removing shared instance and all queue manager from `Malert`
>- Add new attributes to be more and more customizable and flexible
>- Removing `Cartography`
>- Add `dismissOnActionTapped` to dismiss when a call to action was clicked
>

## [2.0](https://github.com/vitormesquita/Malert/tree/2.0) (2017-11-21)
>
> **Implemented enhancements:**
>
>- Merged with [pull request](https://github.com/vitormesquita/Malert/pull/8), updating to swift 4
>- Refactoring some unnecessary codes
>
>**Fixed bugs:**
>
>- Fixing [bug](https://github.com/vitormesquita/Malert/issues/9)
>

## [1.1](https://github.com/vitormesquita/Malert/tree/1.1) (2017-09-04)
> 
> **Implemented enhancements:**
> 
> - Changed deploy target to 9.0
> - Removed `OAStackView` dependency
> 
> ### [1.1.1](https://github.com/vitormesquita/Malert/tree/1.1.1)
> 
> **Fixed bugs:**
> 
> - Refactoring `MalertView` constraints to handle with layout and constraints animations
> 
> ### [1.1.2](https://github.com/vitormesquita/Malert/tree/1.1.2)
> 
> **Implemented enhancements:**
> 
> - Added `dismissOnTap` block to handle when Malert is dismissed
>
> ### [1.1.3](https://github.com/vitormesquita/Malert/tree/1.1.3)
> 
> **Implemented enhancements:** 
> 
> - Create `MalertViewControllerCallback` to change responsibility of dismiss for `Malert`
>
> ### [1.1.4](https://github.com/vitormesquita/Malert/tree/1.1.4)
>
> **Implemented enhancements:**
>
> - Added `clipToBouds` and removed `customViewCorners()` from MalertView
>
> ### [1.1.5](https://github.com/vitormesquita/Malert/tree/1.1.5)
>
> **Fixed bugs:**
> 
> - Added `cancelsTouchesInView=false` in MalertViewController `tapRecognizer` for not cancel subviews touch
>
> ## [1.0](https://github.com/vitormesquita/Malert/tree/1.0) (2017-03-03)
>
> **Implemented enhancements:**
> 
> - Change MalertManager -> Malert
> - Undocking Malert from `UIWindow`, and makes create malert only with other `UIViewController`
> - Create custom dismissed from Malert according to `MalertAnimationType`
> - Added `tapToDismiss` attribute to close MalertView when clicked
>
> **Fixed bugs:**
>
> - Tap on View and Dismiss current MalertView [#3](https://github.com/vitormesquita/Malert/issues/3)
> - Error to hide keyboard when clicked on view [#4](https://github.com/vitormesquita/Malert/issues/4)
>

