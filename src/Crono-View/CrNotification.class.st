"
I am a base Notification for a hierarchy of things I can dispatch.
A notification will send #note*: messages to subscribers to them. This is opposite to other 
implementations that were allowing users to define any selector to respond to notifications, 
this is *by design*, to enforce a protocol and avoid doing hacks to preserve the system from 
leaks.
"
Class {
	#name : #CrNotification,
	#superclass : #Object,
	#category : #'Crono-View-Application'
}

{ #category : #converting }
CrNotification class >> asNotification [

	^ self new
]

{ #category : #accessing }
CrNotification class >> receiverSelector [

	^ #note:
]

{ #category : #accessing }
CrNotification class >> systemIconName [

	^ #announcementIcon
]

{ #category : #converting }
CrNotification >> asNotification [

	^ self
]

{ #category : #accessing }
CrNotification >> dispatchTo: anObject [
	| selector |

	selector := self lookupSelectorOn: anObject.
	
	"(anObject className,'>>',selector,'(', self receiverSelector, ')') crTrace. "
		
	anObject 
		perform: selector
		with: self
]

{ #category : #private }
CrNotification >> lookupSelectorOn: anObject [

	^ self 
		lookupSelectorOn: anObject 
		for: self class
]

{ #category : #private }
CrNotification >> lookupSelectorOn: anObject for: aNotificationClass [

	^ (anObject respondsTo: aNotificationClass receiverSelector)
		ifTrue: [ aNotificationClass receiverSelector ]
		ifFalse: [ 
			(aNotificationClass = CrNotification) ifTrue: [ 
				self error: 'Notification receiver not defined.' ]. 
			self lookupSelectorOn: anObject for: aNotificationClass superclass ].
]

{ #category : #accessing }
CrNotification >> receiverSelector [

	^ self class receiverSelector
]
