#!/usr/bin/tclsh

proc validar_nombreUser {usuario} {

    #Validar que no este vacio
    if {$usuario eq ""} {
        puts "\n\t  Error: Debe ingresar un nombre de usuario."
        puts "\n\t  Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }

    #Validar contenido
    if {![regexp {^[a-zA-Z0-9_-]+$} $usuario]} {
        puts "\n\t  El contenido del nombre de usuario no es valido."
        puts "\n\t  Solo se permiten letras,  numeros, '-' y '_'"
        puts "\n\t  Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc verificar_existencia_actual {usuario} {
    if {[catch {exec id $usuario}]} {
        puts "\n\t  Error: El usuario no existe."
        puts "\n\t  Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc verificar_existencia_nuevo {usuario} {
    if {![catch {exec id $usuario}]} {
        puts "\n\t  Error: El usuario ya existe."
        puts "\n\t  Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

proc modificar_usuario {nuevo actual} {
    if {[catch {exec sudo usermod -l $nuevo $actual 2>@stderr} resultado]} {
        puts "\n\t  Error al modificar usuario:"
        puts $resultado
        return 0

    } else {
        if {[catch {exec sudo usermod -d /home/$nuevo -m $nuevo 2>@stderr} resultado2]} {
            puts "\n\t  Error al modificar carpeta de home del usuario:"
            puts $resultado2
            return 0

        } else {
            puts "\n\t  Usuario y carpeta home modificados correctamente."
        }
    }
    return 1
}

proc modificar_contrasena {usuario password} {
    if {[catch {
        set pipe [open "|sudo chpasswd" w]
        puts $pipe "$usuario:$password"
        flush $pipe
        close $pipe
    } resultado]} {
        puts "\n\t  Error al cambiar contraseña:"
        puts "$resultado"
        return 0
    } else {
        puts "\n\t  Contraseña actualizada correctamente."
    }
        return 1
}

proc validar_contrasena {password} {
    if {[string length $password] < 4} {
        puts "\n\t  Error: La contraseña debe tener al menos 4 caracteres."
        puts "\n\t  Presione ENTER para continuar..."
        gets stdin pausa
        return 0
    }
    return 1
}

while {1} {
    exec clear >@stdout
    puts "\n\t================================"
    puts "\t       CAMBIOS DE USUARIO"
    puts "\t================================"
    puts "\t  1. Cambiar nombre de usuario"
    puts "\t  2. Cambiar contraseña"
    puts "\t  0. Regresar"
    puts -nonewline "\n\t  Seleccione una opción: "
    flush stdout

    gets stdin opcion

    switch $opcion {

        1 {
            puts -nonewline "\n\t  Usuario actual: "
            flush stdout
            gets stdin actual

            if {![validar_nombreUser $actual]} {
                break
            }

            if {![verificar_existencia_actual $actual]} {
                break
            }

            puts -nonewline "\t  Nuevo nombre: "
            flush stdout
            gets stdin nuevo

            if {![validar_nombreUser $nuevo]} {
                break
            }

            if {![verificar_existencia_nuevo $nuevo]} {
                break
            }

            if {![modificar_usuario $nuevo $actual]} {
                break
            }

            puts "\n\t  Presione ENTER para continuar..."
            gets stdin pausa
        }

        2 {

            puts -nonewline "\n\t  Usuario: "
            flush stdout
            gets stdin usuario

            if {![validar_nombreUser $usuario]} {
                break
            }

            if {![verificar_existencia_actual $usuario]} {
                break
            }

            puts -nonewline "\t  Nueva contraseña: "
            flush stdout
            gets stdin password

            if {![validar_contrasena $password]} {
                break
            }

            if {![modificar_contrasena $usuario $password]} {
                return
            }
        
            puts "\n\t  Presione ENTER para continuar..."
            gets stdin pausa
        }

        0 {
            break
        }

        default {
            puts "\n\t  Opción inválida."
            puts "\n\t  Presione ENTER para continuar..."
            gets stdin pausa
        }
    }
}
