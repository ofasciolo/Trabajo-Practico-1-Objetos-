import trabajoPractico1Objetos.*

class DineroInsuficienteException inherits wollok.lang.Exception {
	constructor(_mensaje) = super(_mensaje)
}
class NoSeEncuentraElHechizoException inherits wollok.lang.Exception {
	constructor(_mensaje) = super(_mensaje)
}
class NoSeEncuentraElArtefactoException inherits wollok.lang.Exception {
	constructor(_mensaje) = super(_mensaje)
}
class NoSePuedeAgregarArtefactoException inherits wollok.lang.Exception {
	constructor(_mensaje) = super(_mensaje)
}
class Personaje {
	var hechizoPreferido
	var artefactos
	var oro
	var valorBaseLucha
	const pesoMaximo
	
	constructor(unHechizo,_artefactos,elPesoMaximo){
		hechizoPreferido = unHechizo
		artefactos = _artefactos
		oro = 100
		valorBaseLucha = 1 
		pesoMaximo = elPesoMaximo
	}
	method oro(nuevoOro){
		oro = nuevoOro
	}
	method oro(){
		return oro
	}
	method artefactos(){
		return artefactos
	}
	method nivelHechiceria(){
		return self.valorBaseHechizo()*hechizoPreferido.poder()+fuerzaOscura.valor()
	}
	method valorBaseHechizo(){
		return 3
	}
	method valorBaseLucha(valor){
		valorBaseLucha = valor
	}
	method valorBaseLucha(){
		return valorBaseLucha
	}
	method hechizoPreferido(hechizo){
		hechizoPreferido = hechizo
	}
	method habilidadLucha(){
		return self.valorBaseLucha() + artefactos.sum{artefacto=>artefacto.unidadesDeLucha(self)}
	}
	method agregarArtefacto(artefacto){
		if (self.pesoTotal()+artefacto.pesoTotal(self) <= pesoMaximo){
			artefactos.add(artefacto)
		}else{
			throw new NoSePuedeAgregarArtefactoException("Error al agregar artefacto: demasiado peso")
		}
	}
	method pesoTotal(){
		return artefactos.sum({artefacto=>artefacto.pesoTotal(self)})
	}
	method removerArtefacto(artefacto){
		artefactos.remove(artefacto)
	}
	method removerTodosLosArtefactos(){
		artefactos.clear()
	}
	method mayorHabilidadDeLucha(){
		return self.habilidadLucha() > self.nivelHechiceria()
	}
	method seCreePoderoso(){
		return hechizoPreferido.hechizoPoderoso()
	}
	method estaCargado(){
		return artefactos.size()>=5
	}
	method hechizoPreferido(){
		return hechizoPreferido
	}
	method conseguirOro(oroConseguido){
		oro += oroConseguido
	}
	method perderOro(oroPerdido){
		oro -= oroPerdido
	}
	method completarObjetivo(personaje){
		personaje.conseguirOro(10)
	}
	method puedeCanjear(hechizo){
		return hechizoPreferido.precio(self)/2>=hechizo.precio(self)
	}	
	method puedeComprar(hechizo){
		return hechizoPreferido.precio(self)/2 + oro >= hechizo.precio(self)
	}
}

class Hechizo{
	
	constructor(){
		
	}
	method pesoAgregado(personaje){
		if (self.poder().odd()){
			return 1
		}else{
			return 2
		}
	}
	method poder(){
		return 10
	}
	method hechizoPoderoso(){
		return self.poder()>15
	}
	method unidadesDeLucha(personaje){
		return self.poder()
	}
	method precio(personaje){
		return self.poder()
	}
	method precioRefuerzo(armadura,personaje){
		return armadura.valorBase()+self.precio(personaje)
	}
}

class Logo inherits Hechizo{
	var multiplo
	var nombre
	
	constructor(unNombre, unMultiplo){
		nombre = unNombre
		multiplo = unMultiplo
	}
	
	method nombre(nuevoNombre){
		nombre = nuevoNombre
	}
	override method poder(){
		return nombre.size()*multiplo
	}
}

class Arma inherits Artefacto{
	constructor(nuevoPeso,fechaDeComprado) = super(nuevoPeso,fechaDeComprado){}
	method unidadesDeLucha(personaje){
		return 3
	}
	override method pesoAgregado(personaje){
		return 0
	}
	method precio(personaje){
		return 5*self.peso()
	}
}

class Espada inherits Arma{}

class Hacha inherits Arma{}

