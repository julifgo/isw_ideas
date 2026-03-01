'From Cuis7.3 [latest update: #6597] on 28 February 2026 at 6:00:00 pm'!

!classDefinition: #Congresista category: #'Congreso-Parcial'!
Object subclass: #Congresista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congresista methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey
	self subclassResponsibility.! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaSegunPartidoDe: proyectoLey
	^miPartido = proyectoLey partidoAutor.! !

!Congresista methodsFor: 'testing' stamp: 'JFGO 2/28/2026 18:00:00'!
esOportunista
	^false.! !


!classDefinition: #CongresistaInfluenciable category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaInfluenciable
	instanceVariableNames: 'leyesAVotarEnContra leyesAVotarAFavor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaInfluenciable methodsFor: 'initialization' stamp: 'JFGO 2/28/2026 18:00:00'!
initialize
	leyesAVotarEnContra := OrderedCollection new.
	leyesAVotarAFavor := OrderedCollection new.! !

!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey
	(leyesAVotarEnContra includes: proyectoLey) ifTrue: [^false].
	(leyesAVotarAFavor includes: proyectoLey) ifTrue: [^true].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !

!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorIgnorandoInfluenciaDe: proyectoLey
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !

!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 2/28/2026 18:00:00'!
votarEnContra: proyectoLey
	leyesAVotarEnContra add: proyectoLey.! !

!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 2/28/2026 18:00:00'!
votarAFavor: proyectoLey
	leyesAVotarAFavor add: proyectoLey.! !


!classDefinition: #CongresistaLeal category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaLeal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaLeal methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !


!classDefinition: #CongresistaOportunista category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaOportunista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaOportunista methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !

!CongresistaOportunista methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
votaAFavorEnEmergencia
	^true.! !

!CongresistaOportunista methodsFor: 'testing' stamp: 'JFGO 2/28/2026 18:00:00'!
esOportunista
	^true.! !


!classDefinition: #CongresistaPaladin category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaPaladin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
votaAFavorDePresupuesto
	^true.! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion
	proporcion > (3/4) ifTrue: [
		^(self dePartido: miPartido votaSegunPartidoDe: proyectoLey) not.
	].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !


!classDefinition: #ModoLegislativo category: #'Congreso-Parcial'!
Object subclass: #ModoLegislativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ModoLegislativo methodsFor: 'testing' stamp: 'JFGO 2/28/2026 18:00:00'!
esEmergencia
	self subclassResponsibility.! !

!ModoLegislativo methodsFor: 'transicion' stamp: 'JFGO 2/28/2026 18:00:00'!
siguienteModoSegunVotaciones: votaciones
	self subclassResponsibility.! !


!classDefinition: #ModoEmergencia category: #'Congreso-Parcial'!
ModoLegislativo subclass: #ModoEmergencia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ModoEmergencia methodsFor: 'testing' stamp: 'JFGO 2/28/2026 18:00:00'!
esEmergencia
	^true.! !

!ModoEmergencia methodsFor: 'transicion' stamp: 'JFGO 2/28/2026 18:00:00'!
siguienteModoSegunVotaciones: votaciones
	| ultimasDos |
	votaciones size < 2 ifTrue: [^self].
	ultimasDos := votaciones last: 2.
	(ultimasDos allSatisfy: [:v | v proyectoAprobado]) ifTrue: [^ModoNormal new].
	^self.! !


!classDefinition: #ModoNormal category: #'Congreso-Parcial'!
ModoLegislativo subclass: #ModoNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ModoNormal methodsFor: 'testing' stamp: 'JFGO 2/28/2026 18:00:00'!
esEmergencia
	^false.! !

!ModoNormal methodsFor: 'transicion' stamp: 'JFGO 2/28/2026 18:00:00'!
siguienteModoSegunVotaciones: votaciones
	| ultimasCuatro |
	votaciones size < 4 ifTrue: [^self].
	ultimasCuatro := votaciones last: 4.
	(ultimasCuatro allSatisfy: [:v | v proyectoAprobado not]) ifTrue: [^ModoEmergencia new].
	^self.! !


!classDefinition: #Congreso category: #'Congreso-Parcial'!
Object subclass: #Congreso
	instanceVariableNames: 'partidoAzul partidoRojo totalCongresistas modo votaciones'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congreso methodsFor: 'initialization' stamp: 'JFGO 2/28/2026 18:00:00'!
initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	partidoAzul := unPartidoAzul.
	partidoRojo := unPartidoRojo.
	totalCongresistas := partidoAzul totalCongresistas + partidoRojo totalCongresistas.
	modo := ModoNormal new.
	votaciones := OrderedCollection new.! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 2/28/2026 18:00:00'!
totalCongresistas
	^totalCongresistas.! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 2/28/2026 18:00:00'!
partidoOpuestoA: unPartido
	unPartido = partidoAzul ifTrue: [^partidoRojo].
	^partidoAzul.! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 2/28/2026 18:00:00'!
estaEnEmergencia
	^modo esEmergencia.! !

!Congreso methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
votar: proyectoLey
	| congresistasAFavor votacion |

	proyectoLey class = ProyectoLeyOrdinaria ifTrue: [
		modo esEmergencia ifTrue: [
			congresistasAFavor := partidoAzul congresistasAFavorEnEmergenciaDe: proyectoLey.
			congresistasAFavor addAll: (partidoRojo congresistasAFavorEnEmergenciaDe: proyectoLey).
		] ifFalse: [
			congresistasAFavor := partidoAzul congresistasAFavorDe: proyectoLey.
			congresistasAFavor addAll: (partidoRojo congresistasAFavorDe: proyectoLey).
		].
		votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
		self registrarVotacion: votacion.
		(votacion proyectoAprobado not and: [modo esEmergencia not]) ifTrue: [
			self moverPrimerOportunistaDelPartido: proyectoLey partidoAutor.
		].
		^votacion.
	].

	proyectoLey class = ProyectoLeyPresupuesto ifTrue: [
		modo esEmergencia ifTrue: [
			congresistasAFavor := partidoAzul congresistasAFavorDePresupuestoEnEmergencia: proyectoLey.
			congresistasAFavor addAll: (partidoRojo congresistasAFavorDePresupuestoEnEmergencia: proyectoLey).
		] ifFalse: [
			congresistasAFavor := partidoAzul congresistasAFavorDePresupuesto: proyectoLey.
			congresistasAFavor addAll: (partidoRojo congresistasAFavorDePresupuesto: proyectoLey).
		].
		votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
		self registrarVotacion: votacion.
		(votacion proyectoAprobado not and: [modo esEmergencia not]) ifTrue: [
			self moverPrimerOportunistaDelPartido: proyectoLey partidoAutor.
		].
		^votacion.
	].

	proyectoLey class = ProyectoLeyConstitucional ifTrue: [
		modo esEmergencia ifTrue: [
			congresistasAFavor := partidoAzul congresistasAFavorDeConstitucionalEnEmergencia: proyectoLey conTotalCongreso: totalCongresistas.
			congresistasAFavor addAll: (partidoRojo congresistasAFavorDeConstitucionalEnEmergencia: proyectoLey conTotalCongreso: totalCongresistas).
		] ifFalse: [
			congresistasAFavor := partidoAzul congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas.
			congresistasAFavor addAll: (partidoRojo congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas).
		].
		votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
		self registrarVotacion: votacion.
		^votacion.
	].! !

!Congreso methodsFor: 'privado' stamp: 'JFGO 2/28/2026 18:00:00'!
moverPrimerOportunistaDelPartido: unPartido
	| oportunista partidoDestino |
	oportunista := unPartido primerOportunista.
	oportunista ifNil: [^self].
	partidoDestino := self partidoOpuestoA: unPartido.
	unPartido removerCongresista: oportunista.
	partidoDestino agregarCongresista: oportunista.! !

!Congreso methodsFor: 'privado' stamp: 'JFGO 2/28/2026 18:00:00'!
registrarVotacion: votacion
	votaciones add: votacion.
	modo := modo siguienteModoSegunVotaciones: votaciones.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Congreso class' category: #'Congreso-Parcial'!
Congreso class
	instanceVariableNames: ''!

!Congreso class methodsFor: 'instance creation' stamp: 'JFGO 2/28/2026 18:00:00'!
conPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	(unPartidoAzul totalCongresistas + unPartidoRojo totalCongresistas) even
		ifTrue: [self error: self congresistasPares].
	^self new initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo.! !

!Congreso class methodsFor: 'error messages' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasPares
	^'Deben ser impares'.! !


