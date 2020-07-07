EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
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
L Driver_Motor:Pololu_Breakout_DRV8825 MC-SpoutL1
U 1 1 5EFB9951
P 2050 2400
F 0 "MC-SpoutL1" H 2050 3181 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 2050 3090 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 2250 1600 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 2150 2100 50  0001 C CNN
	1    2050 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C1
U 1 1 5EFBABCC
P 3100 2300
F 0 "C1" H 3215 2346 50  0000 L CNN
F 1 "100 uF" H 3215 2255 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 3100 2300 50  0001 C CNN
F 3 "~" H 3100 2300 50  0001 C CNN
	1    3100 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 1800 2100 1800
Wire Wire Line
	3100 1800 3100 2150
Wire Wire Line
	2150 3200 2500 3200
Wire Wire Line
	3100 3200 3100 2450
$Comp
L Device:CP1 C2
U 1 1 5EFCADB2
P 3150 4350
F 0 "C2" H 3265 4396 50  0000 L CNN
F 1 "100 uF" H 3265 4305 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 3150 4350 50  0001 C CNN
F 3 "~" H 3150 4350 50  0001 C CNN
	1    3150 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 3850 3150 3850
Wire Wire Line
	3150 3850 3150 4200
Wire Wire Line
	3150 5250 3150 4500
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-LeverL1
U 1 1 5EFD01B1
P 5000 1600
F 0 "MC-LeverL1" H 5000 2381 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 5000 2290 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 5200 800 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 5100 1300 50  0001 C CNN
	1    5000 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C4
U 1 1 5EFD01B7
P 6050 1500
F 0 "C4" H 6165 1546 50  0000 L CNN
F 1 "100 uF" H 6165 1455 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 6050 1500 50  0001 C CNN
F 3 "~" H 6050 1500 50  0001 C CNN
	1    6050 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 1000 6050 1000
Wire Wire Line
	6050 1000 6050 1350
Wire Wire Line
	5100 2400 6050 2400
Wire Wire Line
	6050 2400 6050 1650
$Comp
L Device:CP1 C3
U 1 1 5EFD3F3E
P 6000 4200
F 0 "C3" H 6115 4246 50  0000 L CNN
F 1 "100 uF" H 6115 4155 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 6000 4200 50  0001 C CNN
F 3 "~" H 6000 4200 50  0001 C CNN
	1    6000 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 3700 6000 3700
Wire Wire Line
	6000 3700 6000 4050
Wire Wire Line
	5050 5100 6000 5100
Wire Wire Line
	6000 5100 6000 4350
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-LeverR1
U 1 1 5EFD3F38
P 4950 4300
F 0 "MC-LeverR1" H 4950 5081 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 4950 4990 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 5150 3500 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 5050 4000 50  0001 C CNN
	1    4950 4300
	1    0    0    -1  
$EndComp
$Comp
L teensey:Teensy3.2 U1
U 1 1 5EFE2FDF
P 9950 2900
F 0 "U1" H 9950 4537 60  0000 C CNN
F 1 "Teensy3.2" H 9950 4431 60  0000 C CNN
F 2 "Teensey:Teensy30_31_32_LC" H 9950 2150 60  0001 C CNN
F 3 "" H 9950 2150 60  0000 C CNN
	1    9950 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8950 2650 4400 2650
Wire Wire Line
	4400 2650 4400 1700
Wire Wire Line
	4400 1700 4600 1700
Wire Wire Line
	8950 2550 7400 2550
Wire Wire Line
	7400 2550 7400 2750
Wire Wire Line
	7400 2750 4300 2750
Wire Wire Line
	4300 2750 4300 1600
Wire Wire Line
	4300 1600 4600 1600
Wire Wire Line
	8950 2850 4300 2850
Wire Wire Line
	4300 2850 4300 4500
Wire Wire Line
	4300 4500 4550 4500
Wire Wire Line
	8950 2750 8550 2750
Wire Wire Line
	8550 2750 8550 2900
Wire Wire Line
	8550 2900 4350 2900
