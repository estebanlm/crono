Class {
	#name : #CrNotificationCenterTest,
	#superclass : #TestCase,
	#category : #'Crono-Tests'
}

{ #category : #tests }
CrNotificationCenterTest >> testNotify [
	| nc object |
	
	nc := CrNotificationCenter new.
	object := CrNotificationCenterObjectMock new.
	nc subscribe: object to: CrNotificationMock.
	
	nc notify: CrNotificationMock.	

	self assert: object noted size equals: 1. 
	self assert: object noted first class equals: CrNotificationMock
]

{ #category : #tests }
CrNotificationCenterTest >> testNotifyDifferentPriorities [
	| nc object1 object2 noted |
	
	nc := CrNotificationCenter new.
	noted := OrderedCollection new.
	
	object1 := CrNotificationCenterObject3Mock new.
	object1 onNote: [ noted add: object1 ].
	nc subscribeHigh: object1 to: CrNotificationMock.

	object2 := CrNotificationCenterObject3Mock new.
	object2 onNote: [ noted add: object2 ].
	nc subscribe: object2 to: CrNotificationMock.
		
	nc notify: CrNotificationMock.	

	self assert: noted size equals: 2. 
	self assert: noted first equals: object1.
	self assert: noted second equals: object2
]

{ #category : #tests }
CrNotificationCenterTest >> testNotifySubscribedToSubclassNotifiesSuperclassReceiver [
	| nc object |
	
	nc := CrNotificationCenter new.
	object := CrNotificationCenterObject2Mock new.
	nc subscribe: object to: CrNotificationMock.
	
	nc notify: CrNotificationMock.	

	self assert: object noted size equals: 1. 
	self assert: object noted first class equals: CrNotificationMock
]

{ #category : #tests }
CrNotificationCenterTest >> testNotifyWhenSubscribedToClassAndSuperclass [
	| nc object |
	
	nc := CrNotificationCenter new.
	object := CrNotificationCenterObjectMock new.
	nc subscribe: object to: CrNotification.
	nc subscribe: object to: CrNotificationMock.
	
	nc notify: CrNotification.	

	self assert: object noted size equals: 1. 
	self assert: object noted first class equals: CrNotification
]

{ #category : #tests }
CrNotificationCenterTest >> testNotifyWhenSubscribedToSuperclass [
	| nc object |
	
	nc := CrNotificationCenter new.
	object := CrNotificationCenterObjectMock new.
	nc subscribe: object to: CrNotification.
	
	nc notify: CrNotificationMock.	

	self assert: object noted size equals: 1. 
	self assert: object noted first class equals: CrNotificationMock
]

{ #category : #tests }
CrNotificationCenterTest >> testNotifyWhenSubscribedToSuperclassAndClass [
	| nc object |
	
	nc := CrNotificationCenter new.
	object := CrNotificationCenterObjectMock new.
	nc subscribe: object to: CrNotification.
	nc subscribe: object to: CrNotificationMock.
	
	nc notify: CrNotificationMock.	

	self assert: object noted size equals: 2. 
	self assert: object noted first class equals: CrNotificationMock.
	self assert: object noted second class equals: CrNotificationMock
]

{ #category : #tests }
CrNotificationCenterTest >> testSubscriptionIsRemovedWhenObjectIsNoLongerReferenced [
	| nc object |
	
	nc := CrNotificationCenter new.
	object := CrNotificationCenterObjectMock new.
	nc subscribe: object to: CrNotificationMock.
	
	self denyEmpty: (nc subscriptionsTo: CrNotificationMock).
	
	object := nil.
	Smalltalk garbageCollect.
	
	self assertEmpty: (nc subscriptionsTo: CrNotificationMock).
	self assertEmpty: (nc subscriptionsTo: CrNotificationMock superclass)	
]
