Extension { #name : #CrTodoList }

{ #category : #'*Crono-View' }
CrTodoList >> iconOn: anApplication [

	^ self showsCompletion 
		ifTrue: [ CrCompletionFormBuilder buildCompletion: self completion ]
		ifFalse: [ super iconOn: anApplication ]
]
