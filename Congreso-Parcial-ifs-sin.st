!classDefinition: #Congresista category: #'Congreso-Parcial'!
Object subclass: #Congresista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:10:12'!
dePartido: miPartido votaAFavorDe: proyectoLey
	self subclassResponsibility. ! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:10:22'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion
	^self dePartido: miPartido votaAFavorDe: proyectoLey.  ! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:10:30'!
dePartido: miPartido votaAFavorDePresupuesto: proyectoLey
	^self dePartido: miPartido votaAFavorDe: proyectoLey.   ! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:10:40'!
dePartido: miPartido votaSegunPartidoDe: proyectoLey
	^miPartido = proyectoLey partidoAutor. ! !


!Congresista methodsFor: 'testing' stamp: 'JFGO 3/5/2026 15:10:50'!
esOportunista
	^false.! !


!classDefinition: #CongresistaInfluenciable category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaInfluenciable
	instanceVariableNames: 'leyesAVotarEnContra leyesAVotarAFavor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaInfluenciable methodsFor: 'initialization' stamp: 'JFGO 3/5/2026 15:12:30'!
initialize
	leyesAVotarEnContra := OrderedCollection new.
	leyesAVotarAFavor := OrderedCollection new.! !


!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:12:45'!
dePartido: miPartido votaAFavorDe: proyectoLey
	(leyesAVotarEnContra includes: proyectoLey) ifTrue: [^false].
	(leyesAVotarAFavor includes: proyectoLey) ifTrue: [^true].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !

!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:13:00'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion
	"Ignora influencia en leyes constitucionales"
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !


!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 3/5/2026 15:13:10'!
votarAFavor: proyectoLey
	leyesAVotarAFavor add: proyectoLey.! !

!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 3/5/2026 15:13:15'!
votarEnContra: proyectoLey
	leyesAVotarEnContra add: proyectoLey.! !


!classDefinition: #CongresistaLeal category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaLeal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaLeal methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:14:20'!
dePartido: miPartido votaAFavorDe: proyectoLey
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !


!classDefinition: #CongresistaOportunista category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaOportunista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaOportunista methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:15:10'!
dePartido: miPartido votaAFavorDe: proyectoLey
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !


!CongresistaOportunista methodsFor: 'testing' stamp: 'JFGO 3/5/2026 15:15:20'!
esOportunista
	^true.! !


!classDefinition: #CongresistaPaladin category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaPaladin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:16:30'!
dePartido: miPartido votaAFavorDe: proyectoLey
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:16:45'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion
	"Si el partido supera 75%, vota en contra de su partido"
	proporcion > (3/4) ifTrue: [
		^(self dePartido: miPartido votaSegunPartidoDe: proyectoLey) not.
	].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:17:00'!
dePartido: miPartido votaAFavorDePresupuesto: proyectoLey
	"Paladin siempre vota a favor de presupuestos"
	^true. ! !


!classDefinition: #Congreso category: #'Congreso-Parcial'!
Object subclass: #Congreso
	instanceVariableNames: 'partidoAzul partidoRojo totalCongresistas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congreso methodsFor: 'initialization' stamp: 'JFGO 3/5/2026 15:20:10'!
initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	partidoAzul := unPartidoAzul.
	partidoRojo := unPartidoRojo.
	totalCongresistas := partidoAzul totalCongresistas + partidoRojo totalCongresistas. ! !


!Congreso methodsFor: 'accessing' stamp: 'JFGO 3/5/2026 15:20:30'!
partidoOpuestoA: unPartido
	unPartido = partidoAzul ifTrue: [^partidoRojo].
	^partidoAzul.! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 3/5/2026 15:20:40'!
totalCongresistas
	^totalCongresistas. ! !


!Congreso methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:22:30'!
votar: proyectoLey
	"Double dispatch: el proyecto de ley sabe como votarse"
	^proyectoLey votarEn: self. ! !


!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/5/2026 15:24:10'!
votarConstitucional: proyectoLey
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	^votacion.! !

