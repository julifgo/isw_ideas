!classDefinition: #Congresista category: 'Congreso-Parcial'!
Object subclass: #Congresista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!


!classDefinition: #Congreso category: 'Congreso-Parcial'!
Object subclass: #Congreso
	instanceVariableNames: 'congresistasAzules congresistasRojos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congreso methodsFor: 'initialization' stamp: 'JFGO 2/3/2026 13:09:22'!
initializeConCongresistasDelPartidoAzul: unosCongresistasAzules conCongresistasDelPartidoRojo: unosCongresistasRojos 
	
	congresistasAzules := unosCongresistasAzules.
	congresistasRojos := unosCongresistasRojos.! !


!Congreso methodsFor: 'votacion' stamp: 'JFGO 2/3/2026 13:10:32'!
votar: proyectoLey 
	^Votacion new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Congreso class' category: 'Congreso-Parcial'!
Congreso class
	instanceVariableNames: ''!

!Congreso class methodsFor: 'instance creation' stamp: 'JFGO 2/3/2026 13:07:44'!
conCongresistasDelPartidoAzul: congresistasAzules conCongresistasDelPartidoRojo: congresistasRojos 
	congresistasAzules isEmpty ifTrue:[self error: self congresistasInsuficientes].
	congresistasRojos isEmpty ifTrue:[self error: self congresistasInsuficientes].
	(congresistasAzules size + congresistasRojos size) even ifTrue: [ self error: self congresistasPares].
	^self new initializeConCongresistasDelPartidoAzul: congresistasAzules conCongresistasDelPartidoRojo: congresistasRojos! !


!Congreso class methodsFor: 'error messages' stamp: 'JFGO 2/3/2026 12:17:10'!
congresistasInsuficientes
	^'Debe haber al menos uno de cada uno'.! !

!Congreso class methodsFor: 'error messages' stamp: 'JFGO 2/3/2026 12:31:09'!
congresistasPares
	^'Deben ser impares'! !


!classDefinition: #LeyOrdinaria category: 'Congreso-Parcial'!
Object subclass: #LeyOrdinaria
	instanceVariableNames: 'autorProyecto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!LeyOrdinaria methodsFor: 'initialization' stamp: 'JFGO 2/3/2026 13:06:38'!
initializeDeAutor: autor 
	
	autorProyecto := autor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeyOrdinaria class' category: 'Congreso-Parcial'!
LeyOrdinaria class
	instanceVariableNames: ''!

!LeyOrdinaria class methodsFor: 'instance creation' stamp: 'JFGO 2/3/2026 13:05:53'!
deAutor: autor 
	
	^self new initializeDeAutor: autor ! !


!classDefinition: #Votacion category: 'Congreso-Parcial'!
Object subclass: #Votacion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Votacion methodsFor: 'resultado' stamp: 'JFGO 2/3/2026 13:11:20'!
leyAprobada
	^true.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 2/3/2026 13:11:37'!
votosAFavor
	^3.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 2/3/2026 13:11:52'!
votosEnContra
	^2.! !


!classDefinition: #CongresoTest category: 'Congreso-Parcial'!
TestCase subclass: #CongresoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresoTest methodsFor: 'as yet unclassified' stamp: 'JFGO 2/3/2026 12:28:58'!
test01CongresoDebeTenerAlMenosUnCongresistaEnCadaPartido
	self should: [ 
		Congreso conCongresistasDelPartidoAzul:(OrderedCollection with: Congresista new) conCongresistasDelPartidoRojo: (OrderedCollection new).	
	] raise: Error - MessageNotUnderstood
	withExceptionDo:  [:e |
		self assert: e messageText equals: Congreso congresistasInsuficientes.
		
	].

	self should: [ 
		Congreso conCongresistasDelPartidoAzul: (OrderedCollection new) conCongresistasDelPartidoRojo: (OrderedCollection with: Congresista new) .	
	] raise: Error - MessageNotUnderstood
	withExceptionDo:  [:e |
		self assert: e messageText equals: Congreso congresistasInsuficientes.
		
	].! !

