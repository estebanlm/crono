Extension { #name : #Duration }

{ #category : #'*Crono-View' }
Duration >> MMSS [

	^ String streamContents: [ :stream | 
		self printMMSSOn: stream ]
]

{ #category : #'*Crono-View' }
Duration >> printMMSSOn: aStream [
	"Format as per ANSI 5.8.2.16: [-]D:HH:MM:SS[.S]" 	
	| m s |
	
	m := self minutes abs.
 	s := self seconds abs truncated.
	m < 10 ifTrue: [ aStream nextPut: $0. ].
	m printOn: aStream. 
	aStream nextPut: $:.
	s < 10 ifTrue: [ aStream nextPut: $0. ].
	s printOn: aStream
]
