Class {
	#name : #CrNotificationCenterObject3Mock,
	#superclass : #Object,
	#instVars : [
		'noted',
		'noteBlock'
	],
	#category : #'Crono-Tests'
}

{ #category : #'as yet unclassified' }
CrNotificationCenterObject3Mock >> note: aNotification [

	noteBlock cull: aNotification
]

{ #category : #accessing }
CrNotificationCenterObject3Mock >> onNote: aBlock [

	noteBlock := aBlock
]
