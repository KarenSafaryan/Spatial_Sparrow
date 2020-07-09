EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:CP1 C1
U 1 1 5EFBABCC
P 2000 1750
F 0 "C1" H 2115 1796 50  0000 L CNN
F 1 "100 uF" H 2115 1705 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 2000 1750 50  0001 C CNN
F 3 "~" H 2000 1750 50  0001 C CNN
	1    2000 1750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 HandleL-ToMotor1
U 1 1 5F00F6D8
P 9850 6750
F 0 "HandleL-ToMotor1" H 9930 6742 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 9930 6651 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 9850 6750 50  0001 C CNN
F 3 "~" H 9850 6750 50  0001 C CNN
	1    9850 6750
	0    1    1    0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 HandleR-ToMotor1
U 1 1 5F010C08
P 6750 6750
F 0 "HandleR-ToMotor1" H 6830 6742 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 6830 6651 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 6750 6750 50  0001 C CNN
F 3 "~" H 6750 6750 50  0001 C CNN
	1    6750 6750
	0    1    1    0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 SpoutR-ToMotor1
U 1 1 5F00E35C
P 4650 6750
F 0 "SpoutR-ToMotor1" H 4730 6742 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 4730 6651 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 4650 6750 50  0001 C CNN
F 3 "~" H 4650 6750 50  0001 C CNN
	1    4650 6750
	0    1    1    0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 SpoutL-ToMotor1
U 1 1 5F00C5DF
P 2250 6800
F 0 "SpoutL-ToMotor1" H 2330 6792 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 2330 6701 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 2250 6800 50  0001 C CNN
F 3 "~" H 2250 6800 50  0001 C CNN
	1    2250 6800
	0    1    1    0   
$EndComp
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-SpoutR1
U 1 1 5EFCADAC
P 3650 4500
F 0 "MC-SpoutR1" H 4000 5150 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 4250 5050 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 3850 3700 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 3750 4200 50  0001 C CNN
	1    3650 4500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x05 FromTouch1
U 1 1 5F05C787
P 7400 6950
F 0 "FromTouch1" H 7318 6525 50  0000 C CNN
F 1 "Screw_Terminal_01x05" H 7318 6616 50  0000 C CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 7400 6950 50  0001 C CNN
F 3 "~" H 7400 6950 50  0001 C CNN
	1    7400 6950
	-1   0    0    1   
$EndComp
$Comp
L Connector:Screw_Terminal_01x05 FromZeros1
U 1 1 5F05AFB3
P 10500 6950
F 0 "FromZeros1" H 10418 6525 50  0000 C CNN
F 1 "Screw_Terminal_01x05" H 10418 6616 50  0000 C CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 10500 6950 50  0001 C CNN
F 3 "~" H 10500 6950 50  0001 C CNN
	1    10500 6950
	-1   0    0    1   
$EndComp
$Comp
L Connector:Barrel_Jack 9V1
U 1 1 5F03BFA0
P 3600 12700
F 0 "9V1" H 3657 13025 50  0000 C CNN
F 1 "9V" H 3657 12934 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 3650 12660 50  0001 C CNN
F 3 "~" H 3650 12660 50  0001 C CNN
	1    3600 12700
	1    0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack 5V1
U 1 1 5F03C8F5
P 2450 13900
F 0 "5V1" H 2507 14225 50  0000 C CNN
F 1 "5V" H 2507 14134 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 2500 13860 50  0001 C CNN
F 3 "~" H 2500 13860 50  0001 C CNN
	1    2450 13900
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x08 J1
U 1 1 5F227FA4
P 8250 1600
F 0 "J1" H 8168 2117 50  0000 C CNN
F 1 "Screw_Terminal_01x08" H 8168 2026 50  0000 C CNN
F 2 "" H 8250 1600 50  0001 C CNN
F 3 "~" H 8250 1600 50  0001 C CNN
	1    8250 1600
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack 12V1
U 1 1 5F1009A2
P 2400 12550
F 0 "12V1" H 2457 12875 50  0000 C CNN
F 1 "12V" H 2457 12784 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 2450 12510 50  0001 C CNN
F 3 "~" H 2450 12510 50  0001 C CNN
	1    2400 12550
	0    1    1    0   
