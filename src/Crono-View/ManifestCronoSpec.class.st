"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCronoSpec,
	#superclass : #PackageManifest,
	#category : #'Crono-View-Manifest'
}

{ #category : #'code-critics' }
ManifestCronoSpec class >> ruleRBSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CrGtkConfiguration #ensureAppearance: #false)) #'2019-10-18T22:05:26.61408+02:00') )
]