!classDefinition: #Partido category: #'Congreso-Parcial'!
Object subclass: #Partido
	instanceVariableNames: 'congresistas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Partido methodsFor: 'initialization' stamp: 'JFGO 2/28/2026 18:00:00'!
initializeConCongresistas: unosCongresistas
	congresistas := unosCongresistas asOrderedCollection.! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasAFavorDe: proyectoLey
	^congresistas select: [:c | c dePartido: self votaAFavorDe: proyectoLey].! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasAFavorDePresupuesto: proyectoLey
	^congresistas select: [:c |
		(c isKindOf: CongresistaPaladin)
			ifTrue: [c votaAFavorDePresupuesto]
			ifFalse: [c dePartido: self votaAFavorDe: proyectoLey]
	].! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: total
	| proporcion |
	proporcion := self totalCongresistas / total.
	^congresistas select: [:c |
		(c isKindOf: CongresistaPaladin)
			ifTrue: [c dePartido: self votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion]
			ifFalse: [
				(c isKindOf: CongresistaInfluenciable)
					ifTrue: [c dePartido: self votaAFavorIgnorandoInfluenciaDe: proyectoLey]
					ifFalse: [c dePartido: self votaAFavorDe: proyectoLey]
			]
	].! !

!Partido methodsFor: 'votacion - emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasAFavorEnEmergenciaDe: proyectoLey
	^congresistas select: [:c |
		(c isKindOf: CongresistaOportunista)
			ifTrue: [c votaAFavorEnEmergencia]
			ifFalse: [c dePartido: self votaAFavorDe: proyectoLey]
	].! !

!Partido methodsFor: 'votacion - emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasAFavorDePresupuestoEnEmergencia: proyectoLey
	^congresistas select: [:c |
		(c isKindOf: CongresistaOportunista)
			ifTrue: [c votaAFavorEnEmergencia]
			ifFalse: [
				(c isKindOf: CongresistaPaladin)
					ifTrue: [c votaAFavorDePresupuesto]
					ifFalse: [c dePartido: self votaAFavorDe: proyectoLey]
			]
	].! !

!Partido methodsFor: 'votacion - emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasAFavorDeConstitucionalEnEmergencia: proyectoLey conTotalCongreso: total
	| proporcion |
	proporcion := self totalCongresistas / total.
	^congresistas select: [:c |
		(c isKindOf: CongresistaOportunista)
			ifTrue: [c votaAFavorEnEmergencia]
			ifFalse: [
				(c isKindOf: CongresistaPaladin)
					ifTrue: [c dePartido: self votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion]
					ifFalse: [
						(c isKindOf: CongresistaInfluenciable)
							ifTrue: [c dePartido: self votaAFavorIgnorandoInfluenciaDe: proyectoLey]
							ifFalse: [c dePartido: self votaAFavorDe: proyectoLey]
					]
			]
	].! !

!Partido methodsFor: 'oportunistas' stamp: 'JFGO 2/28/2026 18:00:00'!
primerOportunista
	^congresistas detect: [:c | c esOportunista] ifNone: [nil].! !

!Partido methodsFor: 'modificacion' stamp: 'JFGO 2/28/2026 18:00:00'!
removerCongresista: unCongresista
	congresistas remove: unCongresista ifAbsent: [].! !

!Partido methodsFor: 'modificacion' stamp: 'JFGO 2/28/2026 18:00:00'!
agregarCongresista: unCongresista
	congresistas add: unCongresista.! !

!Partido methodsFor: 'accessing' stamp: 'JFGO 2/28/2026 18:00:00'!
totalCongresistas
	^congresistas size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Partido class' category: #'Congreso-Parcial'!
Partido class
	instanceVariableNames: ''!

!Partido class methodsFor: 'instance creation' stamp: 'JFGO 2/28/2026 18:00:00'!
conCongresistas: unosCongresistas
	unosCongresistas ifEmpty: [self error: self congresistasInsuficientes].
	^self new initializeConCongresistas: unosCongresistas.! !

!Partido class methodsFor: 'error messages' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasInsuficientes
	^'Debe haber al menos uno.'.! !


!classDefinition: #ProyectoLey category: #'Congreso-Parcial'!
Object subclass: #ProyectoLey
	instanceVariableNames: 'partidoAutor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLey methodsFor: 'aprobacion' stamp: 'JFGO 2/28/2026 18:00:00'!
proporcionParaSerAprobado
	self subclassResponsibility.! !

