Class {
	#name : #CrWindowConfiguration,
	#superclass : #CrConfiguration,
	#instVars : [
		'bounds'
	],
	#category : #'Crono-View-Configuration'
}

{ #category : #accessing }
CrWindowConfiguration >> bounds [

	^ bounds ifNil: [ self defaultBounds ]
]

{ #category : #accessing }
CrWindowConfiguration >> bounds: anObject [
	bounds := anObject
]

{ #category : #accessing }
CrWindowConfiguration >> defaultBounds [

	^ 0@0 extent: 600@400
]