$EndComp
Text Notes 2800 1200 0    118  ~ 0
Stepper motor drivers\nHandles and Spout motors\n
Text Notes 1600 8300 0    118  ~ 0
Stimuli - analog output connection
$Comp
L Connector:RJ45 J2
U 1 1 5F1887E1
P 1950 9200
F 0 "J2" H 2007 9867 50  0000 C CNN
F 1 "RJ45" H 2007 9776 50  0000 C CNN
F 2 "" V 1950 9225 50  0001 C CNN
F 3 "~" V 1950 9225 50  0001 C CNN
	1    1950 9200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5F1C1431
P 3600 9700
F 0 "#PWR0101" H 3600 9450 50  0001 C CNN
F 1 "GND" V 3605 9572 50  0000 R CNN
F 2 "" H 3600 9700 50  0001 C CNN
F 3 "" H 3600 9700 50  0001 C CNN
	1    3600 9700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5F1C1B29
P 3600 10000
F 0 "#PWR0102" H 3600 9750 50  0001 C CNN
F 1 "GND" V 3605 9872 50  0000 R CNN
F 2 "" H 3600 10000 50  0001 C CNN
F 3 "" H 3600 10000 50  0001 C CNN
	1    3600 10000
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5F1C1DFA
P 3600 10100
F 0 "#PWR0103" H 3600 9850 50  0001 C CNN
F 1 "GND" V 3605 9972 50  0000 R CNN
F 2 "" H 3600 10100 50  0001 C CNN
F 3 "" H 3600 10100 50  0001 C CNN
	1    3600 10100
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0104
U 1 1 5F25EF9D
P 3250 2350
F 0 "#PWR0104" H 3250 2200 50  0001 C CNN
F 1 "+5V" V 3265 2478 50  0000 L CNN
F 2 "" H 3250 2350 50  0001 C CNN
F 3 "" H 3250 2350 50  0001 C CNN
	1    3250 2350
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0105
U 1 1 5F2624CA
P 3250 4300
F 0 "#PWR0105" H 3250 4150 50  0001 C CNN
F 1 "+5V" V 3265 4428 50  0000 L CNN
F 2 "" H 3250 4300 50  0001 C CNN
F 3 "" H 3250 4300 50  0001 C CNN
	1    3250 4300
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0106
U 1 1 5F2A2DB9
P 5350 2350
F 0 "#PWR0106" H 5350 2200 50  0001 C CNN
F 1 "+5V" V 5365 2478 50  0000 L CNN
F 2 "" H 5350 2350 50  0001 C CNN
F 3 "" H 5350 2350 50  0001 C CNN
	1    5350 2350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 5F2EFB61
P 3650 5300
F 0 "#PWR0108" H 3650 5050 50  0001 C CNN
F 1 "GND" H 3655 5127 50  0000 C CNN
F 2 "" H 3650 5300 50  0001 C CNN
F 3 "" H 3650 5300 50  0001 C CNN
	1    3650 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 5F2F01FF
P 3750 5300
F 0 "#PWR0109" H 3750 5050 50  0001 C CNN
F 1 "GND" H 3755 5127 50  0000 C CNN
F 2 "" H 3750 5300 50  0001 C CNN
F 3 "" H 3750 5300 50  0001 C CNN
	1    3750 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 5F2F2CD1
P 5750 3350
F 0 "#PWR0112" H 5750 3100 50  0001 C CNN
F 1 "GND" H 5755 3177 50  0000 C CNN
F 2 "" H 5750 3350 50  0001 C CNN
F 3 "" H 5750 3350 50  0001 C CNN
	1    5750 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 5F2FACF2
P 5850 3350
F 0 "#PWR0113" H 5850 3100 50  0001 C CNN
F 1 "GND" H 5855 3177 50  0000 C CNN
F 2 "" H 5850 3350 50  0001 C CNN
F 3 "" H 5850 3350 50  0001 C CNN
	1    5850 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 5F2FBC59
