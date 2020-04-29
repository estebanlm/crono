Class {
	#name : #CrMorphicConfiguration,
	#superclass : #SpMorphicConfiguration,
	#category : #'Crono-View-Application'
}

{ #category : #accessing }
CrMorphicConfiguration class >> cronoStyleSheet [

	^ SpStyleSTONReader fromString: '.application [ 
	.cronoText [
		Font { #name : "Source Code Pro", #size : 10 }
	]
]'
]

{ #category : #configuring }
CrMorphicConfiguration >> styleSheet [

	^ super styleSheet, self class cronoStyleSheet
]
