#### Use Cases

### Start Pomodoro Timer

## User should be able to start a pomodoro timer √
1. System starts the timer and show to the user
2. System countdowns and send the result of each countdown

### Pause pomodoro Timer

## User should be able to pause a pomodoro timer √
1. User clicks in the button to pause the pomodoro
2. System pauses the timer 

## User tries to pauses a pomodoro that is not running √
1. User clicks to pause a pomodoro that is not running
2. System does nothing

### Unpause pomodoro Timer

## User should be able to unpause a paused pomodoro √
1. User clicks in the button to unpause the pomodoro
2. System starts the timer again from where it was paused before

## User tries to unpause pomodoro that is already running
1. System tries to start a pomodoro that is already running
2. System does nothing

# Not sure if we need to do this
## User tries to unpause a pomodoro that is stopped
1. User clicks to unpause a pomodoro that is stopped
2. System responds with an error indicating the pomodoro is not paused


### Restart pomodoro Timer

## User should be able to reset pomodoro timer √
1. User clicks the button to start a pomodoro
2. System starts the pomodoro timer
3. User clicks the button to reset the pomodoro timer
4. System stops the pomodoro timer
5. System returns the timer reseted.

## User tries to reset a pomodoro that is not running 
1. User clicks to reset a pomodoro that is not running
2. System resets the pomodoro


### Pomodoro finish

## User should be able to be notified when complete a pomodoro
1. System completes a pomodoro. (A pomodoro completes when it reaches 0 seconds)
2. System notifies user
3. System let user decide to start a break counter or start another pomodoro.

## System should know when to prompt for a pomodoro timer or break timer
1. System completes a pomodoro
2. System verifies the pomodoro type
3. System prompts the correct choices to the user 
  (Either a new pomodoro if it is a break time or a break time (long/short) if it is a pomdoro timer)

## System should prompt the user for a long break after 4 pomodoros
1. System completes a pomodoro. 
2. System verifies that it has four pomodoros in a row
3. System let user decide to take a long break or start anotheer pomodoro


### Start a break timer

## User should be able to start a break timer
1. User select the break timer
2. System starts a new pomodoro timer with the break timer (Usually a 5 minute timer)

## User should be able to stop a break timer
1. User stops a break timer
2. System stops the timer and reset to the default pomodoro timer


### See statistics of the pomodoros
TODO
