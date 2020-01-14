Class {
	#name : #CrMorphicConfiguration,
	#superclass : #SpApplicationConfiguration,
	#category : #'Crono-View-Application'
}

{ #category : #'as yet unclassified' }
CrMorphicConfiguration class >> cronoStyleSheet [

	^ SpStyleSTONReader fromString: '.application [ 
	.cronoText [
		Font { #name : "Source Code Pro", #size : 10 }
	]
]'
]

{ #category : #configuring }
CrMorphicConfiguration >> configure: anApplication [

	super configure: anApplication.
	anApplication styleSheet: SpStyle defaultStyleSheet, self class cronoStyleSheet
]
