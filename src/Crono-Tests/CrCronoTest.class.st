Class {
	#name : #CrCronoTest,
	#superclass : #CrTestCase,
	#category : #'Crono-Tests'
}

{ #category : #tests }
CrCronoTest >> newRange: days [

	^ CrCronoRange 
			newFrom: (Date today - days) asDate
			to: Date today
]

{ #category : #tests }
CrCronoTest >> testLog [ 

	self assert: CrCronoTask selectAll isEmpty.
	CrCronoLite new log: 'Test.'.
	self assert: CrCronoTask selectAll notEmpty
]

{ #category : #tests }
CrCronoTest >> testReviewTo [
	| crono review |
	
	crono := CrCronoLite new.
	crono log: 'Test 1'.
	crono log: 'Test 2'.
	crono log: 'Test 3'.
	
	review := String streamContents: [ :stream | 
		crono 
			review: (self newRange: 1 day) 
			to: stream ].
	
	self 
		assert: review
		equals: ((('{1}

    * Test 1
    * Test 2
    * Test 3

') withLineEndings: Smalltalk platform lineEnding)
	format: { ZTimestamp now asDate ddmmyyyy })
]

{ #category : #tests }
CrCronoTest >> testReviewToMultipleLines [
	| crono review |
	
	crono := CrCronoLite new.
	crono log: 'Test 1
Test 1.1'.
	crono log: 'Test 2'.
	crono log: 'Test 3
Test 3.1'.
	
	review := String streamContents: [ :stream | 
		crono 
			review: (self newRange: 1 day) 
			to: stream ].
	
	self 
		assert: review
		equals: ((('{1}

    * Test 1
    Test 1.1
    * Test 2
    * Test 3
    Test 3.1

') withLineEndings: Smalltalk platform lineEnding)
	format: { ZTimestamp now asDate ddmmyyyy })
]
