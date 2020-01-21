Extension { #name : #SpCommandGroup }

{ #category : #'*Crono-View' }
SpCommandGroup >> prepareForContextMenu [

	CrContextMenuFormatter new visit: self
]
