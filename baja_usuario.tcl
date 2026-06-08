#!/usr/bin/tclsh

proc validar_nombreUser {usuario} {

    #Validar que no este vacio
    if {$usuario eq ""} {
        puts "\n\t  Error: Debe ingresar un nombre de usuario."
        puts "\n\t  Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc verificar_existencia {usuario} {
    if {[catch {exec id $usuario}]} {
        puts "\n\t  Error: El usuario no existe."
        puts "\n\t  Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc eliminar_usuario {usuario} {
    if {![catch {exec sudo userdel -r $usuario} resultado]} {
        puts "\n\t  Error al eliminar usuario:"
        puts $resultado
        return 0
    }
    puts "\n\t  Usuario eliminado correctamente."
    return 1
}

exec clear >@stdout
puts "\n\t================================"
puts "\t       BAJA DE USUARIO"
puts "\t================================"

puts -nonewline "\t  Usuario a eliminar: "
flush stdout
gets stdin usuario

# Validar entrada
if {![validar_nombreUser $usuario]} {
    return
}

# Verificar si existe
if {![verificar_existencia $usuario]} {
    return
}

# Confirmación
puts -nonewline "\t  ¿Está seguro de eliminar '$usuario'? (s/n): "
flush stdout
gets stdin respuesta

#Si se cancela la operación
if {[string tolower $respuesta] ne "s"} {
    puts "\n\t  Operación cancelada."

    puts "\n\t  Presione ENTER para continuar..."
    gets stdin pausa
    return
}

# Eliminar usuario y su directorio personal
if {![eliminar_usuario $usuario]} {
    return
}

puts "\n\t  Presione ENTER para regresar al menú..."
gets stdin pausa