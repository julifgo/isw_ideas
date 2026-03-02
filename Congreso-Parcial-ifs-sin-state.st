!classDefinition: #Congresista category: #'Congreso-Parcial'!
Object subclass: #Congresista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	self subclassResponsibility.! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaSegunPartidoDe: proyectoLey
	^miPartido = proyectoLey partidoAutor.! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDePresupuesto: proyectoLey enModo: modo
	^self dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo.! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion enModo: modo
	^self dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo.! !


!Congresista methodsFor: 'testing' stamp: 'JFGO 3/2/2026 00:00:00'!
esOportunista
	^false.! !


!classDefinition: #CongresistaInfluenciable category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaInfluenciable
	instanceVariableNames: 'leyesAVotarEnContra leyesAVotarAFavor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaInfluenciable methodsFor: 'initialization' stamp: 'JFGO 3/2/2026 00:00:00'!
initialize
	leyesAVotarEnContra := OrderedCollection new.
	leyesAVotarAFavor := OrderedCollection new.! !


!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	(leyesAVotarEnContra includes: proyectoLey) ifTrue: [^false].
	(leyesAVotarAFavor includes: proyectoLey) ifTrue: [^true].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !

!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion enModo: modo
	"Ignora influencia en leyes constitucionales"
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !


!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 3/2/2026 00:00:00'!
votarEnContra: proyectoLey
	leyesAVotarEnContra add: proyectoLey.! !

!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 3/2/2026 00:00:00'!
votarAFavor: proyectoLey
	leyesAVotarAFavor add: proyectoLey.! !


!classDefinition: #CongresistaLeal category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaLeal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaLeal methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !


!classDefinition: #CongresistaOportunista category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaOportunista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaOportunista methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	"El modo determina como vota el oportunista"
	^modo votoOportunistaDePartido: miPartido paraProyecto: proyectoLey.! !


!CongresistaOportunista methodsFor: 'testing' stamp: 'JFGO 3/2/2026 00:00:00'!
esOportunista
	^true.! !


!classDefinition: #CongresistaPaladin category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaPaladin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDePresupuesto: proyectoLey enModo: modo
	"Paladin siempre vota a favor de presupuestos"
	^true.! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion enModo: modo
	"Si el partido supera 75%, vota en contra de su partido"
	proporcion > (3/4) ifTrue: [
		^(self dePartido: miPartido votaSegunPartidoDe: proyectoLey) not.
	].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey.! !


!classDefinition: #Congreso category: #'Congreso-Parcial'!
Object subclass: #Congreso
	instanceVariableNames: 'partidoAzul partidoRojo totalCongresistas modo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congreso methodsFor: 'initialization' stamp: 'JFGO 3/2/2026 00:00:00'!
initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	partidoAzul := unPartidoAzul.
	partidoRojo := unPartidoRojo.
	totalCongresistas := partidoAzul totalCongresistas + partidoRojo totalCongresistas.
	modo := ModoNormal new.! !


!Congreso methodsFor: 'accessing' stamp: 'JFGO 3/2/2026 00:00:00'!
partidoOpuestoA: unPartido
	unPartido = partidoAzul ifTrue: [^partidoRojo].
	^partidoAzul.! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 3/2/2026 00:00:00'!
totalCongresistas
	^totalCongresistas.! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 3/2/2026 00:00:00'!
modo
	^modo.! !


!Congreso methodsFor: 'testing' stamp: 'JFGO 3/2/2026 00:00:00'!
estaEnEmergencia
	^modo estaEnEmergencia.! !


!Congreso methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
votar: proyectoLey
	"Double dispatch: el proyecto de ley sabe como votarse"
	^proyectoLey votarEn: self.! !

!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/2/2026 00:00:00'!
votarOrdinaria: proyectoLey
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDe: proyectoLey enModo: modo.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDe: proyectoLey enModo: modo).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	self procesarResultadoDeVotacion: votacion conMoverOportunista: true.
	^votacion.! !

!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/2/2026 00:00:00'!
votarPresupuesto: proyectoLey
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDePresupuesto: proyectoLey enModo: modo.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDePresupuesto: proyectoLey enModo: modo).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	self procesarResultadoDeVotacion: votacion conMoverOportunista: true.
	^votacion.! !

!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/2/2026 00:00:00'!
votarConstitucional: proyectoLey
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas enModo: modo.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas enModo: modo).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	self procesarResultadoDeVotacion: votacion conMoverOportunista: false.
	^votacion.! !


