Class {
	#name : #CrNotificationCenterObjectMock,
	#superclass : #Object,
	#instVars : [
		'noted'
	],
	#category : #'Crono-Tests'
}

{ #category : #'as yet unclassified' }
CrNotificationCenterObjectMock >> initialize [

	super initialize.
	noted := OrderedCollection new
]

{ #category : #'as yet unclassified' }
CrNotificationCenterObjectMock >> note: aNotification [

	noted add: aNotification
]

{ #category : #'as yet unclassified' }
CrNotificationCenterObjectMock >> noteMock: aNotification [

	noted add: aNotification
]

{ #category : #accessing }
CrNotificationCenterObjectMock >> noted [

	^ noted
]
