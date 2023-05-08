//
//  ViewController.swift
//  Project18
//
//  Created by Maks Vogtman on 04/01/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
// MARK: print()
        
// The absolute easiest debugging technique is the print() function. This prints a message into the Xcode debug console that can say anything you want, because users won't see it in the UI.
        
// The "scattershot" approach to bug fixing is to litter (zaśmiecenie) your code with calls to print() then follow the messages to see what's going on.
        
// It's the debugging method everyone starts with – it's easy, it's natural, and it often gives you enough information to solve your problem. Use it with Swift's string interpolation to see the contents of your variables when your app is running.
        
// We’ve used print() several times already, always in its most basic form:
        print("I'm inside the viewDidLoad() method.")
        
// By adding calls like that to your various methods, you can see exactly how your program flowes (przebiega).
        
// However, print() is actually a bit more complicated behind the scenes. For example, you can actually pass it lots of values at the same time, and it will print them all:
        print(1, 2, 3, 4, 5)
        
// That makes print() a variadic function, which is a fancy way of saying they (variadic functions) accept any number of parameters of the same type (you can make any parameter variadic by writing ... after its type. So, an Int parameter is a single integer, whereas Int... is zero or more integers – potentially hundreds).
        
        // Variadic example on Ints
            func square(numbers: Int...) {
                for number in numbers {
                    print("\(number) squared is \(number * number)")
                }
            }
            
            square(numbers: 1, 2, 3, 4, 5)
        
// Here, though, it’s worth adding that print()’s variadic nature becomes much more useful when you use its optional extra parameters: separator and terminator.
        
// The first of these, separator, lets you provide a string that should be placed between every item in the print() call. Notice how you don’t need to specify separator if you don’t want to.
        print(1, 2, 3, 4, 5, separator: "-")
   
        
// The second optional parameter, terminator, is what should be placed after the final item. It’s \n by default, which you should remember means “line break”. If you don’t want print() to insert a line break after every call, just write this:
        print("Some message", terminator: "")
        
        
        
        
     
        
        
        
// MARK: assert()
    
// One level up from print() are assertions, which are debug-only checks that will force your app to crash if a specific condition isn't true.
    
// On the surface, that sounds terrible: why would you want your app to crash? There are two reasons. First, sometimes making your app crash is the Least Bad Option: if something has gone catastrophically wrong – if some fundamentally important file is not where it should be – then it may be the case that continuing your app will cause irreparable harm to user data, in which case crashing, while a bad result, is better than losing data.
    
// Second, these assertion crashes only happen while you’re debugging. When you build a release version of your app – i.e., when you ship your app to the App Store – Xcode automatically disables your assertions so they won’t reach your users. This means you can set up an extremely strict environment while you’re developing, ensuring that all values are present and correct, without causing problems for real users.
    
// Here's a very basic example:
assert(1 == 1, "Maths failure!")
// assert(1 == 2, "Maths failure!")

        
// As you can see assert() takes two parameters: something to check, and a message to print out if the check fails. If the check evaluates to false, your app will be forced to crash because you know it's not in a safe state, and you'll see the error message in the debug console. You can – and should! – add these assertions liberally to your code, because they help guarantee that your code’s state is what you think it is.
        
// The advantage to assertions is that their check code is never executed in a live app, so your users are never aware of their presence. This is different from print(), which would remain in your code if you shipped it (to App Store), albeit (aczkolwiek) mostly invisible. In fact, because calls to assert() are ignored in release builds of your app, you can do complex checks:
        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")

// That myReallySlowMethod() call will execute only while you’re running test builds – that code will be removed entirely when you build for the App Store.
        
// So: assertions are like running your code in strict mode. If your app works great with assertions on – things that literally make your app crash if things are wrong – then it will work even better in release mode.
        

  
        
        
        
        
// MARK: breakpoints
        
// Breakpoints are easy to use initially, but have a lot of hidden complexity if you want to get more advanced.
        
// Let's start small, with a simple loop that prints numbers from 1 to 100.
        for i in 1...100 {
            print("Got number \(i).")
        }
        
