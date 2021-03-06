Class {
	#name : #CrModelApplication,
	#superclass : #Object,
	#instVars : [
		'session',
		'paths',
		'repository'
	],
	#classVars : [
		'Current',
		'Development'
	],
	#category : #'Crono-Model-Base'
}

{ #category : #accessing }
CrModelApplication class >> beDevelopment [
	<script>

	Development := true
]

{ #category : #accessing }
CrModelApplication class >> beProduction [
	<script>

	Development := false
]

{ #category : #'instance creation' }
CrModelApplication class >> current [

	^ Current ifNil: [ Current := super new ]
]

{ #category : #'class initialization' }
CrModelApplication class >> initialize [

	self beDevelopment
]

{ #category : #testing }
CrModelApplication class >> isDevelopment [

	^ Development
]

{ #category : #'instance creation' }
CrModelApplication class >> new [

	self error: 'Use #current'
]

{ #category : #'instance creation' }
CrModelApplication class >> reset [

	Current := nil
]

{ #category : #private }
CrModelApplication class >> setCurrent: aModelApplication [

	Current := aModelApplication
]

{ #category : #initialization }
CrModelApplication >> initialize [

	super initialize.
	paths := CrResourcePaths newActive.
	self initializeRepository
]

{ #category : #initialization }
CrModelApplication >> initializeRepository [
	| reference isNew |

	reference := self paths repositoryReference.
	isNew := reference exists not.
	repository := VoEJDBRepository on: reference.
	isNew ifTrue: [ 
		CrTodoList newBaseLists
			do: [ :each | repository save: each ] ]
]

{ #category : #accessing }
CrModelApplication >> paths [

	^ paths
]

{ #category : #accessing }
CrModelApplication >> repository [

	^ repository
]

{ #category : #'system startup' }
CrModelApplication >> shutDown [

	repository close.
	CrTodoList focus resetCache
]

{ #category : #'system startup' }
CrModelApplication >> startUp [

	self initialize
]
