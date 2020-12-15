Class {
	#name : #BaselineOfCrono,
	#superclass : #BaselineOf,
	#category : #BaselineOfCrono
}

{ #category : #baselines }
BaselineOfCrono >> baseline: spec [
	<baseline>
	
	spec for: #pharo do: [

		self ztimestamp: spec.
		self voyage: spec.
		self persistenceQuery: spec.
		self specGtk: spec.
		self objCBridge: spec.
		"self macPack: spec."

		spec 
			package: 'Crono-Model' with: [ 
				spec requires: #('ZTimestamp' 'Voyage' 'PersistenceQuery') ];
			package: 'Crono-View';
			package: 'Crono-Tests' ]
]

{ #category : #'external projects' }
BaselineOfCrono >> grouper: spec [

	spec
		baseline: 'Grouper'
		with: [ spec repository: 'github://juliendelplanque/Grouper' ]
]

{ #category : #'external projects' }
BaselineOfCrono >> macPack: spec [

	spec
		baseline: 'MacPack'
		with: [ spec repository: 'github://estebanlm/macpack' ]
]

{ #category : #'external projects' }
BaselineOfCrono >> objCBridge: spec [

	spec
		baseline: 'ObjCBridge'
		with: [ spec repository: 'github://estebanlm/objcbridge' ]
]

{ #category : #'external projects' }
BaselineOfCrono >> persistenceQuery: spec [

	spec
		baseline: 'PersistenceQuery'
		with: [ 
			spec 
				loads: #('ejdb');
				repository: 'github://pharo-nosql/PersistenceQuery' ]
]

{ #category : #'external projects' }
BaselineOfCrono >> specGtk: spec [

	spec
		baseline: 'SpecGtk'
		with: [ spec repository: 'github://pharo-spec/Spec-Gtk' ]
]

{ #category : #'external projects' }
BaselineOfCrono >> voyage: spec [

	spec
		baseline: 'Voyage'
		with: [ 
			spec 
				loads: #('memory' 'ejdb tests');
				repository: 'github://pharo-nosql/voyage' ]
]

{ #category : #'external projects' }
BaselineOfCrono >> ztimestamp: spec [

	spec
		baseline: 'ZTimestamp'
		with: [ spec repository: 'github://svenvc/ztimestamp' ]
]