!Congreso methodsFor: 'privado' stamp: 'JFGO 3/2/2026 00:00:00'!
procesarResultadoDeVotacion: votacion conMoverOportunista: debeMoverOportunista
	votacion proyectoAprobado
		ifTrue: [modo := modo registrarAprobacion]
		ifFalse: [
			modo := modo registrarRechazo.
			debeMoverOportunista ifTrue: [
				modo moverOportunistaDelPartido: votacion proyectoLey partidoAutor enCongreso: self.
			].
		].! !

!Congreso methodsFor: 'privado' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!Congreso class methodsFor: 'instance creation' stamp: 'JFGO 3/2/2026 00:00:00'!
conPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	(unPartidoAzul totalCongresistas + unPartidoRojo totalCongresistas) even
		ifTrue: [self error: self congresistasPares].
	^self new initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo.! !


!Congreso class methodsFor: 'error messages' stamp: 'JFGO 3/2/2026 00:00:00'!
congresistasPares
	^'Deben ser impares'.! !


!classDefinition: #ModoCongreso category: #'Congreso-Parcial'!
Object subclass: #ModoCongreso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ModoCongreso methodsFor: 'testing' stamp: 'JFGO 3/2/2026 00:00:00'!
estaEnEmergencia
	self subclassResponsibility.! !


!ModoCongreso methodsFor: 'votacion oportunista' stamp: 'JFGO 3/2/2026 00:00:00'!
votoOportunistaDePartido: partido paraProyecto: proyectoLey
	self subclassResponsibility.! !


!ModoCongreso methodsFor: 'transiciones' stamp: 'JFGO 3/2/2026 00:00:00'!
registrarAprobacion
	self subclassResponsibility.! !

!ModoCongreso methodsFor: 'transiciones' stamp: 'JFGO 3/2/2026 00:00:00'!
registrarRechazo
	self subclassResponsibility.! !


!ModoCongreso methodsFor: 'acciones' stamp: 'JFGO 3/2/2026 00:00:00'!
moverOportunistaDelPartido: partido enCongreso: congreso
	self subclassResponsibility.! !


!classDefinition: #ModoEmergencia category: #'Congreso-Parcial'!
ModoCongreso subclass: #ModoEmergencia
	instanceVariableNames: 'aprobacionesConsecutivas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ModoEmergencia methodsFor: 'initialization' stamp: 'JFGO 3/2/2026 00:00:00'!
initialize
	aprobacionesConsecutivas := 0.! !


!ModoEmergencia methodsFor: 'testing' stamp: 'JFGO 3/2/2026 00:00:00'!
estaEnEmergencia
	^true.! !


!ModoEmergencia methodsFor: 'votacion oportunista' stamp: 'JFGO 3/2/2026 00:00:00'!
votoOportunistaDePartido: partido paraProyecto: proyectoLey
	"En emergencia, los oportunistas siempre votan a favor"
	^true.! !


!ModoEmergencia methodsFor: 'transiciones' stamp: 'JFGO 3/2/2026 00:00:00'!
registrarAprobacion
	aprobacionesConsecutivas := aprobacionesConsecutivas + 1.
	aprobacionesConsecutivas >= 2 ifTrue: [^ModoNormal new].
	^self.! !

!ModoEmergencia methodsFor: 'transiciones' stamp: 'JFGO 3/2/2026 00:00:00'!
registrarRechazo
	aprobacionesConsecutivas := 0.
	^self.! !


!ModoEmergencia methodsFor: 'acciones' stamp: 'JFGO 3/2/2026 00:00:00'!
moverOportunistaDelPartido: partido enCongreso: congreso
	"En emergencia no se mueven oportunistas"
	^self.! !


!classDefinition: #ModoNormal category: #'Congreso-Parcial'!
ModoCongreso subclass: #ModoNormal
	instanceVariableNames: 'rechazosConsecutivos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ModoNormal methodsFor: 'initialization' stamp: 'JFGO 3/2/2026 00:00:00'!
initialize
	rechazosConsecutivos := 0.! !


!ModoNormal methodsFor: 'testing' stamp: 'JFGO 3/2/2026 00:00:00'!
estaEnEmergencia
	^false.! !


!ModoNormal methodsFor: 'votacion oportunista' stamp: 'JFGO 3/2/2026 00:00:00'!
votoOportunistaDePartido: partido paraProyecto: proyectoLey
	"En modo normal, los oportunistas votan segun su partido"
	^partido = proyectoLey partidoAutor.! !


!ModoNormal methodsFor: 'transiciones' stamp: 'JFGO 3/2/2026 00:00:00'!
registrarAprobacion
	rechazosConsecutivos := 0.
	^self.! !

!ModoNormal methodsFor: 'transiciones' stamp: 'JFGO 3/2/2026 00:00:00'!
registrarRechazo
	rechazosConsecutivos := rechazosConsecutivos + 1.
	rechazosConsecutivos >= 4 ifTrue: [^ModoEmergencia new].
	^self.! !


