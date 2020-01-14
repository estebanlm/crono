Extension { #name : #SpWindowPresenter }

{ #category : #'*Crono-View' }
SpWindowPresenter >> bindKey: aCharacter toAction: aBlock [ 

	self 
		bindKeyCombination: aCharacter platformMeta
		toAction: aBlock
]

{ #category : #'*Crono-View' }
SpWindowPresenter >> bindKeysWith: aCommandGroup [

	aCommandGroup asKMCategory allEntries keymaps do: [ :each | 
		self 
			bindKeyCombination: each shortcut  
			toAction: each action ]
]