!CongresoTest methodsFor: 'as yet unclassified' stamp: 'JFGO 2/3/2026 12:31:22'!
test02CongresoDebeTenerUnaCantidadImparTotalDeCongresistas
	self should: [ 
		Congreso conCongresistasDelPartidoAzul:(OrderedCollection with: Congresista new) conCongresistasDelPartidoRojo: (OrderedCollection with: Congresista new) .	
	] raise: Error - MessageNotUnderstood
	withExceptionDo:  [:e |
		self assert: e messageText equals: Congreso congresistasPares.
		
	].

! !

!CongresoTest methodsFor: 'as yet unclassified' stamp: 'JFGO 2/3/2026 13:05:27'!
test03LeyOrdinariaPresentadaPorPartidoMayoritarioEsAprobadaMayoriaSimple
| autor azules rojos congreso proyectoLey votacion |
autor := Congresista new.
azules := OrderedCollection with: autor with: Congresista new with: Congresista new.
rojos := OrderedCollection with: Congresista new with: Congresista new.

congreso := Congreso conCongresistasDelPartidoAzul: azules conCongresistasDelPartidoRojo: rojos.
proyectoLey := LeyOrdinaria deAutor: autor.

votacion := congreso votar: proyectoLey.

self assert: votacion leyAprobada.
self assert: votacion votosAFavor equals: azules size.
self assert: votacion votosEnContra equals: rojos size.
"El size no garantiza quienes votaron de que manera. Se puede refinar con votacion congresista: votoAFavor (idem contra)"! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 25 135 8 17 56 62 57 53 56 63 53 56 57 63 53 56 17 81 92 83 80 78 86 90 91 53 116 122 111 118 116 108 53 117 108 123 17 81 92 83 80 78 86 90 91 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 59 91 56 59 65 57 57 65 58 64 53 59 56 57 60 58 56 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 59 59 59 56 64 53 122 123 17 58 56 55 64 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 59 91 56 59 65 59 55 65 57 60 53 58 59 57 60 58 56 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 64 62 55 57 58 53 122 123 17 56 63 56 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 59 91 56 61 65 55 56 65 57 64 53 58 61 59 60 58 56 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 60 60 56 57 59 53 122 123 17 57 57 59 59 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 60 91 55 64 65 60 57 65 58 60 53 60 55 61 55 55 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 56 64 61 57 59 53 122 123 17 57 58 63 61 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 60 91 56 56 65 56 64 65 56 64 53 61 62 59 55 55 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 64 55 61 57 57 53 122 123 17 57 56 63 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 60 91 56 59 65 60 56 65 60 61 53 64 58 63 62 62 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 56 61 55 57 58 53 122 123 17 57 63 56 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 64 91 56 62 65 56 55 65 56 63 53 58 63 64 57 64 58 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 57 55 57 60 52 57 106 52 89 108 106 124 52 77 112 117 104 115 53 122 123 17 58 62 63 58 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 64 91 56 62 65 56 60 65 60 56 53 58 60 63 57 64 58 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 57 55 57 60 52 57 74 52 89 108 106 124 119 108 121 104 123 118 121 112 118 52 86 121 112 110 112 117 104 115 53 122 123 17 56 58 61 57 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 64 91 56 62 65 56 61 65 56 60 53 55 60 57 57 64 58 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 57 55 57 60 52 57 106 52 89 108 106 124 52 77 112 117 104 115 53 122 123 17 58 62 63 58 57 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 57 91 56 61 65 56 62 65 58 61 53 58 62 59 62 62 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 106 52 89 108 106 124 53 122 123 17 58 62 63 58 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 55 58 91 56 58 65 57 57 65 57 61 53 61 55 61 63 62 59 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 42 52 42 87 104 121 106 112 104 115 53 122 123 17 60 57 58 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 55 58 91 56 58 65 57 57 65 59 63 53 59 57 57 63 62 59 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 60 57 55 64 17 52 52 52 52 52 52 52 52 52 52 17 17))!