P 3650 3350
F 0 "#PWR0114" H 3650 3100 50  0001 C CNN
F 1 "GND" H 3655 3177 50  0000 C CNN
F 2 "" H 3650 3350 50  0001 C CNN
F 3 "" H 3650 3350 50  0001 C CNN
	1    3650 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 5F2FCBF6
P 3750 3350
F 0 "#PWR0115" H 3750 3100 50  0001 C CNN
F 1 "GND" H 3755 3177 50  0000 C CNN
F 2 "" H 3750 3350 50  0001 C CNN
F 3 "" H 3750 3350 50  0001 C CNN
	1    3750 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 5F3196D2
P 2000 1900
F 0 "#PWR0116" H 2000 1650 50  0001 C CNN
F 1 "GND" H 2005 1727 50  0000 C CNN
F 2 "" H 2000 1900 50  0001 C CNN
F 3 "" H 2000 1900 50  0001 C CNN
	1    2000 1900
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0117
U 1 1 5F31A33A
P 2000 1600
F 0 "#PWR0117" H 2000 1450 50  0001 C CNN
F 1 "+9V" H 2015 1773 50  0000 C CNN
F 2 "" H 2000 1600 50  0001 C CNN
F 3 "" H 2000 1600 50  0001 C CNN
	1    2000 1600
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0118
U 1 1 5F35B35D
P 5750 1950
F 0 "#PWR0118" H 5750 1800 50  0001 C CNN
F 1 "+9V" H 5765 2123 50  0000 C CNN
F 2 "" H 5750 1950 50  0001 C CNN
F 3 "" H 5750 1950 50  0001 C CNN
	1    5750 1950
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0119
U 1 1 5F35CF5B
P 3650 1950
F 0 "#PWR0119" H 3650 1800 50  0001 C CNN
F 1 "+9V" H 3665 2123 50  0000 C CNN
F 2 "" H 3650 1950 50  0001 C CNN
F 3 "" H 3650 1950 50  0001 C CNN
	1    3650 1950
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0120
U 1 1 5F35ECD6
P 3650 3900
F 0 "#PWR0120" H 3650 3750 50  0001 C CNN
F 1 "+9V" H 3665 4073 50  0000 C CNN
F 2 "" H 3650 3900 50  0001 C CNN
F 3 "" H 3650 3900 50  0001 C CNN
	1    3650 3900
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0122
U 1 1 5F366504
P 3900 12600
F 0 "#PWR0122" H 3900 12450 50  0001 C CNN
F 1 "+9V" H 3915 12773 50  0000 C CNN
F 2 "" H 3900 12600 50  0001 C CNN
F 3 "" H 3900 12600 50  0001 C CNN
	1    3900 12600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0123
U 1 1 5F366933
P 3900 12800
F 0 "#PWR0123" H 3900 12550 50  0001 C CNN
F 1 "GND" H 3905 12627 50  0000 C CNN
F 2 "" H 3900 12800 50  0001 C CNN
F 3 "" H 3900 12800 50  0001 C CNN
	1    3900 12800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0128
U 1 1 5F3A37C2
P 2350 9500
F 0 "#PWR0128" H 2350 9250 50  0001 C CNN
F 1 "GND" H 2355 9327 50  0000 C CNN
F 2 "" H 2350 9500 50  0001 C CNN
F 3 "" H 2350 9500 50  0001 C CNN
	1    2350 9500
	1    0    0    -1  
$EndComp
$Comp
L MC_board-rescue:MAX98306-spatialsparrow U2
U 1 1 5F0C05CB
P 3850 9750
F 0 "U2" V 3475 9800 50  0000 C CNN
F 1 "MAX98306" V 3566 9800 50  0000 C CNN
F 2 "spatialsparrow:MAX98306" H 4100 9800 50  0001 C CNN
F 3 "" H 4100 9800 50  0001 C CNN
	1    3850 9750
	0    1    1    0   
$EndComp
Wire Wire Line
	2350 9400 3000 9400
Wire Wire Line
	3000 9400 3000 9900
Wire Wire Line
	3000 9900 3600 9900
Wire Wire Line
	2350 9300 3100 9300
