# AirTicketClient
Learning objc 

You need to import pods to project.

go to directory of project in "Terminal" (cd ..)

and use these comands:

pod init
open -a Xcode Podfile

then to import pods like this

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AirTicketClient' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for AirTicketClient
  pod 'YYWebImage'

end

and use these comands in terminal:

pod install
open air.xcworkspace

