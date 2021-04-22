Extension { #name : #SpPresenter }

{ #category : #'*Crono-View' }
SpPresenter >> firstResponder [
	"Override this to allow the presenter to re-define the one that will answer the 
	 'takeKeyboardFocus' call in composed presenters"

	^ self
]