!ProyectoLey methodsFor: 'initialization' stamp: 'JFGO 2/28/2026 18:00:00'!
initializeDePartido: unPartido
	partidoAutor := unPartido.! !

!ProyectoLey methodsFor: 'accessing' stamp: 'JFGO 2/28/2026 18:00:00'!
partidoAutor
	^partidoAutor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProyectoLey class' category: #'Congreso-Parcial'!
ProyectoLey class
	instanceVariableNames: ''!

!ProyectoLey class methodsFor: 'instance creation' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: unPartido
	^self new initializeDePartido: unPartido.! !


!classDefinition: #ProyectoLeyConstitucional category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyConstitucional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyConstitucional methodsFor: 'aprobacion' stamp: 'JFGO 2/28/2026 18:00:00'!
proporcionParaSerAprobado
	^2/3.! !


!classDefinition: #ProyectoLeyOrdinaria category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyOrdinaria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyOrdinaria methodsFor: 'aprobacion' stamp: 'JFGO 2/28/2026 18:00:00'!
proporcionParaSerAprobado
	^1/2.! !


!classDefinition: #ProyectoLeyPresupuesto category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyPresupuesto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyPresupuesto methodsFor: 'aprobacion' stamp: 'JFGO 2/28/2026 18:00:00'!
proporcionParaSerAprobado
	^3/5.! !


!classDefinition: #Votacion category: #'Congreso-Parcial'!
Object subclass: #Votacion
	instanceVariableNames: 'proyectoLey congresistasAFavor totalCongresistas votosAFavor votosEnContra'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Votacion methodsFor: 'initialization' stamp: 'JFGO 2/28/2026 18:00:00'!
initializeParaProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccion sobreUnTotalDe: unaCantidad
	proyectoLey := unProyectoLey.
	congresistasAFavor := unaColeccion.
	totalCongresistas := unaCantidad.
	votosAFavor := congresistasAFavor size.
	votosEnContra := totalCongresistas - votosAFavor.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 2/28/2026 18:00:00'!
conVotoAFavorDe: unCongresista
	^congresistasAFavor includes: unCongresista.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 2/28/2026 18:00:00'!
conVotoEnContraDe: unCongresista
	^(self conVotoAFavorDe: unCongresista) not.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 2/28/2026 18:00:00'!
proyectoAprobado
	| votosNecesarios |
	votosNecesarios := totalCongresistas * proyectoLey proporcionParaSerAprobado.
	^votosAFavor >= votosNecesarios.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 2/28/2026 18:00:00'!
votosAFavor
	^votosAFavor.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 2/28/2026 18:00:00'!
votosEnContra
	^votosEnContra.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Votacion class' category: #'Congreso-Parcial'!
Votacion class
	instanceVariableNames: ''!

!Votacion class methodsFor: 'instance creation' stamp: 'JFGO 2/28/2026 18:00:00'!
paraProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccion sobreUnTotalDe: unaCantidad
	^self new initializeParaProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccion sobreUnTotalDe: unaCantidad.! !


!classDefinition: #CongresoTest category: #'Congreso-Parcial'!
TestCase subclass: #CongresoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresoTest methodsFor: 'validaciones' stamp: 'JFGO 2/28/2026 18:00:00'!
test01PartidoDebeTenerAlMenosUnCongresista
	self should: [
		Partido conCongresistas: OrderedCollection new.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [:e |
		self assert: e messageText equals: Partido congresistasInsuficientes.
	].! !

!CongresoTest methodsFor: 'validaciones' stamp: 'JFGO 2/28/2026 18:00:00'!
test02CongresoDebeTenerUnaCantidadImparTotalDeCongresistas
	| partidoAzul partidoRojo |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new).
	self should: [
		Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [:e |
		self assert: e messageText equals: Congreso congresistasPares.
	].! !

!CongresoTest methodsFor: 'ley ordinaria' stamp: 'JFGO 2/28/2026 18:00:00'!
test03ProyectoLeyOrdinariaPresentadoPorPartidoMayoritarioEsAprobadoMayoriaSimple
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.! !

!CongresoTest methodsFor: 'ley ordinaria' stamp: 'JFGO 2/28/2026 18:00:00'!
test04ProyectoLeyOrdinariaPresentadoPorPartidoMinoritarioEsRechazadoMayoriaSimple
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoRojo.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 2.
	self assert: votacion votosEnContra equals: 3.! !

!CongresoTest methodsFor: 'ley ordinaria' stamp: 'JFGO 2/28/2026 18:00:00'!
test09LeyOrdinariaRechazadaMuevePrimerOportunistaDelPartidoProponente
	| partidoAzul partidoRojo congreso proyectoLey votacion oportunista |
	oportunista := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunista).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: partidoAzul totalCongresistas equals: 1.
	self assert: partidoRojo totalCongresistas equals: 4.! !

