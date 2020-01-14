"
I am an IconProvider for Crono application.
I provide icons found in my locations.
"
Class {
	#name : #CrIconProvider,
	#superclass : #Object,
	#instVars : [
		'icons',
		'locations'
	],
	#category : #'Crono-View-Application'
}

{ #category : #accessing }
CrIconProvider >> addLocation: aReference [

	locations := locations copyWith: aReference
]

{ #category : #accessing }
CrIconProvider >> iconNamed: aSymbol [

	^ icons 
		at: aSymbol
		ifAbsentPut: [ self loadIconNamed: aSymbol ]
]

{ #category : #accessing }
CrIconProvider >> icons [

	^ icons
]

{ #category : #initialization }
CrIconProvider >> initialize [ 

	super initialize.
	locations := #().
	icons := IdentityDictionary new
]

{ #category : #inspecting }
CrIconProvider >> inspectionIcons [
	<inspectorPresentationOrder: 0 title: 'Icons'> 

	^ SpListPresenter new
		items: (icons associations sorted: [ :a :b | a key < b key ]);
		icon: [ :each | each value ];
		display: [ :each | each key ];
		yourself
]

{ #category : #utils }
CrIconProvider >> loadAllIcons [

	self locations do: [ :eachLocation |
		(eachLocation filesMatching: '*.png') do: [ :each |
			icons 
				at: each basename
				put: (self loadIcon: each) ] ]
]

{ #category : #utils }
CrIconProvider >> loadIcon: fileRef [

	fileRef exists ifFalse: [ 
		self error: ('Icon {1} does not exit' format: { fileRef fullName }) ].

	^ fileRef binaryReadStreamDo: [ :stream |
		 Form fromBinaryStream: stream ]
]

{ #category : #utils }
CrIconProvider >> loadIconNamed: aSymbol [

	self locations do: [ :each | | ref |
		ref := (each / aSymbol) withExtension: 'png'.
		ref exists ifTrue: [ 
			^ self loadIcon: ref ] ].
	
	self error: ('Icon {1} does not exit' format: { aSymbol })
	
]

{ #category : #accessing }
CrIconProvider >> locations [

	^ locations
]
