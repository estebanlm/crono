Class {
	#name : #CrPreferencesWindow,
	#superclass : #CrPresenter,
	#instVars : [
		'optionsList',
		'panel'
	],
	#category : #'Crono-View-Todo-Preferences'
}

{ #category : #specs }
CrPreferencesWindow class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		beNotHomogeneous;
		add: #optionsList;
		add: #panel;
		yourself
]

{ #category : #initialization }
CrPreferencesWindow >> initializePresenters [

	optionsList := self newList.
	panel := nil.
]
