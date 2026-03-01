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
	instanceVariableNames: 'leyesAVotarEnContra'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaInfluenciable methodsFor: 'initialization' stamp: 'JFGO 2/28/2026 18:00:00'!
initialize
	leyesAVotarEnContra := OrderedCollection new.! !


!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey
	(leyesAVotarEnContra includes: proyectoLey) ifTrue: [^false].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !

!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
dePartido: miPartido votaAFavorIgnorandoInfluenciaDe: proyectoLey
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !


!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 2/28/2026 18:00:00'!
votarEnContra: proyectoLey
	leyesAVotarEnContra add: proyectoLey.! !


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
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion
	proporcion > (3/4) ifTrue: [
		^(self dePartido: miPartido votaSegunPartidoDe: proyectoLey) not.
	].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
votaAFavorDePresupuesto
	^true.! !


!classDefinition: #Congreso category: #'Congreso-Parcial'!
Object subclass: #Congreso
	instanceVariableNames: 'partidoAzul partidoRojo totalCongresistas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congreso methodsFor: 'initialization' stamp: 'JFGO 2/28/2026 18:00:00'!
initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	partidoAzul := unPartidoAzul.
	partidoRojo := unPartidoRojo.
	totalCongresistas := partidoAzul totalCongresistas + partidoRojo totalCongresistas.! !


!Congreso methodsFor: 'accessing' stamp: 'JFGO 2/28/2026 18:00:00'!
partidoOpuestoA: unPartido
	unPartido = partidoAzul ifTrue: [^partidoRojo].
	^partidoAzul.! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 2/28/2026 18:00:00'!
totalCongresistas
	^totalCongresistas.! !