class Lanza inherits Arma{}

class CollarDivino inherits Artefacto{
	var perlas
	
	constructor(cantidadPerlas,nuevoPeso,fechaDeComprado)  = super(nuevoPeso,fechaDeComprado){
		perlas = cantidadPerlas
	}
	override method pesoAgregado(personaje){
		return perlas*0.5
	}
	method perlas(cantidadPerlas){
		perlas = cantidadPerlas
	}
	method unidadesDeLucha(personaje){
		return perlas
	}
	method precio(personaje){
		return perlas*2
	}
}

class Mascara inherits Artefacto{
	var oscuridad
	var minimo
	
	constructor(unIndiceOscuridad,nuevoPeso,fechaDeComprado) = super(nuevoPeso,fechaDeComprado){
		oscuridad = unIndiceOscuridad
		minimo = 4
	}
	method unidadesDeLucha(personaje){
			return minimo.max((fuerzaOscura.valor()/2)*oscuridad)
	}
	override method pesoAgregado(personaje){
		if(oscuridad != 0){
			return 0.max(self.unidadesDeLucha(personaje)-3)	
		}else{
			return 0 
		}
	}
	method minimo(valor){
		minimo = valor
	}	
	method precio(){
		return 10*oscuridad
	}
}

class Espejo inherits Artefacto{
	constructor(nuevoPeso,fechaDeComprado) = super(nuevoPeso,fechaDeComprado){
	}
	method unidadesDeLucha(personaje){
		if (personaje.artefactos()==[self]){
			return 0
		}else{
			return personaje.artefactos().filter({artefacto=>artefacto!=self}).map({artefacto=>artefacto.unidadesDeLucha(personaje)}).max()
		}
	}
	method precio(personaje){
		return 90
	}
	override method pesoAgregado(personaje){
		return 0
	}
}

class Armadura inherits Artefacto{
	var refuerzo
	var valorBase
	constructor(refuerzoNuevo,valorBaseLucha,nuevoPeso,fechaDeComprado) = super(nuevoPeso,fechaDeComprado){
		refuerzo = refuerzoNuevo
		valorBase = valorBaseLucha
	}
	method unidadesDeLucha(personaje){
		return valorBase + refuerzo.unidadesDeLucha(personaje)
	}
	override method pesoAgregado(personaje){
		return refuerzo.pesoAgregado(personaje)
	}
	method refuerzo(nuevoRefuerzo){
		refuerzo = nuevoRefuerzo
	}
	method valorBase(){
		return valorBase
	}
	method precio(personaje){
		return refuerzo.precioRefuerzo(self,personaje)
	}
}

class CotaDeMalla{ 
	var unidadDeLucha
	constructor(nuevaUnidadDeLucha) {
		unidadDeLucha = nuevaUnidadDeLucha
	}
	method unidadesDeLucha(personaje){
		return unidadDeLucha
	}
	method pesoAgregado(personaje){
		return 1
	}
	method precioRefuerzo(armadura,personaje){
		return unidadDeLucha/2
	}
}

class LibroDeHechizos{
	var listaHechizos
	constructor(hechizos){
		listaHechizos = hechizos
	}
	method poder(){
		return listaHechizos.filter({hechizo=>hechizo.hechizoPoderoso()}).sum({hechizo=>hechizo.poder()})
	}
	method esPoderoso(){
		return listaHechizos.any({hechizo=>hechizo.hechizoPoderoso()})
	}
	method agregarAListaHechizos(hechizo){
		listaHechizos.add(hechizo)
	}
	method precio(personaje){
		return 10*self.cantidadDeHechizos()+self.poder()
	}
	method cantidadDeHechizos(){
		return listaHechizos.size()
	}
}

class Artefacto{
	const peso
	const diasDeComprado
	constructor(unPeso,unDiasDeComprado){
		peso = unPeso
		diasDeComprado = unDiasDeComprado
	}
	method pesoTotal(personaje){
		return peso - self.factorDeCorreccion() + self.pesoAgregado(personaje)
	}
	method factorDeCorreccion(){
		return 1.min(diasDeComprado/1000)
	}
	method pesoAgregado(personaje)
	method peso(){
		return peso
	}
}

class Npc inherits Personaje{
	var nivel
	constructor(nuevoNivel,unHechizo,_artefactos,peso) = super(unHechizo,_artefactos,peso){
		nivel = nuevoNivel
	}
	override method habilidadLucha(){
			return super()*nivel.multiplicador()
	}
}