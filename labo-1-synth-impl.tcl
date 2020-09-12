# labo-1-synth-impl.tcl
#
# NOTE: on peut lancer Vivado et l'exécution des commandes de ce fichier
# directement de l'invite de cmomande de Windows avec la commande :
# "C:\Xilinx\Vivado\2020.1\bin\vivado -mode tcl -source labo-1-synth-impl.tcl" 
#
# lecture des fichiers
read_vhdl ../vote_labo1.vhd
read_xdc ../labo-1-Basys-3.xdc

#synthese
synth_design -top vote_labo1 -generic W=4 -part xc7a35tcpg236-1 -assert

#implémentation (placement et routage)
place_design
route_design

#génération du fichier de configuration
write_bitstream -force fichier-de-programmation.bit

# programmation du FPGA
open_hw_manager
connect_hw_server
get_hw_targets
open_hw_target
current_hw_device [get_hw_devices xc7a35t_0]
set_property PROGRAM.FILE {fichier-de-programmation.bit} [get_hw_devices xc7a35t_0]
program_hw_devices [get_hw_devices xc7a35t_0]