!Congreso methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
votar: proyectoLey
	| congresistasAFavor votacion |

	proyectoLey class = ProyectoLeyOrdinaria ifTrue: [
		congresistasAFavor := partidoAzul congresistasAFavorDe: proyectoLey.
		congresistasAFavor addAll: (partidoRojo congresistasAFavorDe: proyectoLey).
		votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
		votacion proyectoAprobado ifFalse: [
			self moverPrimerOportunistaDelPartido: proyectoLey partidoAutor.
		].
		^votacion.
	].

	proyectoLey class = ProyectoLeyPresupuesto ifTrue: [
		congresistasAFavor := partidoAzul congresistasAFavorDePresupuesto: proyectoLey.
		congresistasAFavor addAll: (partidoRojo congresistasAFavorDePresupuesto: proyectoLey).
		votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
		votacion proyectoAprobado ifFalse: [
			self moverPrimerOportunistaDelPartido: proyectoLey partidoAutor.
		].
		^votacion.
	].

	proyectoLey class = ProyectoLeyConstitucional ifTrue: [
		congresistasAFavor := partidoAzul congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas.
		congresistasAFavor addAll: (partidoRojo congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas).
		votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
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

!Partido methodsFor: 'votacion' stamp: 'JFGO 2/28/2026 18:00:00'!
congresistasAFavorDePresupuesto: proyectoLey
	^congresistas select: [:c |
		(c isKindOf: CongresistaPaladin)
			ifTrue: [c votaAFavorDePresupuesto]
			ifFalse: [c dePartido: self votaAFavorDe: proyectoLey]
	].! !


!Partido methodsFor: 'oportunistas' stamp: 'JFGO 2/28/2026 18:00:00'!
primerOportunista
	^congresistas detect: [:c | c esOportunista] ifNone: [nil].! !


!Partido methodsFor: 'modificacion' stamp: 'JFGO 2/28/2026 18:00:00'!
agregarCongresista: unCongresista
	congresistas add: unCongresista.! !

!Partido methodsFor: 'modificacion' stamp: 'JFGO 2/28/2026 18:00:00'!
removerCongresista: unCongresista
	congresistas remove: unCongresista ifAbsent: [].! !


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


!CongresoTest methodsFor: 'proyectos ordinarios' stamp: 'JFGO 2/28/2026 18:00:00'!
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

!CongresoTest methodsFor: 'proyectos ordinarios' stamp: 'JFGO 2/28/2026 18:00:00'!
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


!CongresoTest methodsFor: 'proyectos constitucionales' stamp: 'JFGO 2/28/2026 18:00:00'!
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

!CongresoTest methodsFor: 'proyectos constitucionales' stamp: 'JFGO 2/28/2026 18:00:00'!
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


!CongresoTest methodsFor: 'proyectos presupuesto' stamp: 'JFGO 2/28/2026 18:00:00'!
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

!CongresoTest methodsFor: 'proyectos presupuesto' stamp: 'JFGO 2/28/2026 18:00:00'!
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


!CongresoTest methodsFor: 'ley ordinaria - oportunista' stamp: 'JFGO 2/28/2026 18:00:00'!
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

!CongresoTest methodsFor: 'ley ordinaria - oportunista' stamp: 'JFGO 2/28/2026 18:00:00'!
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

!CongresoTest methodsFor: 'ley ordinaria - oportunista' stamp: 'JFGO 2/28/2026 18:00:00'!
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


!CongresoTest methodsFor: 'ley presupuesto - paladin' stamp: 'JFGO 2/28/2026 18:00:00'!
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

!CongresoTest methodsFor: 'ley presupuesto - paladin' stamp: 'JFGO 2/28/2026 18:00:00'!
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


!CongresoTest methodsFor: 'ley constitucional - influenciable' stamp: 'JFGO 2/28/2026 18:00:00'!
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


!CongresoTest methodsFor: 'ley constitucional - paladin' stamp: 'JFGO 3/1/2026 19:44:38'!
test15LeyConstitucionalPaladinVotaContraPartidoSiSupera75Porciento
	| partidoAzul partidoRojo congreso proyectoLey votacion paladinAzul congresistasAzules |
	paladinAzul := CongresistaPaladin new.
	congresistasAzules := (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congresistasAzules add: paladinAzul.
	partidoAzul := Partido conCongresistas: congresistasAzules.
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoEnContraDe: paladinAzul).
	self assert: votacion votosAFavor equals: 6.
	self assert: votacion votosEnContra equals: 3.! !

!CongresoTest methodsFor: 'ley constitucional - paladin' stamp: 'JFGO 2/28/2026 18:00:00'!
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


!CongresoTest methodsFor: 'ley constitucional - oportunista' stamp: 'JFGO 2/28/2026 18:00:00'!
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


!CongresoTest methodsFor: 'ley ordinaria - influenciable' stamp: 'JFGO 2/28/2026 18:00:00'!
test18LeyOrdinariaInfluenciableSiEsInfluenciado
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
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 57 99 126 112 117 107 118 126 122 61 59 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 57 99 126 112 117 107 118 126 122 61 59 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 25 135 8 17 56 62 57 53 56 63 53 56 57 63 53 56 17 81 92 83 80 78 86 90 91 53 116 122 111 118 116 108 53 117 108 123 17 81 92 83 80 78 86 90 91 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 60 91 56 56 65 58 57 65 56 62 53 64 58 56 59 57 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 57 55 57 60 52 57 74 52 57 107 118 87 104 121 106 112 104 115 52 90 118 115 124 106 112 118 117 53 122 123 17 58 56 57 60 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 57 91 56 61 65 56 61 65 58 58 53 61 55 63 61 59 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 121 108 106 124 99 56 55 60 62 57 57 53 122 123 17 57 55 59 56 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 57 91 56 61 65 56 62 65 60 60 53 55 61 59 61 59 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 106 52 89 108 106 124 53 122 123 17 59 59 60 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 57 91 56 61 65 56 63 65 60 64 53 61 62 64 61 59 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 57 55 57 60 52 57 74 52 89 108 106 124 119 108 121 104 123 118 121 112 118 52 86 121 112 110 112 117 104 115 53 122 123 17 56 58 61 57 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 57 91 56 61 65 56 64 65 56 56 53 63 58 61 61 59 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 121 108 106 124 99 56 55 60 62 57 57 53 122 123 17 57 55 59 56 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 59 65 57 64 65 56 63 53 59 56 60 55 57 61 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 121 108 106 124 99 60 56 61 57 56 53 122 123 17 60 57 64 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 62 65 57 61 65 56 57 53 61 60 61 55 57 61 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 121 108 106 124 99 61 60 64 57 57 53 122 123 17 57 62 58 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 62 65 60 60 65 58 59 53 62 56 57 55 57 61 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 121 108 106 124 99 59 61 64 56 62 53 122 123 17 57 59 60 56 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 63 65 57 60 65 60 64 53 62 56 60 55 57 61 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 121 108 106 124 99 59 61 64 56 62 53 122 123 17 57 59 60 56 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 57 63 91 56 60 65 56 59 65 55 57 53 60 59 63 58 59 61 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 56 61 61 59 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 57 63 91 56 61 65 59 55 65 55 61 53 58 56 59 60 61 64 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 56 61 57 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 58 52 55 56 91 56 64 65 59 56 65 60 57 53 55 56 61 60 59 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 52 125 57 52 112 109 122 53 122 123 17 57 63 55 63 62 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 57 63 91 56 59 65 60 55 65 60 55 53 61 55 56 58 59 61 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 57 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 63 63 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 57 63 91 56 62 65 57 55 65 60 62 53 64 60 62 60 61 64 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 57 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 57 55 60 57 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 58 52 55 56 91 56 64 65 59 62 65 55 55 53 63 64 55 60 59 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 57 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 52 112 109 122 53 122 123 17 57 63 56 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 58 52 55 56 91 57 55 65 56 60 65 56 55 53 56 63 59 60 59 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 57 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 52 112 109 122 53 122 123 17 57 63 56 58 56 17 52 52 52 52 52 52 52 52 52 52 17 17))!