!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/5/2026 15:25:00'!
votarOrdinaria: proyectoLey
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDe: proyectoLey.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDe: proyectoLey).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	votacion proyectoAprobado ifFalse: [
		self moverPrimerOportunistaDelPartido: proyectoLey partidoAutor.
	].
	^votacion.! !

!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/5/2026 15:25:40'!
votarPresupuesto: proyectoLey
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDePresupuesto: proyectoLey.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDePresupuesto: proyectoLey).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	votacion proyectoAprobado ifFalse: [
		self moverPrimerOportunistaDelPartido: proyectoLey partidoAutor.
	].
	^votacion.! !


!Congreso methodsFor: 'privado' stamp: 'JFGO 3/5/2026 15:28:15'!
moverPrimerOportunistaDelPartido: partidoQuePerdioLaVotacion
	partidoQuePerdioLaVotacion oportunistaCambiaDePartidoEn: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Congreso class' category: #'Congreso-Parcial'!
Congreso class
	instanceVariableNames: ''!

!Congreso class methodsFor: 'instance creation' stamp: 'JFGO 3/5/2026 15:21:10'!
conPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	(unPartidoAzul totalCongresistas + unPartidoRojo totalCongresistas) even
		ifTrue: [self error: self congresistasPares].
	^self new initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo. ! !


!Congreso class methodsFor: 'error messages' stamp: 'JFGO 3/5/2026 15:21:20'!
congresistasPares
	^'Deben ser impares'. ! !


!classDefinition: #Partido category: #'Congreso-Parcial'!
Object subclass: #Partido
	instanceVariableNames: 'congresistas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Partido methodsFor: 'initialization' stamp: 'JFGO 3/5/2026 15:30:10'!
initializeConCongresistas: unosCongresistas
	congresistas := unosCongresistas . ! !


!Partido methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:31:20'!
congresistasAFavorDe: proyectoLey
	^congresistas select: [:congresista | congresista dePartido: self votaAFavorDe: proyectoLey].! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:32:00'!
congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: total
	"Cada congresista sabe como votar constitucional polimorficamente"
	| proporcion |
	proporcion := self totalCongresistas / total.
	^congresistas select: [:congresista | congresista dePartido: self votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion].! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:32:30'!
congresistasAFavorDePresupuesto: proyectoLey
	"Cada congresista sabe como votar presupuesto polimorficamente"
	^congresistas select: [:congresista | congresista dePartido: self votaAFavorDePresupuesto: proyectoLey].! !


!Partido methodsFor: 'oportunistas' stamp: 'JFGO 3/5/2026 15:35:10'!
oportunistaCambiaDePartidoEn: unCongreso
	| partidoDestino primerOportunista |
	primerOportunista := congresistas detect: [:congresista | congresista esOportunista] ifNone: [^self.].
	partidoDestino := unCongreso partidoOpuestoA: self.
	self removerCongresista: primerOportunista.
	partidoDestino agregarCongresista: primerOportunista.
	^self.! !


!Partido methodsFor: 'modificacion' stamp: 'JFGO 3/5/2026 15:35:30'!
agregarCongresista: unCongresista
	congresistas add: unCongresista.! !

!Partido methodsFor: 'modificacion' stamp: 'JFGO 3/5/2026 15:35:40'!
removerCongresista: unCongresista
	congresistas remove: unCongresista ifAbsent: [self shouldNotHappenBecause: 'Es un ambiente controlado de congresistas']. ! !


!Partido methodsFor: 'accessing' stamp: 'JFGO 3/5/2026 15:30:30'!
totalCongresistas
	^congresistas size. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Partido class' category: #'Congreso-Parcial'!
Partido class
	instanceVariableNames: ''!

!Partido class methodsFor: 'instance creation' stamp: 'JFGO 3/5/2026 15:30:50'!
conCongresistas: unosCongresistas
	unosCongresistas ifEmpty: [self error: self congresistasInsuficientes].
	^self new initializeConCongresistas: unosCongresistas. ! !


