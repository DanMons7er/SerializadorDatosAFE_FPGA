

Command: %s
53*	vivadotcl2N
:synth_design -top mainInstantiation -part xc7a200tsbg484-12default:defaultZ4-113h px? 
:
Starting synth_design
149*	vivadotclZ4-321h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a200t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a200t2default:defaultZ17-349h px? 
W
Loading part %s157*device2$
xc7a200tsbg484-12default:defaultZ21-403h px? 
?
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
22default:defaultZ8-7079h px? 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px? 
_
#Helper process launched with PID %s4824*oasys2
78082default:defaultZ8-7075h px? 
?
%s*synth2?
xStarting RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 1178.605 ; gain = 89.711
2default:defaulth px? 
?
synthesizing module '%s'638*oasys2%
mainInstantiation2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
462default:default8@Z8-638h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
diffBuff2default:default2b
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/diffBuff.vhd2default:default2
372default:default2 
DfBfCLK_inst2default:default2
diffBuff2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
1872default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2
diffBuff2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/diffBuff.vhd2default:default2
432default:default8@Z8-638h px? 
g
%s
*synth2O
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter DIFF_TERM bound to: 0 - type: bool 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter DQS_BIAS bound to: FALSE - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter IBUF_DELAY_VALUE bound to: 0 - type: string 
2default:defaulth p
x
? 
^
%s
*synth2F
2	Parameter IBUF_LOW_PWR bound to: 1 - type: bool 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter IFD_DELAY_VALUE bound to: AUTO - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 
2default:defaulth p
x
? 
?
,binding component instance '%s' to cell '%s'113*oasys2
IBUFDS_inst2default:default2
IBUFDS2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/diffBuff.vhd2default:default2
472default:default8@Z8-113h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
diffBuff2default:default2
12default:default2
12default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/diffBuff.vhd2default:default2
432default:default8@Z8-256h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
diffBuff2default:default2b
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/diffBuff.vhd2default:default2
372default:default2"
DfBfFrame_inst2default:default2
diffBuff2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
1922default:default8@Z8-3491h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
diffBuff2default:default2b
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/diffBuff.vhd2default:default2
372default:default2!
DfBfData_inst2default:default2
diffBuff2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
1972default:default8@Z8-3491h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2!
CLK_RETRIEVER2default:default2g
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
342default:default2"
Retriever_inst2default:default2!
CLK_RETRIEVER2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
2132default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2!
CLK_RETRIEVER2default:default2i
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
422default:default8@Z8-638h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Buff2default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/Buff.vhd2default:default2
372default:default2
BuffFB_inst2default:default2
Buff2default:default2i
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
712default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2
Buff2default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/Buff.vhd2default:default2
422default:default8@Z8-638h px? 
?
,binding component instance '%s' to cell '%s'113*oasys2
	BUFG_inst2default:default2
BUFG2default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/Buff.vhd2default:default2
452default:default8@Z8-113h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
Buff2default:default2
22default:default2
12default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/Buff.vhd2default:default2
422default:default8@Z8-256h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
PLL2default:default2]
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/PLL.vhd2default:default2
362default:default2
PLL_inst2default:default2
PLL2default:default2i
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
742default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2
PLL2default:default2_
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/PLL.vhd2default:default2
462default:default8@Z8-638h px? 
e
%s
*synth2M
9	Parameter BANDWIDTH bound to: OPTIMIZED - type: string 
2default:defaulth p
x
? 
b
%s
*synth2J
6	Parameter CLKFBOUT_MULT bound to: 3 - type: integer 
2default:defaulth p
x
? 
i
%s
*synth2Q
=	Parameter CLKFBOUT_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKIN1_PERIOD bound to: 3.571000 - type: double 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT0_DIVIDE bound to: 3 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT0_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT0_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT1_DIVIDE bound to: 3 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT1_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
i
%s
*synth2Q
=	Parameter CLKOUT1_PHASE bound to: 90.000000 - type: double 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT2_DIVIDE bound to: 3 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT2_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
j
%s
*synth2R
>	Parameter CLKOUT2_PHASE bound to: 180.000000 - type: double 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT3_DIVIDE bound to: 3 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT3_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
j
%s
*synth2R
>	Parameter CLKOUT3_PHASE bound to: 270.000000 - type: double 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT4_DIVIDE bound to: 3 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT4_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT4_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT5_DIVIDE bound to: 3 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT5_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT5_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
b
%s
*synth2J
6	Parameter DIVCLK_DIVIDE bound to: 1 - type: integer 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter REF_JITTER1 bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter STARTUP_WAIT bound to: FALSE - type: string 
2default:defaulth p
x
? 
?
,binding component instance '%s' to cell '%s'113*oasys2#
PLLE2_BASE_inst2default:default2

