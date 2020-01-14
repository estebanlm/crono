Class {
	#name : #CrApplicationConfiguration,
	#superclass : #CrConfiguration,
	#instVars : [
		'darkTheme',
		'autoArchiveAfterDays'
	],
	#category : #'Crono-View-Configuration'
}

{ #category : #accessing }
CrApplicationConfiguration class >> defaultAutoArchiveAfterDays [

	^ 1
]

{ #category : #accessing }
CrApplicationConfiguration class >> fileName [

	^ 'app.ston'
]

{ #category : #accessing }
CrApplicationConfiguration >> autoArchiveAfterDays [

	^ autoArchiveAfterDays ifNil: [ self class defaultAutoArchiveAfterDays ]
]

{ #category : #accessing }
CrApplicationConfiguration >> autoArchiveAfterDays: aNumber [

	autoArchiveAfterDays := aNumber
]

{ #category : #accessing }
CrApplicationConfiguration >> darkTheme: aBoolean [

	darkTheme := aBoolean
]

{ #category : #initialization }
CrApplicationConfiguration >> initialize [

	super initialize.
	darkTheme := false
]

{ #category : #testing }
CrApplicationConfiguration >> isDarkTheme [

	^ darkTheme
]
