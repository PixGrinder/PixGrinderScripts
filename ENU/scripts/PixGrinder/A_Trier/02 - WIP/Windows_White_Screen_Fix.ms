-- Windows_White_Screen_Fix --

/*
When you run a script that's doing a lot of work 3ds Max tends to show 'Not Responding' in the title bar and won't print progress messages in the Listener either. Luckily there is the windows.processPostedMessages() function that can help!

Call the function just before you print the output to the listener:
*/

for i=1 to 100 do
(
 s=timeStamp()

 -- put your code here

 e=timeStamp()
 windows.processPostedMessages()
 format "%s\n" ((e-s)/1000.0)
)