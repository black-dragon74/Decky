Decky for iOS
=================================

This framework allows you to easily create decked cards like UIViewController presentation style that is used systemwide in iOS 13 and also on iOS 12 in apps like Mail and Reminders.

How to use
--------
Download and put `Decky.swift` and `UIView+Snapshot.swift` in your project directory.

Then you can present any view controller like so:
```Swift
let decky = Decky()
decky.presentingController = self
decky.controllerToPresent = YourController()
self.present(decky, animated: false, completion: nil)
```

License
-------

Copyright (c) 2019 Nick (black-dragon74)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