Wire Wire Line
	4350 2900 4350 4400
Wire Wire Line
	4350 4400 4550 4400
Wire Wire Line
	8950 3550 8700 3550
Wire Wire Line
	8700 3550 8700 5800
Wire Wire Line
	1250 5800 1250 2600
Wire Wire Line
	1250 2600 1650 2600
Wire Wire Line
	1200 5850 1200 2500
Wire Wire Line
	1200 2500 1650 2500
Wire Wire Line
	8950 3950 8350 3950
Wire Wire Line
	8350 3950 8350 5550
Wire Wire Line
	1500 5550 1500 4650
Wire Wire Line
	8950 3850 8400 3850
Wire Wire Line
	8400 3850 8400 5600
Wire Wire Line
	1450 5600 1450 4550
Wire Wire Line
	1450 4550 1700 4550
$Comp
L Connector:Screw_Terminal_01x04 LeverL-ToMotor1
U 1 1 5F00F6D8
P 6350 1900
F 0 "LeverL-ToMotor1" H 6430 1892 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 6430 1801 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 6350 1900 50  0001 C CNN
F 3 "~" H 6350 1900 50  0001 C CNN
	1    6350 1900
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 LeverR-ToMotor1
U 1 1 5F010C08
P 6300 4600
F 0 "LeverR-ToMotor1" H 6380 4592 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 6380 4501 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 6300 4600 50  0001 C CNN
F 3 "~" H 6300 4600 50  0001 C CNN
	1    6300 4600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 SpoutR-ToMotor1
U 1 1 5F00E35C
P 3450 4800
F 0 "SpoutR-ToMotor1" H 3530 4792 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 3530 4701 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 3450 4800 50  0001 C CNN
F 3 "~" H 3450 4800 50  0001 C CNN
	1    3450 4800
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 SpoutL-ToMotor1
U 1 1 5F00C5DF
P 3400 2700
F 0 "SpoutL-ToMotor1" H 3480 2692 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 3480 2601 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 3400 2700 50  0001 C CNN
F 3 "~" H 3400 2700 50  0001 C CNN
	1    3400 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	8400 5600 1450 5600
Wire Wire Line
	1500 4650 1700 4650
Wire Wire Line
	8350 5550 1500 5550
Wire Wire Line
	8750 5850 1200 5850
Wire Wire Line
	8700 5800 1250 5800
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-SpoutR1
U 1 1 5EFCADAC
P 2100 4450
F 0 "MC-SpoutR1" H 2100 5231 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 2100 5140 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 2300 3650 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 2200 4150 50  0001 C CNN
	1    2100 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 2300 2750 2300
Wire Wire Line
	2750 2600 3200 2600
Wire Wire Line
	2450 2400 2700 2400
Wire Wire Line
	2700 2400 2700 2700
Wire Wire Line
	2700 2700 3200 2700
Wire Wire Line
	2450 2600 2650 2600
Wire Wire Line
	2650 2600 2650 2800
Wire Wire Line
	2650 2800 3200 2800
Wire Wire Line
	2450 2700 2600 2700
Wire Wire Line
	2600 2700 2600 2900
Wire Wire Line
	2600 2900 3200 2900
Wire Wire Line
	2500 4350 2950 4350
Wire Wire Line
	2950 4350 2950 4700
Wire Wire Line
	2950 4700 3250 4700
Wire Wire Line
	2500 4450 2900 4450
Wire Wire Line
	2900 4450 2900 4800
Wire Wire Line
	2900 4800 3250 4800
Wire Wire Line
	2500 4650 2850 4650
Wire Wire Line
	2850 4650 2850 4900
Wire Wire Line
	2850 4900 3250 4900
Wire Wire Line
	2500 4750 2800 4750
Wire Wire Line
	2800 4750 2800 5000
Wire Wire Line
	2800 5000 3250 5000
Wire Wire Line
	5900 1500 5900 1800
Wire Wire Line
	5900 1800 6150 1800
Wire Wire Line
	5400 1600 5850 1600
Wire Wire Line
	5850 1600 5850 1900