!Partido class methodsFor: 'error messages' stamp: 'JFGO 3/5/2026 15:31:00'!
congresistasInsuficientes
	^'Debe haber al menos uno.'. ! !


!classDefinition: #ProyectoLey category: #'Congreso-Parcial'!
Object subclass: #ProyectoLey
	instanceVariableNames: 'partidoAutor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLey methodsFor: 'aprobacion' stamp: 'JFGO 3/5/2026 15:38:10'!
proporcionParaSerAprobado
	self subclassResponsibility.  ! !


!ProyectoLey methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:38:15'!
votarEn: congreso
	self subclassResponsibility.  ! !


!ProyectoLey methodsFor: 'initialization' stamp: 'JFGO 3/5/2026 15:38:20'!
initializeDePartido: unPartido
	partidoAutor := unPartido. ! !


!ProyectoLey methodsFor: 'accessing' stamp: 'JFGO 3/5/2026 15:38:30'!
partidoAutor
	^partidoAutor. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProyectoLey class' category: #'Congreso-Parcial'!
ProyectoLey class
	instanceVariableNames: ''!

!ProyectoLey class methodsFor: 'instance creation' stamp: 'JFGO 3/5/2026 15:38:40'!
dePartido: unPartido
	^self new initializeDePartido: unPartido. ! !


!classDefinition: #ProyectoLeyConstitucional category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyConstitucional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyConstitucional methodsFor: 'aprobacion' stamp: 'JFGO 3/5/2026 15:39:10'!
proporcionParaSerAprobado
	^2/3. ! !


!ProyectoLeyConstitucional methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:39:20'!
votarEn: congreso
	^congreso votarConstitucional: self. ! !


!classDefinition: #ProyectoLeyOrdinaria category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyOrdinaria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyOrdinaria methodsFor: 'aprobacion' stamp: 'JFGO 3/5/2026 15:39:30'!
proporcionParaSerAprobado
	^1/2. ! !


!ProyectoLeyOrdinaria methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:39:40'!
votarEn: congreso
	^congreso votarOrdinaria: self. ! !


!classDefinition: #ProyectoLeyPresupuesto category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyPresupuesto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyPresupuesto methodsFor: 'aprobacion' stamp: 'JFGO 3/5/2026 15:39:50'!
proporcionParaSerAprobado
	^3/5. ! !


!ProyectoLeyPresupuesto methodsFor: 'votacion' stamp: 'JFGO 3/5/2026 15:40:00'!
votarEn: congreso
	^congreso votarPresupuesto: self. ! !


!classDefinition: #Votacion category: #'Congreso-Parcial'!
Object subclass: #Votacion
	instanceVariableNames: 'proyectoLey congresistasAFavor totalCongresistas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Votacion methodsFor: 'initialization' stamp: 'JFGO 3/5/2026 15:41:10'!
initializeParaProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccionDeCongresistas sobreUnTotalDe: unTotalDeCongresistas
	proyectoLey := unProyectoLey.
	congresistasAFavor := unaColeccionDeCongresistas.
	totalCongresistas := unTotalDeCongresistas. ! !


!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/5/2026 15:41:30'!
conVotoAFavorDe: unCongresista
	^congresistasAFavor includes: unCongresista. ! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/5/2026 15:41:40'!
conVotoEnContraDe: unCongresista
	^(self conVotoAFavorDe: unCongresista) not. ! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/5/2026 15:42:00'!
proyectoAprobado
	| votosNecesarios |
	votosNecesarios := totalCongresistas * proyectoLey proporcionParaSerAprobado.
	^self votosAFavor >= votosNecesarios. ! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/5/2026 15:42:15'!
votosAFavor
	^congresistasAFavor size. ! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/5/2026 15:42:25'!
votosEnContra
	^totalCongresistas - self votosAFavor . ! !


!Votacion methodsFor: 'accessing' stamp: 'JFGO 3/5/2026 15:42:35'!
proyectoLey
	^proyectoLey.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Votacion class' category: #'Congreso-Parcial'!
