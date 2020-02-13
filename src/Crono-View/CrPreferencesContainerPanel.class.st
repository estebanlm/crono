Class {
	#name : #CrPreferencesContainerPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'contentPanel'
	],
	#category : #'Crono-View-Todo-Settings'
}

{ #category : #ports }
CrPreferencesContainerPanel >> defaultInputPort [

	^ self inputModelPort
]

{ #category : #initialization }
CrPreferencesContainerPanel >> initializePresenter [

	layout := SpBoxLayout newVertical
]

{ #category : #ports }
CrPreferencesContainerPanel >> inputModelPort [

	^ SpModelPort newPresenter: self
]

{ #category : #'accessing model' }
CrPreferencesContainerPanel >> setModel: aPresenter [

	self show: aPresenter
]

{ #category : #showing }
CrPreferencesContainerPanel >> show: aPresenter [

	aPresenter owner: self.
	layout 
		removeAll;
		add: aPresenter
]
