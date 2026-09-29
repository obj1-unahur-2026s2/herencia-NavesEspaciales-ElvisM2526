//Modelo básico

class Nave {
  var velocidad = 0
  var direccion = 0
  var combustible = 0
  
  method combustible() = combustible
  method velocidad() = velocidad
  method direccion() = direccion

  method acelerar(cuanto) {
    velocidad = (velocidad + cuanto).min(100000)
  }

  method desacelerar(cuanto) {
    velocidad = (velocidad - cuanto).max(0)
  }
  
  method irHaciaElSol() {
    direccion = 10
  }

  method escaparDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0
  }

  method acercarseUnPocoAlSol() {
    direccion = (direccion + 1).min(10)
  }

  method alejarseUnPocoDelSol() {
    direccion = (direccion - 1).max(-10)
  }

  method cargarCombustible(unaCantidad) {
    combustible += unaCantidad
  }

  method descargarCombustible(unaCantidad) {
    combustible -= unaCantidad
  }

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
}

//Distintos tipos de nave

class Navebaliza inherits Nave {
  var colorDeBaliza = "Rojo"

  method colorDeBaliza() = colorDeBaliza
  
  method cambiarColorDeBaliza(colorNuevo) {
    colorDeBaliza = colorNuevo
  }

  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("Verde")
    self.ponerseParaleloAlSol()
  }
}

class NaveDePasajeros inherits Nave {
  const property cantidadDePasajeros = 0
  var cantidadDeComida = 0
  var cantidadDeBebidas = 0
  
  method cantidadDeComida() = cantidadDeComida
  method cantidadDeBebidas() = cantidadDeBebidas
  

  method cargarComida(unaCantidad) {
    cantidadDeComida += unaCantidad
  }

  method descargarComida(unaCantidad) {
    cantidadDeComida -= unaCantidad
  }

  method cargarBebidas(unaCantidad) {
    cantidadDeBebidas += unaCantidad
  }

  method descargarBebidas(unaCantidad) {
    cantidadDeBebidas -= unaCantidad
  }

  override method prepararViaje() {
    super()
    self.cargarComida(4 * cantidadDePasajeros)
    self.cargarBebidas(6 * cantidadDePasajeros)
    self.acercarseUnPocoAlSol()
  }
}

class NavesDeCombate inherits Nave {
  var mensajes = []
  var estaInvisible = false
  var misilesDesplegados = false
  
  method mensajesEmitidos() = mensajes
  method estaInvisible() = estaInvisible
  method misilesDesplegados() = misilesDesplegados

  method ponerseVisible() {
    estaInvisible = false
  }

  method ponerseInvisible() {
    estaInvisible = true
  }

  method desplegarMisiles() {
    misilesDesplegados = true
  }

  method replegarMisiles() {
    misilesDesplegados = false
  }

  method emitirMensaje(mensaje) {
    mensajes.add(mensaje)
  }

  method primerMensajeEmitido() {
    return mensajes.first()
  }

  method ultimoMensajeEmitido() {
    return mensajes.last()
  }

  method esEscueta() {
    return mensajes.all({unMensaje => unMensaje.size() <= 30})
  }

  method emitioMensaje(mensaje) {
    return mensajes.contains(mensaje)
  }

  override method prepararViaje() {
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  }
}