Votacion class
	instanceVariableNames: ''!

!Votacion class methodsFor: 'instance creation' stamp: 'JFGO 3/5/2026 15:43:00'!
paraProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccionDeCongresistas sobreUnTotalDe: totalDeCongresistas
	^self new initializeParaProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccionDeCongresistas sobreUnTotalDe: totalDeCongresistas.! !


!classDefinition: #CongresoTest category: #'Congreso-Parcial'!
TestCase subclass: #CongresoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresoTest methodsFor: '00 - validaciones' stamp: 'JFGO 3/5/2026 15:45:10'!
test01PartidoDebeTenerAlMenosUnCongresista
	self should: [
		Partido conCongresistas: OrderedCollection new.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [:e |
		self assert: e messageText equals: Partido congresistasInsuficientes.
	]. ! !

!CongresoTest methodsFor: '00 - validaciones' stamp: 'JFGO 3/5/2026 15:45:30'!
test02CongresoDebeTenerUnaCantidadImparTotalDeCongresistas
	| partidoAzul partidoRojo |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new).
	self should: [
		Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [:e |
		self assert: e messageText equals: Congreso congresistasPares.
	]. ! !


!CongresoTest methodsFor: '01 - proyectos ordinarios' stamp: 'JFGO 3/5/2026 15:47:20'!
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

!CongresoTest methodsFor: '01 - proyectos ordinarios' stamp: 'JFGO 3/5/2026 15:48:10'!
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


!CongresoTest methodsFor: '01 - proyectos constitucionales' stamp: 'JFGO 3/5/2026 15:50:20'!
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

!CongresoTest methodsFor: '01 - proyectos constitucionales' stamp: 'JFGO 3/5/2026 15:51:10'!
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


!CongresoTest methodsFor: '01 - proyectos presupuesto' stamp: 'JFGO 3/5/2026 15:53:20'!
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

!CongresoTest methodsFor: '01 - proyectos presupuesto' stamp: 'JFGO 3/5/2026 15:54:10'!
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


!CongresoTest methodsFor: '02 - ley ordinaria - oportunista' stamp: 'JFGO 3/5/2026 15:56:30'!
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
	"Luego de Perder votacion, el oportunista cambia de bando y cambia composicion del congreso"
	self assert: partidoAzul totalCongresistas equals: 1.
	self assert: partidoRojo totalCongresistas equals: 4.! !

!CongresoTest methodsFor: '02 - ley ordinaria - oportunista' stamp: 'JFGO 3/5/2026 15:57:40'!
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

!CongresoTest methodsFor: '02 - ley ordinaria - oportunista' stamp: 'JFGO 3/5/2026 15:58:30'!
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


!CongresoTest methodsFor: '02 - ley presupuesto - paladin' stamp: 'JFGO 3/5/2026 16:01:20'!
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

!CongresoTest methodsFor: '02 - ley presupuesto - paladin' stamp: 'JFGO 3/5/2026 16:02:30'!
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


!CongresoTest methodsFor: '02 - ley constitucional - influenciable' stamp: 'JFGO 3/5/2026 16:05:10'!
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


!CongresoTest methodsFor: '02 - ley constitucional - paladin' stamp: 'JFGO 3/5/2026 16:07:30'!
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

!CongresoTest methodsFor: '02 - ley constitucional - paladin' stamp: 'JFGO 3/5/2026 16:08:40'!
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


!CongresoTest methodsFor: '02 - ley constitucional - oportunista' stamp: 'JFGO 3/5/2026 16:10:20'!
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
	"La composicion se mantiene"
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.! !


!CongresoTest methodsFor: '02 - ley ordinaria - influenciable' stamp: 'JFGO 3/5/2026 16:12:30'!
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


!CongresoTest methodsFor: '02 - ley ordinaria - influenciable a favor' stamp: 'JFGO 3/5/2026 16:14:10'!
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