!CongresoTest methodsFor: 'ley ordinaria' stamp: 'JFGO 2/28/2026 18:00:00'!
test10LeyOrdinariaAprobadaNoMueveOportunista
	| partidoAzul partidoRojo congreso proyectoLey votacion oportunista |
	oportunista := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: oportunista).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: votacion proyectoAprobado.
	self assert: partidoAzul totalCongresistas equals: 3.
	self assert: partidoRojo totalCongresistas equals: 2.! !

!CongresoTest methodsFor: 'ley ordinaria' stamp: 'JFGO 2/28/2026 18:00:00'!
test11LeyOrdinariaRechazadaSinOportunistasNoMueveNadie
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.! !

!CongresoTest methodsFor: 'ley ordinaria' stamp: 'JFGO 2/28/2026 18:00:00'!
test18LeyOrdinariaInfluenciableVotaEnContraSiEsInfluenciado
	| partidoAzul partidoRojo congreso proyectoLey votacion influenciable |
	influenciable := CongresistaInfluenciable new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: influenciable).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	influenciable votarEnContra: proyectoLey.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoEnContraDe: influenciable).
	self deny: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 1.
	self assert: votacion votosEnContra equals: 2.! !

!CongresoTest methodsFor: 'ley ordinaria' stamp: 'JFGO 2/28/2026 18:00:00'!
test19LeyOrdinariaInfluenciableVotaAFavorSiEsInfluenciado
	| partidoAzul partidoRojo congreso proyectoLey votacion influenciable |
	influenciable := CongresistaInfluenciable new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: influenciable).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	influenciable votarAFavor: proyectoLey.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: influenciable).
	self assert: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 4.
	self assert: votacion votosEnContra equals: 1.! !

!CongresoTest methodsFor: 'ley constitucional' stamp: 'JFGO 2/28/2026 18:00:00'!
test05ProyectoLeyConstitucionalPresentadoPorPartidoMayoritarioEsRechazadoSinDosTercios
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.! !

!CongresoTest methodsFor: 'ley constitucional' stamp: 'JFGO 2/28/2026 18:00:00'!
test06ProyectoLeyConstitucionalEsAprobadoConDosTercios
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion votosEnContra equals: 2.! !

!CongresoTest methodsFor: 'ley constitucional' stamp: 'JFGO 2/28/2026 18:00:00'!
test14LeyConstitucionalInfluenciableIgnoraInfluencia
	| partidoAzul partidoRojo congreso proyectoLey votacion influenciable |
	influenciable := CongresistaInfluenciable new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: influenciable).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	influenciable votarEnContra: proyectoLey.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: influenciable).
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion votosEnContra equals: 2.
	self assert: votacion proyectoAprobado.! !

!CongresoTest methodsFor: 'ley constitucional' stamp: 'JFGO 2/28/2026 18:00:00'!
test15LeyConstitucionalPaladinVotaContraPartidoSiSupera75Porciento
	| partidoAzul partidoRojo congreso proyectoLey votacion paladinAzul |
	paladinAzul := CongresistaPaladin new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: paladinAzul).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoEnContraDe: paladinAzul).
	self assert: votacion votosAFavor equals: 6.
	self assert: votacion votosEnContra equals: 3.! !

!CongresoTest methodsFor: 'ley constitucional' stamp: 'JFGO 2/28/2026 18:00:00'!
test16LeyConstitucionalPaladinVotaConPartidoSiNoSupera75Porciento
	| partidoAzul partidoRojo congreso proyectoLey votacion paladinAzul |
	paladinAzul := CongresistaPaladin new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: paladinAzul).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: paladinAzul).
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion votosEnContra equals: 2.! !

!CongresoTest methodsFor: 'ley constitucional' stamp: 'JFGO 2/28/2026 18:00:00'!
test17LeyConstitucionalNoMueveOportunistaAunqueSeRechace
	| partidoAzul partidoRojo congreso proyectoLey votacion oportunista |
	oportunista := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunista).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	self assert: partidoAzul totalCongresistas equals: 2.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.! !