PLLE2_BASE2default:default2_
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/PLL.vhd2default:default2
632default:default8@Z8-113h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
PLL2default:default2
32default:default2
12default:default2_
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/PLL.vhd2default:default2
462default:default8@Z8-256h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Buff2default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/Buff.vhd2default:default2
372default:default2#
BuffPhase0_inst2default:default2
Buff2default:default2i
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
832default:default8@Z8-3491h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Buff2default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/Buff.vhd2default:default2
372default:default2#
BuffPhase1_inst2default:default2
Buff2default:default2i
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
842default:default8@Z8-3491h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Buff2default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/Buff.vhd2default:default2
372default:default2#
BuffPhase2_inst2default:default2
Buff2default:default2i
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
852default:default8@Z8-3491h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Buff2default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/Buff.vhd2default:default2
372default:default2#
BuffPhase3_inst2default:default2
Buff2default:default2i
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
862default:default8@Z8-3491h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2!
CLK_RETRIEVER2default:default2
42default:default2
12default:default2i
SC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/CLK_RETRIEVER.vhd2default:default2
422default:default8@Z8-256h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
MUX42default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX4.vhd2default:default2
332default:default2
Mux_inst2default:default2
MUX42default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
2202default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2
MUX42default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX4.vhd2default:default2
422default:default8@Z8-638h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
MUX22default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX2.vhd2default:default2
342default:default2
	MuxA_ints2default:default2
MUX22default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX4.vhd2default:default2
562default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2
MUX22default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX2.vhd2default:default2
412default:default8@Z8-638h px? 
?
,binding component instance '%s' to cell '%s'113*oasys2%
BUFGMUX_CTRL_inst2default:default2 
BUFGMUX_CTRL2default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX2.vhd2default:default2
442default:default8@Z8-113h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
MUX22default:default2
52default:default2
12default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX2.vhd2default:default2
412default:default8@Z8-256h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
MUX22default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX2.vhd2default:default2
342default:default2
	MuxB_ints2default:default2
MUX22default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX4.vhd2default:default2
572default:default8@Z8-3491h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
MUX22default:default2^
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX2.vhd2default:default2
342default:default2
	MuxC_ints2default:default2
