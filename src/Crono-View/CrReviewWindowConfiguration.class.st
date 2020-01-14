Class {
	#name : #CrReviewWindowConfiguration,
	#superclass : #CrWindowConfiguration,
	#instVars : [
		'reviewDays'
	],
	#category : #'Crono-View-Configuration'
}

{ #category : #accessing }
CrReviewWindowConfiguration class >> fileName [

	^ 'reviewWindow.ston'
]

{ #category : #accessing }
CrReviewWindowConfiguration >> defaultBounds [

	^ 0@0 extent: 720@700
]

{ #category : #accessing }
CrReviewWindowConfiguration >> reviewDays [
	^ reviewDays ifNil: [ 1 ]
]

{ #category : #accessing }
CrReviewWindowConfiguration >> reviewDays: anObject [
	reviewDays := anObject
]
