Class {
	#name : #CrTagCollector,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : #'Crono-Model-Utils'
}

{ #category : #'as yet unclassified' }
CrTagCollector class >> collectTagsOn: aString [

	^ self new 
		string: aString;
		collect
]

{ #category : #private }
CrTagCollector >> calculateTagSegments [
	| startIndex previous |

	previous := nil.
	startIndex := nil.
	^ Array streamContents: [ :stream | 
		string withIndexDo: [ :each :index |
			(each = $[ and: [ previous ~= $\ ]) ifTrue: [ startIndex := index ].
			(each = $] and: [ previous ~= $\ and: [ startIndex notNil ] ]) ifTrue: [ 
				stream nextPut: { startIndex. index }.
				startIndex := nil ].
			previous := each ] ]
]

{ #category : #'as yet unclassified' }
CrTagCollector >> collect [ 

	^ self calculateTagSegments collect: [ :aSegment | 
		string 
			copyFrom: aSegment first + 1
			to: aSegment second - 1 ]

]

{ #category : #accessing }
CrTagCollector >> string: aString [
	
	string := aString
]