// If we wanted to see exactly what our program state was at the time we call the print() function, look to the left of where you've been typing and you'll see the line number markers. Click on the line number where print() is, and a blue marker will appear to signal that a breakpoint has been placed. This means that execution of your code will stop when that line is reached, and you have the opportunity to inspect your app’s internal state to see what values everything has.
        
// If you click on a breakpoint again, the blue arrow will become faint to show that the breakpoint exists but is disabled. This is useful when you want to keep your place, but don’t want execution to stop right now. You can click again to make it active, or right-click and choose Delete Breakpoint to remove it entirely.
        
// With that breakpoint in place, Xcode will pause execution when it's reached and show you the values of all your variables. Try running it now, and you should see your app paused, with a light green marker on the line of code that is about to be executed. At the bottom of the Xcode window you should see Xcode telling you that it currently has a value of 1. That's because it paused as soon as this line is reached, which is the very first iteration of our loop.
        
// From here, you can carry on execution by pressing F6, but you may need to use Fn+F6 because the function keys are often mapped to actions on Macs. This shortcut is called Step Over and will tell Xcode to advance code execution by one line. You can walk through the loop in its entirety by pressing F6 again and again, but there's another command called Continue (Ctrl+Cmd+Y) that means "continue executing my program until you hit another breakpoint."
        
// When your program is paused, you'll see something useful on the left of Xcode's window: a back trace that shows you all the threads in your program and what they are executing. So if you find a bug somewhere in method d(), this back trace will show you that d() was called by c(), which was called by b(), which in turn was called by a() – it effectively shows you the events leading up to your problem, which is invaluable when trying to spot bugs.
        
// Xcode also gives you an interactive LLDB debugger window, where you can type commands to query values and run methods. If it’s visible, you’ll see “(lldb)” in the bottom of your Xcode window. Try typing p i to ask Xcode to print the value of the i variable.
        
// While your app is paused, here’s one more neat trick that few people know about: that light green arrow that shows your current execution position can be moved. Just click and drag it somewhere else to have execution pick up from there – although Xcode will warn you that it might have unexpected results, so tread carefully!
        
// Breakpoints can do two more clever things, but for some reason both of them aren't used nearly enough. The first is that you can make breakpoints conditional, meaning that they will pause execution of your program only if the condition is matched. Right now, our breakpoint will stop execution every time our loop goes around, but what if we wanted it to stop only every 10 times?
        
// Right-click on the breakpoint (the blue arrow marker) and choose Edit Breakpoint. In the popup that appears, set the condition value to be i % 10 == 0 – this uses modulo. With that in place, execution will now pause only when i is 10, 20, 30 and so on, up to 100. You can use conditional breakpoints to execute debugger commands automatically – the "Automatically continue" checkbox is perfect for making your program continue uninterrupted while breakpoints silently trigger actions.
        
// The second clever thing that breakpoints can do is be automatically triggered when an exception is thrown. Exceptions are errors that aren't handled, and will cause your code to crash. With breakpoints, you can say "pause execution as soon as an exception is thrown," so that you can examine your program state and see what the problem is.
        
// To make this happen, press Cmd+8 to choose the breakpoint navigator – it's on the left of your screen, where the project navigator normally sits. Now click the + button in the bottom-left corner and choose "Exception Breakpoint." That's it! The next time your code hits a fatal problem, the exception breakpoint will trigger and you can take action.
        



        
        
// MARK: view debugging

// The last debugging technique I want to look at is view debugging, Xcode comes with a marvelous feature called Capture View Hierarchy, and when it's used your see your current view layout inside Xcode with thin gray lines around all the views.
        
// First, launch a project with some interesting UI. Now run the program as normal, then in Xcode go to the Debug menu and choose View Debugging > Capture View Hierarchy. After a few seconds of thinking, Xcode will show you a screenshot of your app’s UI.

// Here’s the clever part: if you click and drag inside the hierarchy display, you'll see you're actually viewing a 3D representation of your view, which means you can look behind the layers to see what else is there. The hierarchy automatically puts some depth between each of its views, so they appear to pop off the canvas as you rotate them.

// This debug mode is perfect for times when you know you've placed your view but for some reason can't see it – often you'll find the view is behind something else by accident.
    }
    
    
    func myReallySlowMethod() -> Bool {
        true
    }
}

