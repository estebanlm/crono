Extension { #name : #KMKeyCombination }

{ #category : #'*Crono-View' }
KMKeyCombination >> platformMeta [

	^ (KMModifier command + self) mac 
		| (KMModifier control + self) unix 
		| (KMModifier control + self) win
]
