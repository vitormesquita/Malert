#Change Log

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
> ## [1.1](https://github.com/vitormesquita/Malert/tree/1.1) (2017-09-04)
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