Wire Wire Line
	3100 9300 3100 10200
Wire Wire Line
	3100 10200 3600 10200
$Comp
L power:+5V #PWR0129
U 1 1 5F3D8F7F
P 3600 9600
F 0 "#PWR0129" H 3600 9450 50  0001 C CNN
F 1 "+5V" V 3615 9728 50  0000 L CNN
F 2 "" H 3600 9600 50  0001 C CNN
F 3 "" H 3600 9600 50  0001 C CNN
	1    3600 9600
	0    -1   -1   0   
$EndComp
Text Notes 1900 11950 0    118  ~ 0
Power connectors\n
Text Notes 14550 7150 0    157  ~ 0
INPUT PINS\n// Inputs for lick sensors\nLEVERSENSOR_L 15 // touch line for lever touch\nLEVERSENSOR_R 16 // touch line for lever touch\nSPOUTSENSOR_L 22 // touch line for left spout\nSPOUTSENSOR_R 23 // touch line for right spout\n// Pins for stepper - spouts\nPIN_SPOUTOUT_L 5\nPIN_SPOUTOUT_R 6\nPIN_SPOUTSTEP_L 13\nPIN_SPOUTDIR_L 14\nPIN_SPOUTSTEP_R 17\nPIN_SPOUTDIR_R 18\n// Pins for stepper - handles\nPIN_LEVEROUT_L 7\nPIN_LEVEROUT_R 8\nPIN_LEVERSTEP_L 9\nPIN_LEVERDIR_L 10\nPIN_LEVERSTEP_R 11\nPIN_LEVERDIR_R 12 \n\nOUTPUT PINS:\nPIN_LEFTLICK 19 // trigger that informs over left licks\nPIN_RIGHTLICK 20 // trigger that informs over right licks\nPIN_STIMTRIG 21 //  (no sync) 'MAKE_STIMTRIGGER' \nPIN_TRIALTRIG 4 // (no sync) 'MAKE_TRIALTRIGGER'\nPIN_CAMTIMER 3 // to trigger camera exposure 'camTrigDur', 'camTrigRate'.\n
$Comp
L power:+9V #PWR0121
U 1 1 5F361721
P 5750 3850
F 0 "#PWR0121" H 5750 3700 50  0001 C CNN
F 1 "+9V" H 5765 4023 50  0000 C CNN
F 2 "" H 5750 3850 50  0001 C CNN
F 3 "" H 5750 3850 50  0001 C CNN
	1    5750 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 5F2F15B0
P 5850 5250
F 0 "#PWR0111" H 5850 5000 50  0001 C CNN
F 1 "GND" H 5855 5077 50  0000 C CNN
F 2 "" H 5850 5250 50  0001 C CNN
F 3 "" H 5850 5250 50  0001 C CNN
	1    5850 5250
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0107
U 1 1 5F2A5CA9
P 5350 4250
F 0 "#PWR0107" H 5350 4100 50  0001 C CNN
F 1 "+5V" V 5365 4378 50  0000 L CNN
F 2 "" H 5350 4250 50  0001 C CNN
F 3 "" H 5350 4250 50  0001 C CNN
	1    5350 4250
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 5F2F109D
P 5750 5250
F 0 "#PWR0110" H 5750 5000 50  0001 C CNN
F 1 "GND" H 5755 5077 50  0000 C CNN
F 2 "" H 5750 5250 50  0001 C CNN
F 3 "" H 5750 5250 50  0001 C CNN
	1    5750 5250
	1    0    0    -1  
$EndComp
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-LeverR1
U 1 1 5EFD3F38
P 5750 4450
F 0 "MC-LeverR1" H 6150 5050 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 6600 4900 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 5950 3650 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 5850 4150 50  0001 C CNN
	1    5750 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0125
U 1 1 5F36E1BF
P 14250 3600
F 0 "#PWR0125" H 14250 3350 50  0001 C CNN
F 1 "GND" V 14255 3472 50  0000 R CNN
F 2 "" H 14250 3600 50  0001 C CNN
F 3 "" H 14250 3600 50  0001 C CNN
	1    14250 3600
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0127
U 1 1 5F36F155
P 14250 4400
F 0 "#PWR0127" H 14250 4250 50  0001 C CNN
F 1 "+5V" V 14265 4528 50  0000 L CNN
F 2 "" H 14250 4400 50  0001 C CNN
F 3 "" H 14250 4400 50  0001 C CNN
	1    14250 4400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 5F36E8AC
