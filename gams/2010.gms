$eolcom #
Sets
i / BFG,COG,LDG /
j / jh,120sj,70sj,320sj,400sj,qt,1750gl,350gl,3200gl,lg1,lg2,lg3,1xx,zb,zhb,khb,rzbb,lz,dx,ct,sh,rlgl
/
;
Parameters
A(i)     煤气总量
/
BFG 9.252296E+9
COG 1.071481E+9
LDG 7.140853E+8
/
B(j)    煤气用户热量需求
/jh     14614918.45e9
120sj   1360799.55e9
70sj    145687.62e9
320sj   341202.93e9
400sj   460460.27e9
qt      1245138.80e9
1750gl  10356917.06e9
350gl   6415552.60e9
3200gl  2886468.75e9
lg1     564662.58e9
lg2     1185079.27e9
lg3     575948.68e9
1xx     1169629.76e9
zb      2474150.20e9
zhb     3091507.20e9
khb     1230938.54e9
rzbb    2354968.67e9
lz      394360.13e9
dx      232046.70e9
ct      80173.01e9
sh      1213845.97e9
rlgl    599684.45e9
/

Weight(j)   用户权重（从1到10）
/jh     6
120sj   6
70sj    4
320sj   7
400sj   8
qt      5
1750gl  6
350gl   4
3200gl  5
lg1     5
lg2     5
lg3     5
1xx     5
zb      5
zhb     5
khb     5
rzbb    5
lz      6
dx      5
ct      6
sh      6
rlgl    4
/

C(i)    煤气热值
/
BFG 3430.12e3
COG 17164.3e3
LDG 6869.88e3
/
D(j)  用户热值需求
/jh     3400e3
120sj   8400e3
70sj    8400e3
320sj   8400e3
400sj   8400e3
qt      4500e3
1750gl  3400e3
350gl   3400e3
3200gl  3400e3
lg1     6800e3
lg2     6800e3
lg3     6800e3
1xx     8400e3
zb      8400e3
zhb     8400e3
khb     8400e3
rzbb    8400e3
lz      8400e3
dx      8400e3
ct      8400e3
sh      7434e3
rlgl    8400e3
/
CP(i)   煤气定压热容
/
BFG 1099.3
COG 1522.5
LDG 1062.35
/

Y(i)   空气过剩系数
/
BFG 1.15
COG 1.23
LDG 1.19
/
X(i)   单位立方米理论空气需求量
/
BFG 0.6069
COG 4.4715
LDG 1.5531
/

R(i)  单位立方米理论烟气排放
/
BFG 1.7913
COG 6.2482
LDG 2.2473
/
tpre1(j) 空气预热温度
/jh     380
120sj   0
70sj    0
320sj   0
400sj   0
qt      0
1750gl  280
350gl   280
3200gl  280
lg1     0
lg2     0
lg3     0
1xx     280
zb      280
zhb     280
khb     280
rzbb    280
lz      280
dx      0
ct      0
sh      230
rlgl    230
/
tpre2(j)   煤气预热温度
/jh     15
120sj   15
70sj    15
320sj   15
400sj   15
qt      15
1750gl  20
350gl   20
3200gl  20
lg1     20
lg2     20
lg3     20
1xx     12.5
zb      7.5
zhb     15
khb     15
rzbb    15
lz      15
dx      15
ct      15
sh      15
rlgl    15
/
tw(j)       烟气排放温度
/jh     230
120sj   280
70sj    280
320sj   280
400sj   280
qt      0
1750gl  230
350gl   230
3200gl  230
lg1     180
lg2     180
lg3     180
1xx     580
zb      580
zhb     580
khb     580
rzbb    580
lz      580
dx      580
ct      580
sh      130
rlgl    230
/
Cpa(j)      空气比热容
/
jh      559.63
120sj   1211.03
70sj    1211.03
320sj   1211.03
400sj   1211.03
qt      1211.03
1750gl  643.91
350gl   643.91
3200gl  643.91
lg1     1211.03
lg2     1211.03
lg3     1211.03
1xx     643.91
zb      643.91
zhb     643.91
khb     643.91
rzbb    643.91
lz      643.91
dx      643.91
ct      643.91
sh      699.61
rlgl    699.61
/
Cpw(j)    烟气比热容
/jh     750.34
120sj   693
70sj    693
320sj   693
400sj   693
qt      1215.13
1750gl  750.34
350gl   750.34
3200gl  750.34
lg1     820.56
lg2     820.56
lg3     820.56
1xx     491.12
zb      491.12
zhb     491.12
khb     491.12
rzbb    491.12
lz      491.12
dx      491.12
ct      491.12
sh      907.11
rlgl    750.34
/
;
Variables
E(i,j)
Qa(j)
Qg(j)
Qc(j)
Qw1(j)
Qw2(j)
Eta(j)
wta
Etaavg
;
E.lo(i,j)=0.01;
Qa.lo(j)=0.01;
Qg.lo(j)=0.01;
Qc.lo(j) = 0.01;
Qw1.lo(j) = 0.01;
Qw2.lo(j) = 0.01;
Eta.lo(j) = 0.01;
wta.lo = 0.01;
Etaavg.lo=0.01;

Equations    #Equation declaration
Q_air(j) 空气显热
Q_gas(j) 煤气显热
Q_cost(j)   用户j使用的煤气总热量
Q_waste(j)  用户j烟气排放散失的热量
Q_waste2(j) 用户j燃烧过程热损失，经验值
Eff(j)      用户j的效率
Weight_sum  权值总和
Eff_avg_weighted 效率的加权平均

Gas_count(i)   煤气总量约束条件
User_Q(j)      用户j的热值约束
User_qv(j)     用户j的热量约束

Gas_ldg     转炉煤气全部用完约束条件
Gas_surplus_q 剩余煤气的热值约束
;

#Equation defination
Q_air(j) .. Qa(j) =e= sum(i, E(i,j) * X(i) * Y(i) * Cpa(j) * tpre1(j));
Q_gas(j) .. Qg(j) =e= sum(i, E(i,j) * CP(i) * tpre2(j));
Q_cost(j) .. Qc(j) =e= sum(i, C(i)*E(i,j));
Q_waste(j) .. Qw1(j) =e= sum(i, E(i,j) * R(i) * CPw(j) * tw(j));
Q_waste2(j) .. Qw2(j) =e= Qc(j) * 0.0908;
Eff(j) .. Eta(j) =e= 1 - (Qw1(j)+Qw2(j))/(Qa(j)+Qg(j)+Qc(j));
Weight_sum .. wta =e= sum(j, weight(j));
Eff_avg_weighted .. Etaavg =e= sum(j, Eta(j)*weight(j)) / wta;      #目标函数，加权平均后的效率

#约束条件
Gas_count(i) .. sum(j,E(i,j)) =l= A(i);
User_Q(j) .. sum(i,C(i)*E(i,j)) =g= B(j);
User_qv(j) .. sum(i,C(i)*E(i,j))/sum(i,E(i,j)) =g= D(j);

Gas_ldg .. sum(j,E('LDG',j)) =e= A('LDG');
Gas_surplus_q .. sum(i, (A(i)-sum(j,E(i,j)))*C(i))/sum(i, A(i)-sum(j,E(i,j))) =e= 6140e3;

model gas /all/;
solve gas using qlp maximizing Etaavg;

display E.l, Etaavg.l;

