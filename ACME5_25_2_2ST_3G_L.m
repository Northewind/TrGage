#! /usr/bin/octave -qf

###### Параметры калибров 5.25"-2 ACME-2 STARTS-3G-LEFT ######

plug.go.d2 = 127.046 + [-0.02 0.02];
plug.ng.d2 = 127.64  + [-0.02 0.02];
ring.go.D2 = 126.62  + [-0.026 0.026];
ring.ng.D2 = 126.224 + [-0.026 0.026];
plug.go.P   = plug.ng.P   = ring.go.P   = ring.ng.P   = thr.P   = 25.4/2;
plug.go.Ph  = plug.ng.Ph  = ring.go.Ph  = ring.ng.Ph  = thr.Ph  = 25.4/2*2;
plug.go.ang = plug.ng.ang = ring.go.ang = ring.ng.ang = thr.ang = 29;


###### Расчёт ######

ball = bchooser(thr.P, thr.ang);

GM_PlugGo = gmaker("plug", plug.go, ball);
GM_PlugNG = gmaker("plug", plug.ng, ball);
GM_RingGo = gmaker("ring", ring.go, ball);
GM_RingNG = gmaker("ring", ring.ng, ball);


###### Вывод результатов ######

printf("GM dist PlugGo = %.3f ... %.3f\n", GM_PlugGo);
printf("GM dist PlugNG = %.3f ... %.3f\n", GM_PlugNG);
printf("GM dist RingGo = %.3f ... %.3f\n", GM_RingGo);
printf("GM dist RingNG = %.3f ... %.3f\n", GM_RingNG);

