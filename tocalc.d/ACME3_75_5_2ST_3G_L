#! /usr/bin/octave -qf

###### Параметры калибров-пробок 3.75"-5 ACME-2 STARTS-3G-LEFT ######

#plug.go.d2 = 91.055 + [-0.02 0.02];
#plug.ng.d2 = 92.118  + [-0.0265 0.0265];
#ring.go.D2 = 126.62  + [-0.026 0.026];
ring.ng.D2 = 92.118 + 0.0265*[-1 1];
plug.go.P   = plug.ng.P   = ring.go.P   = ring.ng.P   = thr.P   = 25.4/5;
plug.go.Ph  = plug.ng.Ph  = ring.go.Ph  = ring.ng.Ph  = thr.Ph  = 25.4/5*2;
plug.go.ang = plug.ng.ang = ring.go.ang = ring.ng.ang = thr.ang = 29;


###### Расчёт ######

ball = bchooser(thr.P, thr.ang)

#GM_PlugGo = gmaker("plug", plug.go, ball);
#GM_PlugNG = gmaker("plug", plug.ng, ball);
#GM_RingGo = gmaker("ring", ring.go, ball);
GM_RingNG = gmaker("ring", ring.ng, ball);


###### Вывод результатов ######

#printf("GM dist PlugGo = %.3f ... %.3f\n", GM_PlugGo);
#printf("GM dist PlugNG = %.3f ... %.3f\n", GM_PlugNG);
#printf("GM dist RingGo = %.3f ... %.3f\n", GM_RingGo);
printf("GM dist RingNG = %.3f ... %.3f\n", GM_RingNG);