MUX22default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX4.vhd2default:default2
582default:default8@Z8-3491h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
MUX42default:default2
62default:default2
12default:default2`
JC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/MUX4.vhd2default:default2
422default:default8@Z8-256h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
S2P2default:default2]
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/S2P.vhd2default:default2
372default:default2
SERDES_inst2default:default2
S2P2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
2272default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2
S2P2default:default2_
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/S2P.vhd2default:default2
602default:default8@Z8-638h px? 
d
%s
*synth2L
8	Parameter BUFR_DIVIDE bound to: BYPASS - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter SIM_DEVICE bound to: 7SERIES - type: string 
2default:defaulth p
x
? 
?
,binding component instance '%s' to cell '%s'113*oasys2$
BUFR_ClkDiv_inst2default:default2
BUFR2default:default2_
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/S2P.vhd2default:default2
1342default:default8@Z8-113h px? 
_
%s
*synth2G
3	Parameter DATA_RATE bound to: DDR - type: string 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter DATA_WIDTH bound to: 14 - type: integer 
2default:defaulth p
x
? 
i
%s
*synth2Q
=	Parameter DYN_CLKDIV_INV_EN bound to: FALSE - type: string 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter DYN_CLK_INV_EN bound to: FALSE - type: string 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter INIT_Q1 bound to: 1'b0 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter INIT_Q2 bound to: 1'b0 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter INIT_Q3 bound to: 1'b0 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter INIT_Q4 bound to: 1'b0 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter INTERFACE_TYPE bound to: NETWORKING - type: string 
2default:defaulth p
x
? 
_
%s
*synth2G
3	Parameter IOBDELAY bound to: NONE - type: string 
2default:defaulth p
x
? 
X
%s
*synth2@
,	Parameter IS_CLKB_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter IS_CLKDIVP_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	Parameter IS_CLKDIV_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
W
%s
*synth2?
+	Parameter IS_CLK_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
U
%s
*synth2=
)	Parameter IS_D_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
Y
%s
*synth2A
-	Parameter IS_OCLKB_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
X
%s
*synth2@
,	Parameter IS_OCLK_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter NUM_CE bound to: 1 - type: integer 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter OFB_USED bound to: FALSE - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter SERDES_MODE bound to: MASTER - type: string 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter SRVAL_Q1 bound to: 1'b0 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter SRVAL_Q2 bound to: 1'b0 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter SRVAL_Q3 bound to: 1'b0 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter SRVAL_Q4 bound to: 1'b0 
2default:defaulth p
x
? 
?
,binding component instance '%s' to cell '%s'113*oasys2)
ISERDESE2_Master_inst2default:default2
	ISERDESE22default:default2_
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/S2P.vhd2default:default2
1642default:default8@Z8-113h px? 
_
%s
*synth2G
3	Parameter DATA_RATE bound to: DDR - type: string 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter DATA_WIDTH bound to: 14 - type: integer 
2default:defaulth p
x
? 
i
%s
*synth2Q
=	Parameter DYN_CLKDIV_INV_EN bound to: FALSE - type: string 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter DYN_CLK_INV_EN bound to: FALSE - type: string 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter INIT_Q1 bound to: 1'b0 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter INIT_Q2 bound to: 1'b0 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter INIT_Q3 bound to: 1'b0 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter INIT_Q4 bound to: 1'b0 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter INTERFACE_TYPE bound to: NETWORKING - type: string 
2default:defaulth p
x
? 
_
%s
*synth2G
3	Parameter IOBDELAY bound to: NONE - type: string 
2default:defaulth p
x
? 
X
%s
*synth2@
,	Parameter IS_CLKB_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter IS_CLKDIVP_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	Parameter IS_CLKDIV_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
W
%s
*synth2?
+	Parameter IS_CLK_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
U
%s
*synth2=
)	Parameter IS_D_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
Y
%s
*synth2A
-	Parameter IS_OCLKB_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
X
%s
*synth2@
,	Parameter IS_OCLK_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter NUM_CE bound to: 1 - type: integer 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter OFB_USED bound to: FALSE - type: string 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter SERDES_MODE bound to: SLAVE - type: string 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter SRVAL_Q1 bound to: 1'b0 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter SRVAL_Q2 bound to: 1'b0 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter SRVAL_Q3 bound to: 1'b0 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter SRVAL_Q4 bound to: 1'b0 
2default:defaulth p
x
? 
?
,binding component instance '%s' to cell '%s'113*oasys2(
ISERDESE2_Slave_inst2default:default2
	ISERDESE22default:default2_
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/S2P.vhd2default:default2
2312default:default8@Z8-113h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
S2P2default:default2
72default:default2
12default:default2_
IC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/S2P.vhd2default:default2
602default:default8@Z8-256h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
FSM_Bit2default:default2a
MC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/FSM_Bit.vhd2default:default2
342default:default20
FiniteStateMachine_BitAllign2default:default2
FSM_Bit2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
2482default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2
FSM_Bit2default:default2c
MC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/FSM_Bit.vhd2default:default2
572default:default8@Z8-638h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
FSM_Bit2default:default2
82default:default2
12default:default2c
MC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/FSM_Bit.vhd2default:default2
572default:default8@Z8-256h px? 
?
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
	FSM_Frame2default:default2c
OC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/FSM_Frame.vhd2default:default2
342default:default22
FiniteStateMachine_FrameAllign2default:default2
	FSM_Frame2default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
2692default:default8@Z8-3491h px? 
?
synthesizing module '%s'638*oasys2
	FSM_Frame2default:default2e
OC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/FSM_Frame.vhd2default:default2
582default:default8@Z8-638h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
	FSM_Frame2default:default2
92default:default2
12default:default2e
OC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/FSM_Frame.vhd2default:default2
582default:default8@Z8-256h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2%
mainInstantiation2default:default2
102default:default2
12default:default2d
NC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/sources_1/new/mainInst.vhd2default:default2
462default:default8@Z8-256h px? 
?
%s*synth2?
yFinished RTL Elaboration : Time (s): cpu = 00:00:07 ; elapsed = 00:00:07 . Memory (MB): peak = 1232.660 ; gain = 143.766
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Handling Custom Attributes : Time (s): cpu = 00:00:07 ; elapsed = 00:00:08 . Memory (MB): peak = 1232.660 ; gain = 143.766
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:07 ; elapsed = 00:00:08 . Memory (MB): peak = 1232.660 ; gain = 143.766
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0052default:default2
1232.6602default:default2
0.0002default:defaultZ17-268h px? 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
102default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
>

Processing XDC Constraints
244*projectZ1-262h px? 
=
Initializing timing engine
348*projectZ1-569h px? 
?
Parsing XDC File [%s]
179*designutils2f
PC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/constrs_1/new/Contraints.xdc2default:default8Z20-179h px? 
?
?Setting CLOCK_DEDICATED_ROUTE constraint on the PARENT net instead of the specified net segment (net name: %s). Placer only honors CLOCK_DEDICATED_ROUTE when set on the PARENT net, e.g. net segment directly connected to the driver. To eliminate this message, please update your constraint to specify the PARENT net instead.2810*	planAhead2
Mux_inst/OA2default:default2f
PC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/constrs_1/new/Contraints.xdc2default:default2
202default:default8@Z12-4777h px?
?
?Setting CLOCK_DEDICATED_ROUTE constraint on the PARENT net instead of the specified net segment (net name: %s). Placer only honors CLOCK_DEDICATED_ROUTE when set on the PARENT net, e.g. net segment directly connected to the driver. To eliminate this message, please update your constraint to specify the PARENT net instead.2810*	planAhead2
Mux_inst/OB2default:default2f
PC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/constrs_1/new/Contraints.xdc2default:default2
212default:default8@Z12-4777h px?
?
Finished Parsing XDC File [%s]
178*designutils2f
PC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/constrs_1/new/Contraints.xdc2default:default8Z20-178h px? 
?
?Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2d
PC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.srcs/constrs_1/new/Contraints.xdc2default:default27
#.Xil/mainInstantiation_propImpl.xdc2default:defaultZ1-236h px? 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1334.6722default:default2
0.0002default:defaultZ17-268h px? 
?
!Unisim Transformation Summary:
%s111*project2?
?  A total of 4 instances were transformed.
  BUFGMUX_CTRL => BUFGCTRL (inverted pins: S0): 3 instances
  PLLE2_BASE => PLLE2_ADV: 1 instance 
2default:defaultZ1-111h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.0042default:default2
1334.6722default:default2
0.0002default:defaultZ17-268h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
Finished Constraint Validation : Time (s): cpu = 00:00:16 ; elapsed = 00:00:17 . Memory (MB): peak = 1334.672 ; gain = 245.777
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Loading part: xc7a200tsbg484-1
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Loading Part and Timing Information : Time (s): cpu = 00:00:16 ; elapsed = 00:00:17 . Memory (MB): peak = 1334.672 ; gain = 245.777
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:16 ; elapsed = 00:00:17 . Memory (MB): peak = 1334.672 ; gain = 245.777
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:16 ; elapsed = 00:00:17 . Memory (MB): peak = 1334.672 ; gain = 245.777
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    3 Bit       Adders := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    2 Bit       Adders := 1     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               14 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                8 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                3 Bit    Registers := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                2 Bit    Registers := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 10    
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   14 Bit        Muxes := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    3 Bit        Muxes := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input    3 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    2 Bit        Muxes := 8     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    1 Bit        Muxes := 8     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input    1 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2m
YPart Resources:
DSPs: 740 (col length:100)
BRAMs: 730 (col length: RAMB18 100 RAMB36 50)
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:18 ; elapsed = 00:00:19 . Memory (MB): peak = 1334.672 ; gain = 245.777
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:25 ; elapsed = 00:00:26 . Memory (MB): peak = 1334.672 ; gain = 245.777
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
}Finished Timing Optimization : Time (s): cpu = 00:00:25 ; elapsed = 00:00:26 . Memory (MB): peak = 1334.672 ; gain = 245.777
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
|Finished Technology Mapping : Time (s): cpu = 00:00:25 ; elapsed = 00:00:26 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
vFinished IO Insertion : Time (s): cpu = 00:00:30 ; elapsed = 00:00:31 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Instances : Time (s): cpu = 00:00:30 ; elapsed = 00:00:31 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:30 ; elapsed = 00:00:31 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Ports : Time (s): cpu = 00:00:30 ; elapsed = 00:00:31 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Handling Custom Attributes : Time (s): cpu = 00:00:30 ; elapsed = 00:00:31 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Nets : Time (s): cpu = 00:00:30 ; elapsed = 00:00:31 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px? 
J
%s*synth22
+------+-------------+------+
2default:defaulth px? 
J
%s*synth22
|      |Cell         |Count |
2default:defaulth px? 
J
%s*synth22
+------+-------------+------+
2default:defaulth px? 
J
%s*synth22
|1     |BUFG         |     6|
2default:defaulth px? 
J
%s*synth22
|2     |BUFGMUX_CTRL |     3|
2default:defaulth px? 
J
%s*synth22
|3     |BUFR         |     1|
2default:defaulth px? 
J
%s*synth22
|4     |ISERDESE2    |     2|
2default:defaulth px? 
J
%s*synth22
|6     |LUT1         |     2|
2default:defaulth px? 
J
%s*synth22
|7     |LUT2         |    33|
2default:defaulth px? 
J
%s*synth22
|8     |LUT3         |    18|
2default:defaulth px? 
J
%s*synth22
|9     |LUT4         |    20|
2default:defaulth px? 
J
%s*synth22
|10    |LUT5         |     3|
2default:defaulth px? 
J
%s*synth22
|11    |LUT6         |    14|
2default:defaulth px? 
J
%s*synth22
|12    |PLLE2_BASE   |     1|
2default:defaulth px? 
J
%s*synth22
|13    |FDCE         |     5|
2default:defaulth px? 
J
%s*synth22
|14    |FDPE         |    23|
2default:defaulth px? 
J
%s*synth22
|15    |FDRE         |    34|
2default:defaulth px? 
J
%s*synth22
|16    |LDC          |    22|
2default:defaulth px? 
J
%s*synth22
|17    |IBUF         |     1|
2default:defaulth px? 
J
%s*synth22
|18    |IBUFDS       |     3|
2default:defaulth px? 
J
%s*synth22
|19    |OBUF         |     8|
2default:defaulth px? 
J
%s*synth22
+------+-------------+------+
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Writing Synthesis Report : Time (s): cpu = 00:00:30 ; elapsed = 00:00:31 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
r
%s
*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 0 warnings.
2default:defaulth p
x
? 
?
%s
*synth2?
Synthesis Optimization Runtime : Time (s): cpu = 00:00:20 ; elapsed = 00:00:28 . Memory (MB): peak = 1354.523 ; gain = 163.617
2default:defaulth p
x
? 
?
%s
*synth2?
?Synthesis Optimization Complete : Time (s): cpu = 00:00:30 ; elapsed = 00:00:31 . Memory (MB): peak = 1354.523 ; gain = 265.629
2default:defaulth p
x
? 
B
 Translating synthesized netlist
350*projectZ1-571h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0032default:default2
1358.3672default:default2
0.0002default:defaultZ17-268h px? 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
322default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
12default:default2
22default:defaultZ31-138h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1376.2852default:default2
0.0002default:defaultZ17-268h px? 
?
!Unisim Transformation Summary:
%s111*project2?
?  A total of 26 instances were transformed.
  BUFGMUX_CTRL => BUFGCTRL (inverted pins: S0): 3 instances
  LDC => LDCE: 22 instances
  PLLE2_BASE => PLLE2_ADV: 1 instance 
2default:defaultZ1-111h px? 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
632default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:372default:default2
00:00:412default:default2
1376.2852default:default2
287.3912default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2e
QC:/Tesis/Versiones/TesisV3/SERDES_EM/SERDES_EM.runs/synth_1/mainInstantiation.dcp2default:defaultZ17-1381h px? 
?
%s4*runtcl2?
xExecuting : report_utilization -file mainInstantiation_utilization_synth.rpt -pb mainInstantiation_utilization_synth.pb
2default:defaulth px? 
?
Exiting %s at %s...
206*common2
Vivado2default:default2,
Mon Aug  2 15:41:52 20212default:defaultZ17-206h px? 


End Record