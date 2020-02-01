"
I maximize (zoom in mac) the active window.
"
Class {
	#name : #CrMaximizeActiveWindowCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Commands'
}

{ #category : #default }
CrMaximizeActiveWindowCommand class >> defaultName [

	^ OSPlatform current isMacOS 
		ifTrue: [ 'Zoom' ]
		ifFalse: [ 'Maximize' ]
]

{ #category : #executing }
CrMaximizeActiveWindowCommand >> execute [
	
	self context window maximize
]
