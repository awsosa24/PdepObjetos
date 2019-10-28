/************** TP2 V2.0 ***************/

class Transporte{
    var tardanza
    //var tipo =  #{}
    //var costo

	constructor()
	
    constructor(tardanzaTransporte ){
    	tardanza=tardanzaTransporte
    }
    
    
    method costo()

    method tardanza(){ /****/
        return tardanza
    }
    
}

/****/
class Avion inherits Transporte{
	
    var turbinas
    /*No se si se refiere a un(1) nivel de impulso por turbina o que cada turbina tiene una cant de impulso*/
    /*Supuse que es la segunda opcion*/
	
	constructor(tardanzaTransporte, unasTurbinas){
		tardanza=tardanzaTransporte
		turbinas= unasTurbinas
	}
	
    override method costo(){
        return turbinas.sum()
    }
}

class Micro inherits Transporte{
	var costo
	constructor(tardanzaTransporte, costoTransporte){
    	tardanza=tardanzaTransporte
    	costo=costoTransporte
    }
    
    override method costo(){
    	return costo
    }

}

class Tren inherits Transporte{
    var costo
    
    
    override method costo(){
        return 2300 * 0.62 //0.62 para medir el costo en kms
    }
}

class Barco inherits Transporte{
    var probabilidadDeChocar 

	constructor(tardanzaTransporte, probabilidadChoque){
		tardanza=tardanzaTransporte
		probabilidadDeChocar= probabilidadChoque
	//	costo=costoTransporte
	}
	
    override method costo(){
        return 1000 * probabilidadDeChocar
    }
}


class Localidad{
    var equipaje
    var precio
    var kilometro
	
	
    constructor (precioLocalidad,equipajeLocalidad,unKilometro){
		precio=precioLocalidad
		equipaje=equipajeLocalidad
        kilometro = unKilometro
	}
	
    method equipaje(){
        return equipaje
    } 
    
    method precio(){
        return precio
    }
	  
	method kilometro(){
        return kilometro
    }
    
    method esPeligroso(){
        return equipaje.contains("Vacuna Gripal") || equipaje.contains("Vacuna B")
    }

    method esImportante(){//equivalente a es Destacado
        return precio > 2000
    }

    method aplicarDescuento(descuento){
        precio = precio * (1 - descuento / 100)
    }   

    method agregarEquipaje(unEquipaje){
        equipaje.add(unEquipaje)
    }
}

/****/
class Playa inherits Localidad{
    override method esPeligroso(){
        return false
    }
}

class Montania inherits Localidad{
    var altura

	constructor (precioLocalidad,equipajeLocalidad,unKilometro, unaAltura){
		precio=precioLocalidad
		equipaje=equipajeLocalidad
        kilometro = unKilometro
        altura=unaAltura
	}
	
    method altura(unaAltura){
        altura = unaAltura
    }
    
    method altura(){
        return altura
    }

    override method esPeligroso(){
        return equipaje.contains("Vacuna Gripal") || equipaje.contains("Vacuna B") || altura > 5000
    }
    
    override method esImportante(){
    	return true
    }
}

class CiudadHistorica inherits Localidad{
	var museos
	
	constructor (precioLocalidad,equipajeLocalidad,unKilometro, cantidadMuseos){
		precio=precioLocalidad
		equipaje=equipajeLocalidad
        kilometro = unKilometro
        museos = cantidadMuseos
	}
	
	method museos(){
		return museos
	}
	
    override method esPeligroso(){
        return equipaje.contains("Seguro de asistencia al viajero")
    }
    
    override method esImportante(){
    	return museos >= 3 && precio > 2000
    }
}

class Viaje{
    var origen
    var destino
    var usuario
    var transporte

    constructor(unUsuario, unDestino, unTransporte){
        usuario = unUsuario
        origen = usuario.localidadDeOrigen()
        destino = unDestino
        transporte = unTransporte
    }

	method destino(){
		return destino
	}
    method precio(){
        return destino.precio() + self.kilometros() * transporte.costo()
    }

