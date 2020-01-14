Class {
	#name : #CrCronoTaskTest,
	#superclass : #CrTestCase,
	#category : #'Crono-Tests'
}

{ #category : #tests }
CrCronoTaskTest >> testPrintInChangeLogFormat [
	| task changeLog |

	task := CrCronoTask new 
		notes: 'Test in changelog (one line).';
		yourself.
			
	changeLog := String streamContents: [ :stream |
		task printChangeLogOn: stream ].
	
	self assert: changeLog equals: '    * Test in changelog (one line).'
	
	
]

{ #category : #tests }
CrCronoTaskTest >> testPrintInChangeLogFormatMultipleLines [
	| task changeLog |

	task := CrCronoTask new 
		notes: 'Test in changelog.
Second line
Third line';
		yourself.
			
	changeLog := String streamContents: [ :stream |
		task printChangeLogOn: stream ].
	
	self 
		assert: changeLog 
		equals: '    * Test in changelog.
    Second line
    Third line'
]

{ #category : #tests }
CrCronoTaskTest >> testPrintInCronoTimeLogFormat [
	| task cronoLog |

	task := CrCronoTask new 
		notes: 'Test in changelog (one line).';
		yourself.
		
	task save.
			
	cronoLog := String streamContents: [ :stream |
		task printCronoTimeLogOn: stream ].
	
	self 
		assert: cronoLog 
		equals: task doneDate asTime logPrintTime, ' Test in changelog (one line).'
]

{ #category : #tests }
CrCronoTaskTest >> testPrintInCronoTimeLogFormatMultipleLines [
	| task cronoLog |

	task := CrCronoTask new 
		notes: 'Test in changelog.
Second line
Third line';
		yourself.
		
	task save.
			
	cronoLog := String streamContents: [ :stream |
		task printCronoTimeLogOn: stream ].
	
	self 
		assert: cronoLog 
		equals: task doneDate asTime logPrintTime, ' Test in changelog.
      Second line
      Third line'
]

{ #category : #tests }
CrCronoTaskTest >> testSave [
	| task |

	task := CrCronoTask new
		notes: 'Test';
		save.
		
	self assert: task isDone.
	self assert: task doneDate notNil.
	
	self assert: CrCronoTask selectAll anyOne equals: task
]

{ #category : #tests }
CrCronoTaskTest >> testSaveWithTags [
	| task |

	task := CrCronoTask new 
		notes: 'Test with [tag1] and [tag2]';
		save.

	self assert: task isDone.
	self assert: task doneDate notNil.

	self assert: CrCronoTask selectAll anyOne equals: task.

	self assert: task tags equals: #('tag1' 'tag2')
]
