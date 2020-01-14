Class {
	#name : #CrConfiguration,
	#superclass : #Object,
	#category : #'Crono-View-Configuration'
}

{ #category : #accessing }
CrConfiguration class >> fileName [

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
CrConfiguration class >> readFromFileSystem [
	| reference |

	reference := self reference.
	reference exists ifFalse: [ ^ self new ].
	^ reference readStreamDo: [ :stream | 
		STON fromStream: stream  ]
]

{ #category : #accessing }
CrConfiguration class >> reference [

	^ FileLocator home / '.config' / 'worklog' / self fileName
]

{ #category : #writing }
CrConfiguration >> referenceExists: reference [
	
	"self error: ('There is already a configuration file at {1}.' 
			format: { reference fullName })"
	
	reference ensureDelete			
]

{ #category : #writing }
CrConfiguration >> writeToFile [
	| reference |

	reference := self class reference.
	reference exists ifTrue: [ 
		self referenceExists: reference ]. 
	reference writeStreamDo: [ :stream | 
		STON put: self onStreamPretty: stream ]
]