Wire Wire Line
	5850 1900 6150 1900
Wire Wire Line
	5400 1800 5800 1800
Wire Wire Line
	5800 1800 5800 2000
Wire Wire Line
	5800 2000 6150 2000
Wire Wire Line
	5400 1900 5750 1900
Wire Wire Line
	5750 1900 5750 2100
Wire Wire Line
	5750 2100 6150 2100
Wire Wire Line
	5350 4200 5800 4200
Wire Wire Line
	5800 4200 5800 4500
Wire Wire Line
	5800 4500 6100 4500
Wire Wire Line
	5350 4300 5750 4300
Wire Wire Line
	5750 4300 5750 4600
Wire Wire Line
	5750 4600 6100 4600
Wire Wire Line
	5350 4500 5700 4500
Wire Wire Line
	5700 4500 5700 4700
Wire Wire Line
	5700 4700 6100 4700
Wire Wire Line
	5350 4600 5650 4600
Wire Wire Line
	5650 4600 5650 4800
Wire Wire Line
	5650 4800 6100 4800
$Comp
L Connector:Screw_Terminal_01x04 FromTouch1
U 1 1 5F05C787
P 7700 3750
F 0 "FromTouch1" H 7618 3325 50  0000 C CNN
F 1 "Screw_Terminal_01x04" H 7618 3416 50  0000 C CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 7700 3750 50  0001 C CNN
F 3 "~" H 7700 3750 50  0001 C CNN
	1    7700 3750
	-1   0    0    1   
$EndComp
Wire Wire Line
	8750 3450 8750 5850
Wire Wire Line
	8950 3450 8750 3450
Wire Wire Line
	8400 2100 8300 2100
Wire Wire Line
	8400 2450 8400 2100
Wire Wire Line
	8950 2450 8400 2450
Wire Wire Line
	8450 2000 8300 2000
Wire Wire Line
	8450 2350 8450 2000
Wire Wire Line
	8950 2350 8450 2350
Wire Wire Line
	8500 1900 8300 1900
Wire Wire Line
	8500 2250 8500 1900
Wire Wire Line
	8950 2250 8500 2250
Wire Wire Line
	8550 1800 8300 1800
Wire Wire Line
	8550 2150 8550 1800
Wire Wire Line
	8950 2150 8550 2150
$Comp
L Connector:Screw_Terminal_01x04 FromZeros1
U 1 1 5F05AFB3
P 8100 2000
F 0 "FromZeros1" H 8018 1575 50  0000 C CNN
F 1 "Screw_Terminal_01x04" H 8018 1666 50  0000 C CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 8100 2000 50  0001 C CNN
F 3 "~" H 8100 2000 50  0001 C CNN
	1    8100 2000
	-1   0    0    1   
$EndComp
Wire Wire Line
	8950 3650 8050 3650
Wire Wire Line
	8050 3550 7900 3550
Wire Wire Line
	8950 3750 8000 3750
Wire Wire Line
	8000 3750 8000 3650
Wire Wire Line
	8000 3650 7900 3650
Wire Wire Line
	10950 4250 10950 4500
Wire Wire Line
	10950 4500 7950 4500
Wire Wire Line
	7950 4500 7950 3750
Wire Wire Line
	7950 3750 7900 3750
Wire Wire Line
	10950 4150 11000 4150
Wire Wire Line
	11000 4150 11000 4600
Wire Wire Line
	11000 4600 7900 4600
Wire Wire Line
	7900 4600 7900 3850
$Comp
L Connector:Barrel_Jack 9V1
U 1 1 5F03BFA0
P 950 800
F 0 "9V1" H 1007 1125 50  0000 C CNN
F 1 "Barrel_Jack" H 1007 1034 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 1000 760 50  0001 C CNN
F 3 "~" H 1000 760 50  0001 C CNN
	1    950  800 
	1    0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack 5V1
U 1 1 5F03C8F5
P 950 1400
F 0 "5V1" H 1007 1725 50  0000 C CNN
F 1 "Barrel_Jack" H 1007 1634 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 1000 1360 50  0001 C CNN
F 3 "~" H 1000 1360 50  0001 C CNN
	1    950  1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 1500 1400 1500