    method kilometros(){
        return (origen.kilometro() - destino.kilometro()).abs()
    }

}

class Usuario{
    var lugaresConocidos
    var saldo
    var seguidos
    var localidadDeOrigen
    var kilometros = 0
    var perfil /****/

    constructor(lugaresUsuario, saldoUsuario, localidadUsuario, unPerfil){
    	lugaresConocidos = lugaresUsuario
    	saldo = saldoUsuario
    	localidadDeOrigen = localidadUsuario
    	perfil = unPerfil
    }

    method localidadDeOrigen(){
        return localidadDeOrigen
    }
    
    method kilometros(){
    	return kilometros
    }
	
	method distanciaALocalidad(localidad){
        return  (self.kilometros() - localidad.kilometro()).abs()  
    }
    
	method puedeViajar(precioDeViaje){
		return precioDeViaje <= saldo 
	}
	
    method agregarDestino(destino){
        lugaresConocidos.add(destino)
    }
    
    method seguirA(unUsuario){
        seguidos.add(unUsuario)
        unUsuario.seguirA(self)
    }
    
    method lugaresConocidos(){
    	return lugaresConocidos
    }
    
    method saldo(){
    	return saldo
    }
    
    method saldo(nuevoSaldo){
    	saldo=nuevoSaldo
    }

    method perfil(nuevoPerfil){ /****/
        perfil = nuevoPerfil
    }

    method perfil(){ /****/
        return perfil
    }
    
    method viajar(unViaje){

        if(self.puedeViajar(unViaje.precio())){
            self.agregarDestino(unViaje.destino())
            saldo -= unViaje.precio()
            localidadDeOrigen = unViaje.destino()
            kilometros += unViaje.kilometros()
        }
        else{
            self.error("Dinero insuficiente para realizar el viaje")
            //error.throwWithMessage("Dinero insuficiente para realizar el viaje")
            //Me tira un error de que no puede resolver la referencia
        }
    }
    
    method elegirTransporte(transportes){
        return perfil.elegirTransporte(saldo, transportes)
    }
}

object empresarial{
    method elegirTransporte(saldo, transportes){
        return transportes.min({transporte => transporte.tardanza() })
    }
}

object estudiantil{
    method elegirTransporte(saldo, transportes){
        return transportes.filter({transporte => transporte.costo() <= saldo}).min({transporte => transporte.tardanza()})
    }
}

object familiar{
    method elegirTransporte(saldo, transportes){
        return transportes.anyOne()
    }
}


object barrileteCosmico {
    var destinos = #{garlicSSea, silverSSea, lastToninas, goodAirs}
    var transportes = #{}

	method transportes(){
		return transportes
	}
    method destinosMasImportantes(){
        return destinos.filter({destino => destino.esImportante() })
    }

    method aplicarDescuento(descuento){
        destinos.forEach({destino => destino.aplicarDescuento(descuento)})
        destinos.forEach({destino => destino.agregarEquipaje("Certificado de descuento")})
    }

    method esExtrema(){
        return destinos.any({destino => destino.esPeligroso()})
    }

    method destinos(){
        return destinos
    }
    
    method armarViaje(unUsuario, unaLocalidad){
        
        var unViaje = new Viaje(unUsuario, unaLocalidad, unUsuario.elegirTransporte(transportes)) 
        unUsuario.viajar(unViaje) 	
        }
    	
    method agregarTransporte(unTransporte){
        transportes.add(unTransporte)
    }
}

const garlicSSea  = new  Localidad(2500,#{"Caña de Pescar, Piloto"}, 344)
const silverSSea  = new  Localidad(1350,#{"Protector Solar", "Equipo de Buceo"}, 415)
const lastToninas = new  Localidad(3500,#{"Vacuna Gripal", "Vacuna B", "Necronomicon"}, 320)
const goodAirs    = new  Localidad(1500,#{"Cerveza", "Protector Solar"}, 0)

const pabloHari = new Usuario(#{lastToninas, goodAirs}, 10000, goodAirs, estudiantil)