!CongresoTest methodsFor: 'ley presupuesto' stamp: 'JFGO 2/28/2026 18:00:00'!
test07ProyectoLeyPresupuestoEsRechazadoSinTresQuintos
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion votosEnContra equals: 4.! !

!CongresoTest methodsFor: 'ley presupuesto' stamp: 'JFGO 2/28/2026 18:00:00'!
test08ProyectoLeyPresupuestoEsAprobadoConTresQuintos
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.! !

!CongresoTest methodsFor: 'ley presupuesto' stamp: 'JFGO 2/28/2026 18:00:00'!
test12LeyPresupuestoPaladinesSiempreVotanAFavor
	| partidoAzul partidoRojo congreso proyectoLey votacion paladinRojo |
	paladinRojo := CongresistaPaladin new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: paladinRojo).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.
	self assert: (votacion conVotoAFavorDe: paladinRojo).
	self assert: votacion proyectoAprobado.! !

!CongresoTest methodsFor: 'ley presupuesto' stamp: 'JFGO 2/28/2026 18:00:00'!
test13LeyPresupuestoRechazadaMuevePrimerOportunista
	| partidoAzul partidoRojo congreso proyectoLey votacion oportunista |
	oportunista := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunista).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	self assert: partidoAzul totalCongresistas equals: 2.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: partidoAzul totalCongresistas equals: 1.
	self assert: partidoRojo totalCongresistas equals: 4.! !

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
test20CongresoEmpiezaEnModoNormal
	| partidoAzul partidoRojo congreso |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	self deny: congreso estaEnEmergencia.! !

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
test21CuatroVotacionesRechazadasActivanModoEmergencia
	| partidoAzul partidoRojo congreso proyectoLey |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	congreso votar: proyectoLey.
	congreso votar: proyectoLey.
	congreso votar: proyectoLey.
	self deny: congreso estaEnEmergencia.
	congreso votar: proyectoLey.
	self assert: congreso estaEnEmergencia.! !

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
test22DosVotacionesAprobadasDesactivanModoEmergencia
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLeyAprobado |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyOrdinaria dePartido: partidoAzul.
	proyectoLeyAprobado := ProyectoLeyOrdinaria dePartido: partidoRojo.
	congreso votar: proyectoLeyRechazado.
	congreso votar: proyectoLeyRechazado.
	congreso votar: proyectoLeyRechazado.
	congreso votar: proyectoLeyRechazado.
	self assert: congreso estaEnEmergencia.
	congreso votar: proyectoLeyAprobado.
	self assert: congreso estaEnEmergencia.
	congreso votar: proyectoLeyAprobado.
	self deny: congreso estaEnEmergencia.! !

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
test23EnEmergenciaOportunistasVotanAFavor
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLey votacion oportunistaRojo |
	oportunistaRojo := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: oportunistaRojo).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyOrdinaria dePartido: partidoAzul.
	4 timesRepeat: [congreso votar: proyectoLeyRechazado].
	self assert: congreso estaEnEmergencia.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: oportunistaRojo).
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.
	self assert: votacion proyectoAprobado.! !

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
test24EnEmergenciaOportunistasNoCambianDePartido
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLey votacion oportunistaAzul |
	oportunistaAzul := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunistaAzul).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyOrdinaria dePartido: partidoAzul.
	4 timesRepeat: [congreso votar: proyectoLeyRechazado].
	self assert: congreso estaEnEmergencia.
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.! !

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
test25EnEmergenciaOportunistasVotanAFavorEnPresupuesto
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLey votacion oportunistaRojo |
	oportunistaRojo := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: oportunistaRojo).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyOrdinaria dePartido: partidoAzul.
	4 timesRepeat: [congreso votar: proyectoLeyRechazado].
	self assert: congreso estaEnEmergencia.
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: oportunistaRojo).
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion proyectoAprobado.! !

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 2/28/2026 18:00:00'!
test26EnEmergenciaOportunistasVotanAFavorEnConstitucional
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLey votacion oportunistaRojo |
	oportunistaRojo := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: oportunistaRojo).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyOrdinaria dePartido: partidoRojo.
	4 timesRepeat: [congreso votar: proyectoLeyRechazado].
	self assert: congreso estaEnEmergencia.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: oportunistaRojo).
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion proyectoAprobado.! !
