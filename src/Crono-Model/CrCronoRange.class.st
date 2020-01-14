Class {
	#name : #CrCronoRange,
	#superclass : #Object,
	#instVars : [
		'fromDate',
		'toDate'
	],
	#category : #'Crono-Model'
}

{ #category : #'instance creation' }
CrCronoRange class >> fromString: aString [

	aString isEmptyOrNil ifTrue: [ ^ self newFrom: Date today ].
	aString first = $~ ifFalse: [ self error: 'Invalid range specifications' ].	

	^ self 
		newFrom: (Date today - ((aString allButFirst asNumber - 1) days)) asDate 
		to: Date today
]

{ #category : #'instance creation' }
CrCronoRange class >> newFrom: aDate [

	^ self newFrom: aDate to: aDate
]

{ #category : #'instance creation' }
CrCronoRange class >> newFrom: fromDate to: toDate [

	^ self basicNew 
		initializeFrom: fromDate to: toDate;
		yourself
]

{ #category : #enumerating }
CrCronoRange >> days [
	| days |
	
	days := OrderedCollection new.
	self daysDo: [ :each | days add: each ].
	^ days
	
]

{ #category : #enumerating }
CrCronoRange >> daysDo: aBlock [
	| day |
	
	day := fromDate.
	[ day <= toDate ] whileTrue: [ 
		aBlock value: day.
		day := (day + 1 day) asDate ]
]

{ #category : #accessing }
CrCronoRange >> fromDate [

	^ fromDate
]

{ #category : #initialization }
CrCronoRange >> initializeFrom: aDate to: otherDate [

	self initialize.
	fromDate := aDate.
	toDate := otherDate
]

{ #category : #accessing }
CrCronoRange >> toDate [

	^ toDate
]