!ModoNormal methodsFor: 'acciones' stamp: 'JFGO 3/2/2026 00:00:00'!
moverOportunistaDelPartido: partido enCongreso: congreso
	"En modo normal, se mueve el oportunista"
	congreso moverPrimerOportunistaDelPartido: partido.! !


!classDefinition: #Partido category: #'Congreso-Parcial'!
Object subclass: #Partido
	instanceVariableNames: 'congresistas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Partido methodsFor: 'initialization' stamp: 'JFGO 3/2/2026 00:00:00'!
initializeConCongresistas: unosCongresistas
	congresistas := unosCongresistas asOrderedCollection.! !


!Partido methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
congresistasAFavorDe: proyectoLey enModo: modo
	^congresistas select: [:c | c dePartido: self votaAFavorDe: proyectoLey enModo: modo].! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
congresistasAFavorDePresupuesto: proyectoLey enModo: modo
	"Cada congresista sabe como votar presupuesto polimorficamente"
	^congresistas select: [:c | c dePartido: self votaAFavorDePresupuesto: proyectoLey enModo: modo].! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: total enModo: modo
	"Cada congresista sabe como votar constitucional polimorficamente"
	| proporcion |
	proporcion := self totalCongresistas / total.
	^congresistas select: [:c | c dePartido: self votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion enModo: modo].! !


!Partido methodsFor: 'oportunistas' stamp: 'JFGO 3/2/2026 00:00:00'!
primerOportunista
	^congresistas detect: [:c | c esOportunista] ifNone: [nil].! !


!Partido methodsFor: 'modificacion' stamp: 'JFGO 3/2/2026 00:00:00'!
agregarCongresista: unCongresista
	congresistas add: unCongresista.! !

!Partido methodsFor: 'modificacion' stamp: 'JFGO 3/2/2026 00:00:00'!
removerCongresista: unCongresista
	congresistas remove: unCongresista ifAbsent: [].! !


!Partido methodsFor: 'accessing' stamp: 'JFGO 3/2/2026 00:00:00'!
totalCongresistas
	^congresistas size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Partido class' category: #'Congreso-Parcial'!
Partido class
	instanceVariableNames: ''!

!Partido class methodsFor: 'instance creation' stamp: 'JFGO 3/2/2026 00:00:00'!
conCongresistas: unosCongresistas
	unosCongresistas ifEmpty: [self error: self congresistasInsuficientes].
	^self new initializeConCongresistas: unosCongresistas.! !


!Partido class methodsFor: 'error messages' stamp: 'JFGO 3/2/2026 00:00:00'!
congresistasInsuficientes
	^'Debe haber al menos uno.'.! !


!classDefinition: #ProyectoLey category: #'Congreso-Parcial'!
Object subclass: #ProyectoLey
	instanceVariableNames: 'partidoAutor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLey methodsFor: 'aprobacion' stamp: 'JFGO 3/2/2026 00:00:00'!
proporcionParaSerAprobado
	self subclassResponsibility.! !

!ProyectoLey methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
votarEn: congreso
	self subclassResponsibility.! !


!ProyectoLey methodsFor: 'initialization' stamp: 'JFGO 3/2/2026 00:00:00'!
initializeDePartido: unPartido
	partidoAutor := unPartido.! !


!ProyectoLey methodsFor: 'accessing' stamp: 'JFGO 3/2/2026 00:00:00'!
partidoAutor
	^partidoAutor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProyectoLey class' category: #'Congreso-Parcial'!
ProyectoLey class
	instanceVariableNames: ''!

!ProyectoLey class methodsFor: 'instance creation' stamp: 'JFGO 3/2/2026 00:00:00'!
dePartido: unPartido
	^self new initializeDePartido: unPartido.! !


!classDefinition: #ProyectoLeyConstitucional category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyConstitucional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyConstitucional methodsFor: 'aprobacion' stamp: 'JFGO 3/2/2026 00:00:00'!
proporcionParaSerAprobado
	^2/3.! !

!ProyectoLeyConstitucional methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
votarEn: congreso
	^congreso votarConstitucional: self.! !


!classDefinition: #ProyectoLeyOrdinaria category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyOrdinaria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyOrdinaria methodsFor: 'aprobacion' stamp: 'JFGO 3/2/2026 00:00:00'!
proporcionParaSerAprobado
	^1/2.! !

!ProyectoLeyOrdinaria methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
votarEn: congreso
	^congreso votarOrdinaria: self.! !


