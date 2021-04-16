"
I am the Crono application
"
Class {
	#name : #CrApplication,
	#superclass : #SpApplication,
	#instVars : [
		'standalone',
		'notificationCenter'
	],
	#classVars : [
		'Current'
	],
	#classInstVars : [
		'session'
	],
	#category : #'Crono-View-Application'
}

{ #category : #accessing }
CrApplication class >> applicationName [

	^ 'Nevermind Tasks'
]

{ #category : #'instance creation' }
CrApplication class >> current [

	self validateSession.
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
CrApplication class >> reset [
	<script>

	Current ifNil: [ ^ self ].
	Current emergencyShutdown.
	Current := nil
]

{ #category : #private }
CrApplication class >> setCurrent: anApplication [
	"used for test"
	
	Current := anApplication
]

{ #category : #private }
CrApplication class >> validateSession [
	
	session == Smalltalk session ifTrue: [ ^ self ].
	Current := nil.
	session := Smalltalk session
]

{ #category : #initialization }
CrApplication >> emergencyShutdown [

	self model shutDown.
	self reset.
	CrModelApplication reset
]

{ #category : #accessing }
CrApplication >> iconNamed: aSymbolOrString [

	aSymbolOrString ifNil: [ ^ nil ].
	aSymbolOrString isSymbol ifFalse: [ 
		^ GtkRunLoop defer: [ GtkImage newIconForMenuNamed: aSymbolOrString ] ].
	^ self iconProvider iconNamed: aSymbolOrString
]

{ #category : #accessing }
CrApplication >> iconProvider [

	^ self configuration iconProvider
]

{ #category : #initialization }
CrApplication >> initialize [

	super initialize.
	self initializeBackend.
	self initializeModel.
	self initializeVirtualLists
]

{ #category : #initialization }
CrApplication >> initializeBackend [
	| gtk |

	"Ensure the name of the application"
	self isStandalone ifTrue: [ 
		gtk := GtkApplication new initGtk3.
		GLibLibrary uniqueInstance gSetPrgName: self class applicationName.
		gtk run ].

	self settings isDarkTheme
		ifTrue: [ self useGtkDark ]
		ifFalse: [ self useGtk ]
]

{ #category : #initialization }
CrApplication >> initializeModel [
	
	CrModelApplication reset
]

{ #category : #initialization }
CrApplication >> initializeVirtualLists [

	CrVirtualList allLists do: [ :each | 
		each onApplicationStart: self ]
]

{ #category : #testing }
CrApplication >> isStandalone [

	^ standalone ifNil: [ standalone := false ]
]

{ #category : #accessing }
CrApplication >> model [

	^ CrModelApplication current
]

{ #category : #accessing }
CrApplication >> notificationCenter [

	^ notificationCenter ifNil: [ 
		notificationCenter := CrNotificationCenter new ]
]

{ #category : #initialization }
CrApplication >> prepareAsStandaloneApplication [
	
	MorphicUIManager uiProcess ifNotNil: #terminate.
	standalone := true
]

{ #category : #accessing }
CrApplication >> repository [ 

	^ self model repository
]

{ #category : #running }
CrApplication >> run [

	Current := self.
	super run	
]

{ #category : #accessing }
CrApplication >> settings [ 

	^ CrApplicationConfiguration readFromFileSystem
]

{ #category : #running }
CrApplication >> start [
	| window |

	self isStandalone ifFalse: [ ^ self ].
	window := CrApplicationStarter new 
		application: self;
		start.
	window whenClosedDo: [ 
		self emergencyShutdown.
		Smalltalk exitSuccess ]
]

{ #category : #initialization }
CrApplication >> useGtk [
	
	self 
		useBackend: #Gtk
		with: CrGtkConfiguration new
]

{ #category : #initialization }
CrApplication >> useGtkDark [
	
	self 
		useBackend: #Gtk
		with: CrGtkDarkConfiguration new
]

{ #category : #initialization }
CrApplication >> useMorphic [

	self 
		useBackend: #Morphic 
		with: CrMorphicConfiguration new
]