Wire Wire Line
	1250 700  2050 700 
Wire Wire Line
	1250 1300 1500 1300
$Comp
L Connector:TestPoint 5VGNDTEST1
U 1 1 5F0A18A8
P 700 1950
F 0 "5VGNDTEST1" H 758 2068 50  0000 L CNN
F 1 "TestPoint" H 758 1977 50  0000 L CNN
F 2 "TestPoint:TestPoint_Plated_Hole_D5.0mm" H 900 1950 50  0001 C CNN
F 3 "~" H 900 1950 50  0001 C CNN
	1    700  1950
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint 5VTEST1
U 1 1 5F0A3E7C
P 1700 1100
F 0 "5VTEST1" H 1758 1218 50  0000 L CNN
F 1 "TestPoint" H 1758 1127 50  0000 L CNN
F 2 "TestPoint:TestPoint_Plated_Hole_D5.0mm" H 1900 1100 50  0001 C CNN
F 3 "~" H 1900 1100 50  0001 C CNN
	1    1700 1100
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint 9VTEST1
U 1 1 5F0A469A
P 2850 1100
F 0 "9VTEST1" H 2908 1218 50  0000 L CNN
F 1 "TestPoint" H 2908 1127 50  0000 L CNN
F 2 "TestPoint:TestPoint_Plated_Hole_D5.0mm" H 3050 1100 50  0001 C CNN
F 3 "~" H 3050 1100 50  0001 C CNN
	1    2850 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	700  1950 700  2150
Wire Wire Line
	700  2150 1000 2150
Wire Wire Line
	1400 2150 1400 1500
Wire Wire Line
	1700 1100 1700 1300
Wire Wire Line
	2850 1100 2650 1100
Wire Wire Line
	2650 1100 2650 700 
Wire Wire Line
	5400 1500 5900 1500
$Comp
L Connector:TestPoint 9VGNDTEST1
U 1 1 5F128EBF
P 3550 1100
F 0 "9VGNDTEST1" H 3608 1218 50  0000 L CNN
F 1 "TestPoint" H 3608 1127 50  0000 L CNN
F 2 "TestPoint:TestPoint_Plated_Hole_D5.0mm" H 3750 1100 50  0001 C CNN
F 3 "~" H 3750 1100 50  0001 C CNN
	1    3550 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 3200 1400 3200
Wire Wire Line
	1400 3200 1400 2150
Connection ~ 1400 2150
Wire Wire Line
	2100 5250 1000 5250
Wire Wire Line
	1000 5250 1000 3250
Connection ~ 1000 2150
Wire Wire Line
	1000 2150 1400 2150
Wire Wire Line
	5000 2400 5000 3250
Wire Wire Line
	5000 3250 1000 3250
Connection ~ 1000 3250
Wire Wire Line
	1000 3250 1000 2150
Wire Wire Line
	4950 5100 4950 5350
Wire Wire Line
	4950 5350 1000 5350
Wire Wire Line
	1000 5350 1000 5250
Connection ~ 1000 5250
Wire Wire Line
	1700 4250 1500 4250
Wire Wire Line
	1500 4250 1500 3500
Wire Wire Line
	1500 3500 3750 3500
Wire Wire Line
	3750 1300 1700 1300
Connection ~ 1700 1300
Wire Wire Line
	4550 4100 3750 4100
Wire Wire Line
	3750 4100 3750 3500
Connection ~ 3750 3500
Wire Wire Line
	3750 1400 4600 1400
Connection ~ 3750 1400
Wire Wire Line
	3750 1400 3750 1300
Wire Wire Line
	1650 2200 1500 2200
Wire Wire Line
	1500 2200 1500 1300
Connection ~ 1500 1300
Wire Wire Line
	1500 1300 1700 1300
Wire Wire Line
	1250 900  2500 900 
Wire Wire Line
	3400 900  3400 1100
Wire Wire Line
	3400 1100 3550 1100