!classDefinition: #ProyectoLeyPresupuesto category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyPresupuesto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyPresupuesto methodsFor: 'aprobacion' stamp: 'JFGO 3/2/2026 00:00:00'!
proporcionParaSerAprobado
	^3/5.! !

!ProyectoLeyPresupuesto methodsFor: 'votacion' stamp: 'JFGO 3/2/2026 00:00:00'!
votarEn: congreso
	^congreso votarPresupuesto: self.! !


!classDefinition: #Votacion category: #'Congreso-Parcial'!
Object subclass: #Votacion
	instanceVariableNames: 'proyectoLey congresistasAFavor totalCongresistas votosAFavor votosEnContra'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Votacion methodsFor: 'initialization' stamp: 'JFGO 3/2/2026 00:00:00'!
initializeParaProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccion sobreUnTotalDe: unaCantidad
	proyectoLey := unProyectoLey.
	congresistasAFavor := unaColeccion.
	totalCongresistas := unaCantidad.
	votosAFavor := congresistasAFavor size.
	votosEnContra := totalCongresistas - votosAFavor.! !


!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/2/2026 00:00:00'!
conVotoAFavorDe: unCongresista
	^congresistasAFavor includes: unCongresista.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/2/2026 00:00:00'!
conVotoEnContraDe: unCongresista
	^(self conVotoAFavorDe: unCongresista) not.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/2/2026 00:00:00'!
proyectoAprobado
	| votosNecesarios |
	votosNecesarios := totalCongresistas * proyectoLey proporcionParaSerAprobado.
	^votosAFavor >= votosNecesarios.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/2/2026 00:00:00'!
votosAFavor
	^votosAFavor.! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/2/2026 00:00:00'!
votosEnContra
	^votosEnContra.! !


!Votacion methodsFor: 'accessing' stamp: 'JFGO 3/2/2026 00:00:00'!
proyectoLey
	^proyectoLey.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Votacion class' category: #'Congreso-Parcial'!
Votacion class
	instanceVariableNames: ''!

!Votacion class methodsFor: 'instance creation' stamp: 'JFGO 3/2/2026 00:00:00'!
paraProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccion sobreUnTotalDe: unaCantidad
	^self new initializeParaProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccion sobreUnTotalDe: unaCantidad.! !


!classDefinition: #CongresoTest category: #'Congreso-Parcial'!
TestCase subclass: #CongresoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresoTest methodsFor: 'validaciones' stamp: 'JFGO 3/2/2026 00:00:00'!
test01PartidoDebeTenerAlMenosUnCongresista
	self should: [
		Partido conCongresistas: OrderedCollection new.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [:e |
		self assert: e messageText equals: Partido congresistasInsuficientes.
	].! !

!CongresoTest methodsFor: 'validaciones' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'proyectos ordinarios' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'proyectos ordinarios' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'proyectos constitucionales' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'proyectos constitucionales' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'proyectos presupuesto' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'proyectos presupuesto' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'ley ordinaria - oportunista' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'ley ordinaria - oportunista' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'ley ordinaria - oportunista' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'ley presupuesto - paladin' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'ley presupuesto - paladin' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'ley constitucional - influenciable' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'ley constitucional - paladin' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'ley constitucional - paladin' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'ley constitucional - oportunista' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'ley ordinaria - influenciable' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'ley ordinaria - influenciable a favor' stamp: 'JFGO 3/2/2026 00:00:00'!
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


!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 3/2/2026 00:00:00'!
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

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 3/2/2026 00:00:00'!
test23EnEmergenciaOportunistasVotanAFavor
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLey votacion unOportunistaRojo otroOportunistaRojo |
	unOportunistaRojo := CongresistaOportunista new.
	otroOportunistaRojo := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: otroOportunistaRojo with: unOportunistaRojo).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyOrdinaria dePartido: partidoAzul.
	4 timesRepeat: [congreso votar: proyectoLeyRechazado].
	self assert: congreso estaEnEmergencia.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: unOportunistaRojo).
	self assert: (votacion conVotoAFavorDe: otroOportunistaRojo).
	self assert: votacion votosAFavor equals: 4.
	self assert: votacion votosEnContra equals: 1.! !

!CongresoTest methodsFor: 'modo emergencia' stamp: 'JFGO 3/2/2026 00:00:00'!
test24EnEmergenciaOportunistasNoCambianDePartido
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLey votacion oportunistaAzul |
	oportunistaAzul := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunistaAzul).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyConstitucional dePartido: partidoAzul.
	4 timesRepeat: [congreso votar: proyectoLeyRechazado].
	"Como la ley es constitucional, el oportunistaAzul no cambia de partido"
	self assert: congreso estaEnEmergencia.
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.

	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	"En emergencia no se mueve el oportunista aunque se rechace"
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.! !
