Class {
	#name : #CrTagCollectorTest,
	#superclass : #TestCase,
	#category : #'Crono-Tests'
}

{ #category : #tests }
CrTagCollectorTest >> testCalculateTagSegments [
	| collector |
	
	collector := CrTagCollector new.
	collector string: '[this] is a [test]'.
	
	self 
		assert: collector calculateTagSegments
		equals: #((1 6) (13 18)).

	collector string: '\[this\] is a [test]'.
	self 
		assert: collector calculateTagSegments
		equals: #((15 20)).

]

{ #category : #tests }
CrTagCollectorTest >> testCollect [
	| collector |
	
	collector := CrTagCollector new.
	collector string: '[this] is a [test]'.
	
	self 
		assert: collector collect 
		equals: #('this' 'test')
]