P 14250 4500
F 0 "#PWR0126" H 14250 4250 50  0001 C CNN
F 1 "GND" V 14255 4372 50  0000 R CNN
F 2 "" H 14250 4500 50  0001 C CNN
F 3 "" H 14250 4500 50  0001 C CNN
	1    14250 4500
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0124
U 1 1 5F36BC2C
P 12250 2100
F 0 "#PWR0124" H 12250 1850 50  0001 C CNN
F 1 "GND" H 12255 1927 50  0000 C CNN
F 2 "" H 12250 2100 50  0001 C CNN
F 3 "" H 12250 2100 50  0001 C CNN
	1    12250 2100
	1    0    0    -1  
$EndComp
$Comp
L MC_board-rescue:Teensy3.2-teensy U1
U 1 1 5EFE2FDF
P 13250 3450
F 0 "U1" H 13250 5087 60  0000 C CNN
F 1 "Teensy3.2" H 13250 4981 60  0000 C CNN
F 2 "lib:Teensy30_31_32_LC" H 13250 2700 60  0001 C CNN
F 3 "" H 13250 2700 60  0000 C CNN
	1    13250 3450
	1    0    0    -1  
$EndComp
Wire Notes Line
	1600 750  10000 750 
Wire Notes Line
	1600 750  1600 6650
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-LeverL1
U 1 1 5EFD01B1
P 5750 2550
F 0 "MC-LeverL1" H 6100 3200 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 6250 3100 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 5950 1750 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 5850 2250 50  0001 C CNN
	1    5750 2550
	1    0    0    -1  
$EndComp
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-SpoutL1
U 1 1 5EFB9951
P 3650 2550
F 0 "MC-SpoutL1" H 4050 3300 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 4200 3150 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 3850 1750 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 3750 2250 50  0001 C CNN
	1    3650 2550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J?
U 1 1 5F069700
P 5300 12600
F 0 "J?" H 5380 12592 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 5380 12501 50  0000 L CNN
F 2 "" H 5300 12600 50  0001 C CNN
F 3 "~" H 5300 12600 50  0001 C CNN
	1    5300 12600
	1    0    0    -1  
$EndComp
Text Notes 5000 13350 0    50   ~ 0
4x12 2x5 and 1x9 screw terminals
$Comp
L Connector:Screw_Terminal_01x06 SoundVision
U 1 1 5F0675E7
P 5450 7250
F 0 "SoundVision" H 5368 6785 50  0000 C CNN
F 1 "Screw_Terminal_01x06" H 5368 6876 50  0000 C CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x06_P5.08mm_Horizontal" H 5450 7250 50  0001 C CNN
F 3 "~" H 5450 7250 50  0001 C CNN
	1    5450 7250
	-1   0    0    1   
$EndComp
$Comp
L Connector:Screw_Terminal_01x06 SoundVision?
U 1 1 5F080410
P 3150 7250
F 0 "SoundVision?" H 3068 6785 50  0000 C CNN
F 1 "Screw_Terminal_01x06" H 3068 6876 50  0000 C CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x06_P5.08mm_Horizontal" H 3150 7250 50  0001 C CNN
F 3 "~" H 3150 7250 50  0001 C CNN
	1    3150 7250
	-1   0    0    1   
$EndComp
$Comp
L Connector:Screw_Terminal_01x05 sync_trigger_out
U 1 1 5F081E55
P 8250 2950
F 0 "sync_trigger_out" H 8168 2525 50  0000 C CNN
F 1 "Screw_Terminal_01x05" H 8168 2616 50  0000 C CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 8250 2950 50  0001 C CNN
F 3 "~" H 8250 2950 50  0001 C CNN
	1    8250 2950
	-1   0    0    1   
$EndComp
$EndSCHEMATC