Wire Wire Line
	3400 1200 3400 1100
Connection ~ 3400 1100
Wire Wire Line
	4150 1000 4150 700 
Wire Wire Line
	4150 700  2650 700 
Connection ~ 5000 1000
Connection ~ 2650 700 
Wire Wire Line
	2050 1800 2050 700 
Connection ~ 2050 1800
Connection ~ 2050 700 
Wire Wire Line
	2050 700  2650 700 
Wire Wire Line
	2100 3850 2100 1800
Connection ~ 2100 3850
Connection ~ 2100 1800
Wire Wire Line
	2100 1800 3100 1800
Wire Wire Line
	2750 2300 2750 2600
Wire Wire Line
	2500 3200 2500 900 
Connection ~ 2500 3200
Wire Wire Line
	2500 3200 3100 3200
Connection ~ 2500 900 
Wire Wire Line
	4950 3700 4950 1000
Wire Wire Line
	4150 1000 4950 1000
Connection ~ 4950 3700
Connection ~ 4950 1000
Wire Wire Line
	4950 1000 5000 1000
Wire Wire Line
	2200 5250 3150 5250
Wire Wire Line
	2500 900  3400 900 
Wire Wire Line
	3400 1200 4000 1200
Wire Wire Line
	3750 3500 3750 1400
Wire Wire Line
	4000 1200 4000 2550
Wire Wire Line
	4000 2550 5100 2550
Wire Wire Line
	5100 2550 5100 2400
Connection ~ 5100 2400
Wire Wire Line
	4000 5500 5050 5500
Wire Wire Line
	5050 5500 5050 5100
Connection ~ 4000 2550
Connection ~ 5050 5100
Wire Wire Line
	4000 2550 4000 5500
Wire Wire Line
	4000 5500 2200 5500
Wire Wire Line
	2200 5500 2200 5250
Connection ~ 4000 5500
Connection ~ 2200 5250
$Comp
L Connector:Screw_Terminal_01x08 J1
U 1 1 5F227FA4
P 7450 1050
F 0 "J1" H 7368 1567 50  0000 C CNN
F 1 "Screw_Terminal_01x08" H 7368 1476 50  0000 C CNN
F 2 "" H 7450 1050 50  0001 C CNN
F 3 "~" H 7450 1050 50  0001 C CNN
	1    7450 1050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8950 1650 8700 1650
Wire Wire Line
	8700 1650 8700 750 
Wire Wire Line
	8700 750  7650 750 
Wire Wire Line
	8950 1750 8650 1750
Wire Wire Line
	8650 850  7650 850 
Wire Wire Line
	8650 850  8650 1750
Wire Wire Line
	8950 1850 8600 1850
Wire Wire Line
	8600 1850 8600 950 
Wire Wire Line
	8600 950  7650 950 
Wire Wire Line
	8950 1950 8900 1950
Wire Wire Line
	8900 1950 8900 1050
Wire Wire Line
	8900 1050 7650 1050
Wire Wire Line
	8950 2050 8850 2050
Wire Wire Line
	8850 2050 8850 1150
Wire Wire Line
	8850 1150 7650 1150
Wire Wire Line
	8050 3650 8050 3550
Wire Wire Line
	8950 4050 7300 4050
Wire Wire Line
	7300 4050 7300 1550
Wire Wire Line
	7300 1550 7900 1550
Wire Wire Line
	7900 1550 7900 1250
Wire Wire Line
	7900 1250 7650 1250
Wire Wire Line
	8950 4150 7250 4150
Wire Wire Line
	7250 4150 7250 1600
Wire Wire Line
	7250 1600 7850 1600
Wire Wire Line
	7850 1600 7850 1350
Wire Wire Line
	7850 1350 7650 1350
Wire Wire Line
	8950 4250 7200 4250
Wire Wire Line
	7200 4250 7200 1650
Wire Wire Line
	7200 1650 7700 1650
Wire Wire Line
	7700 1650 7700 1450
Wire Wire Line
	7700 1450 7650 1450
$EndSCHEMATC
