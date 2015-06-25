###### Контролируемая резьба: Tr130x24(P12)-7H ######

# Шаг и ход контролируемой
thr.P = 12;
thr.Ph = 24;
# Номинальный наружный диаметр
thr.d = thr.D4 = 130;
# Допуски среднего диаметра
thr.Td2 = 500/1000;      # Наружная резьба
thr.TD2 = 670/1000;      # Внутренняя резьба
# Основные отклоненения
thr.esd2 = -170/1000;
thr.EID2 = 0;
# Угол профиля резьбы (номинал), град
thr.ang = 30;



###### Калибры ######

#Износ (W_GO, W_NG)
plug.go.W = 60/1000;
plug.ng.W = 42/1000;
ring.go.W = 75/1000;
ring.ng.W = 57/1000;

#Допуски среднего диаметра (T_PL, T_R; T_cp)
plug.T = 40/1000;
ring.T = 68/1000;
cplug.T = 33/1000;

#Расстояние от середины поля допуска T_PL/T_R ПР-калибров до проходного предела среднего диаметра резьбы (Z_PL, Z_R)
plug.go.Z = 46/1000;
ring.go.Z = 40/1000;

#Допуск угла профиля (T_alpha1, T_alpha2), град 
plug.go.A = ring.go.A = 12*2 /60;
plug.ng.A = ring.ng.A = 15*2 /60;



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

