Class {
	#name : #CrSettingPanel,
	#superclass : #SpPresenter,
	#category : #'Crono-View-Todo-Preferences'
}

{ #category : #accessing }
CrSettingPanel class >> allSettings [

	^ self allSubclasses collect: [ :each | each new ]
]

{ #category : #accessing }
CrSettingPanel >> title [

	^ self subclassResponsibility
]
