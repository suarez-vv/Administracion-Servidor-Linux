#!/usr/bin/tclsh

#MENÚ PARA LA ADMINISTRACIÓN DE ALTAS Y BAJAS DE USUARIO PARA 
#EL SERVIDOR LINUX

while {1} {
    exec clear >@stdout
    puts "\t========================================"
    puts "\t ADMINISTRACIÓN DE USUARIOS DEL SISTEMA "
    puts "\t========================================"

    puts "\t\t 1. Alta de usuario."
    puts "\t\t 2. Baja de usuario."
    puts "\t\t 3. Cambio de usuario."
    puts "\t\t 0. Salir del programa."
    puts -nonewline "\t\t Seleccione una opción: "
    flush stdout
    gets stdin opcion

    switch $opcion {
        1 {
            source "alta_usuario.tcl"
        }
        2 {
            source "baja_usuario.tcl"
        }
        3 {
            source "cambios_usuario.tcl"
        }
        0 {
            puts "\n\t Saliendo del programa...\n"
            puts "\n\t Presiona cualquier tecla para continuar..."
            gets stdin any
            break
        }
        default {
            puts "\n\t Opción no válida.\n"

            puts "\n\t Presiona cualquier tecla para continuar..."
            gets stdin any
        }
    }
}