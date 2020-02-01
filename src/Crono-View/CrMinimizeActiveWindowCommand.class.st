"
I minimize the active window.
"
Class {
	#name : #CrMinimizeActiveWindowCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Commands'
}

{ #category : #default }
CrMinimizeActiveWindowCommand class >> defaultName [

	^ 'Minimize'
]

{ #category : #default }
CrMinimizeActiveWindowCommand class >> defaultShortcut [

	^ $m platformMeta
]

{ #category : #executing }
CrMinimizeActiveWindowCommand >> execute [
	
	self context window minimize
]
