#! /usr/bin/octave -qf

###### Контролируемая резьба: Tr32x6-7H ######

# Шаг и ход контролируемой
thr.P = 6;
thr.Ph = 6;
# Номинальный наружный диаметр
thr.d = thr.D4 = 32;
# Допуски среднего диаметра (ГОСТ 9562)
thr.Td2 = 335/1000;      # Наружная резьба
thr.TD2 = 450/1000;      # Внутренняя резьба
# Основные отклоненения (ГОСТ 9562)
thr.esd2 = -118/1000;
# Номинальный угол профиля, град
thr.ang = 30;



###### Калибры ######

# Допуски среднего диаметра (T_PL, T_R; T_cp - ГОСТ 10071)
plug.T = 26/1000;
ring.T = 42/1000;
cplug.T = 22/1000;

# Расстояние от середины поля допуска T_PL/T_R ПР-калибров до проходного предела среднего диаметра резьбы (Z_PL, Z_R - ГОСТ 10071)
plug.go.Z = 35/1000;
ring.go.Z = 29/1000;

# Износ (W_GO, W_NG - ГОСТ 10071)
plug.go.W = 39/1000;
plug.ng.W = 28/1000;
ring.go.W = 48/1000;
ring.ng.W = 36/1000;

# Допуск угла профиля (T_alpha1, T_alpha2 - ГОСТ 10071), град 
plug.go.A = ring.go.A = 8*2 /60;
plug.ng.A = ring.ng.A = 10*2 /60;


###### Расчёт ######

plug = trgage(thr, "plug", plug);
ring = trgage(thr, "ring", ring);
cplug = trgage(thr, "cplug", cplug, plug, ring);

ball = bchooser(thr.P, thr.ang);

GM_PlugGo = gmaker("plug", plug.go, ball);
GM_PlugNG = gmaker("plug", plug.ng, ball);
GM_RingGo = gmaker("ring", ring.go, ball);
GM_RingNG = gmaker("ring", ring.ng, ball);
GM_CPlugGo = gmaker("plug", cplug.go, ball);
GM_CPlugNG = gmaker("plug", cplug.ng, ball);


###### Вывод результатов ######

printf("GM dist PlugGo = %.3f ... %.3f\n", GM_PlugGo);
printf("GM dist PlugNG = %.3f ... %.3f\n", GM_PlugNG);
printf("GM dist RingGo = %.3f ... %.3f\n", GM_RingGo);
printf("GM dist RingNG = %.3f ... %.3f\n", GM_RingNG);
printf("GM dist CPlugGo = %.3f ... %.3f\n", GM_CPlugGo);
printf("GM dist CPlugNG = %.3f ... %.3f\n", GM_CPlugNG);

