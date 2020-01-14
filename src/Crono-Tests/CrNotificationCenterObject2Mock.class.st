Class {
	#name : #CrNotificationCenterObject2Mock,
	#superclass : #Object,
	#instVars : [
		'noted'
	],
	#category : #'Crono-Tests'
}

{ #category : #'as yet unclassified' }
CrNotificationCenterObject2Mock >> initialize [

	super initialize.
	noted := OrderedCollection new
]

{ #category : #'as yet unclassified' }
CrNotificationCenterObject2Mock >> note: aNotification [

	noted add: aNotification
]

{ #category : #accessing }
CrNotificationCenterObject2Mock >> noted [

	^ noted
]
