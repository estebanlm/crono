"
I am a configuration for the Crono application to be used with Gtk backend. 
I define a dark theme.
"
Class {
	#name : #CrGtkDarkConfiguration,
	#superclass : #CrGtkConfiguration,
	#category : #'Crono-View-Application'
}

{ #category : #accessing }
CrGtkDarkConfiguration >> macAppearanceName [

	^ 'NSAppearanceNameDarkAqua'
]

{ #category : #accessing }
CrGtkDarkConfiguration >> macThemeName [
		
	^ 'Mojave-dark'
]

{ #category : #'accessing resources' }
CrGtkDarkConfiguration >> themeIconsDir [

	^ self iconsDir / 'dark'
]

{ #category : #accessing }
CrGtkDarkConfiguration >> unixThemeName [

	^ 'Adwaita-dark'
]

{ #category : #accessing }
CrGtkDarkConfiguration >> windowsThemeName [

	^ 'Windows-10-Dark-master'
]
