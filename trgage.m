function [obj] = trgage(thr, type, varargin)
	## Расчёт калибров для трапецеидальных резьб
	##
	## Использование:
	##   [P]  = trgage(thr, "plug", plug)
	##   [R]  = trgage(thr, "ring", ring)
	##   [CP] = trgage(thr, "cplug", cplug, plug, ring)
	##
	## thr - параметры контролируемой резьбы
	##   thr.P, thr.Ph      Шаг и ход контролируемой
	##   thr.d, thr.D4      Номинальный наружный диаметр
	##   thr.Td2, thr.TD2   Допуски среднего диаметра
	##   thr.esd2           Основное отклонение
	##   thr.ang            Номинальный угол профиля, град
	##
	## plug - параметры рассчитываемых калибров-пробок
	##   plug.go.W          Износ (W_GO)
	##   plug.ng.W          Износ (W_NG)
	##   plug.T             Допуск среднего диаметра (T_PL)
	##   plug.go.Z          Расстояние от середины поля допуска T_PL/T_R ПР-калибров до проходного предела среднего диаметра резьбы (Z_PL)
	##
	## ring - параметры рассчитываемых калибров-колец
	##   ring.go.W          Износ (W_GO)
	##   ring.ng.W          Износ (W_NG)
	##   ring.T             Допуск среднего диаметра (T_R)
	##   ring.go.Z          Расстояние от середины поля допуска T_PL/T_R ПР-калибров до проходного предела среднего диаметра резьбы (Z_R)
	##
	## cplug - параметры рассчитываемых КИ-калибров-пробок
	##   cplug.T            Допуск среднего диаметра (T_cp)
	##

	#{
	    Нормативные документы:
	    ГОСТ 9484-81 ОНВ. Разьба трап. Профили
	    ГОСТ 9562-81 ОНВ. Резьба трап однозах. Допуски
	    ГОСТ 24739-81 ОНВ. Резьба трапец. многозах
	    ГОСТ 10071-89 Калибры для однозаходной трап резьбы
	    ГОСТ 24939-81 Калибры для целиндрич резьб. Виды
	    ГОСТ 27298-87 Калибры для многозах трап резьбы. Допуски
	#}

	#Номинальный средний диаметр контролируемой резьбы
	thr.d2 = thr.d - thr.P/2;
	thr.D2 = thr.D4 - thr.P/2;
	#Номинальный внутренний диаметр
	thr.d3 = thr.d - thr.P;
	thr.D1 = thr.d - thr.P;

	switch (type)
	case "plug"
		plug = varargin{1};
		obj = plug_calc(thr, plug);

	case "ring"
		ring = varargin{1};
		obj = ring_calc(thr, ring);

	case "cplug"
		cplug = varargin{1};
		plug = plug_calc(thr, varargin{2});
		ring = ring_calc(thr, varargin{3});
		obj = cplug_calc(thr, cplug, plug, ring);

	otherwise
		error("Неизвестный тип объекта");

	endswitch

	obj.go.P   = obj.ng.P   = thr.P;
	obj.go.Ph  = obj.ng.Ph  = thr.Ph;
	obj.go.ang = obj.ng.ang = thr.ang;
	
endfunction



function plug = plug_calc(thr, plug)
	#Расстояние между линией среднего диаметра и вершиной укороченного профиля резьбы калибра (F1)
	plug.ng.F1 = 0.1*thr.P;

	#Наружные диаметры
	plug.go.d = thr.d + plug.go.Z + [-plug.T plug.T];
	plug.ng.d = thr.D2 + thr.TD2 + plug.T/2 + 2*plug.ng.F1 + [-plug.T plug.T];
		
	#Средние диаметры
	plug.go.d2 = thr.D2 + plug.go.Z + [-plug.T/2 plug.T/2];
	plug.ng.d2 = thr.D2 + thr.TD2 + plug.T/2 + [-plug.T/2 plug.T/2];

	#Внутренние диаметры
	plug.go.d1 = thr.d3 + [-inf 0];
	plug.ng.d1 = thr.d3 + [-inf 0];
endfunction



function ring = ring_calc(thr, ring)
	#Расстояние между линией среднего диаметра и вершиной укороченного профиля резьбы калибра (F1)
	ring.ng.F1 = 0.1*thr.P;

	#Наружные диаметры
	ring.go.D = thr.D4 + [0 inf];
	ring.ng.D = thr.D4 + [0 inf];

	#Средние диаметры
	ring.go.D2 = thr.d2 + thr.esd2 - ring.go.Z + [-ring.T/2 ring.T/2];
	ring.ng.D2 = thr.d2 + thr.esd2 - thr.Td2 - ring.T/2 + [-ring.T/2 ring.T/2];

	#Внутренние диаметры
	ring.go.D1 = thr.D1 + [-ring.T/2 ring.T/2];
	ring.ng.D1 = thr.d2 + thr.esd2 - thr.Td2 - ring.T/2 - 2*ring.ng.F1 + [-ring.T ring.T];
endfunction



function cplug = cplug_calc(thr, cplug, plug, ring)
	#Наружные диаметры
	cplug.go.d = thr.d2 + thr.esd2 - ring.go.Z + ring.go.W + 2*ring.ng.F1 + [-plug.T/2 plug.T/2];
	cplug.ng.d = thr.d - thr.Td2 - ring.T/2 + ring.ng.W + [-plug.T plug.T];

	#Средние диаметры
	cplug.go.d2 = thr.d2 + thr.esd2 - ring.go.Z + ring.go.W + [-cplug.T/2 cplug.T/2];
	cplug.ng.d2 = thr.d2 + thr.esd2 - thr.Td2 - ring.T/2 + ring.ng.W + [-cplug.T/2 cplug.T/2];

	#Внутренние диаметры
	cplug.go.d1 = thr.d3 + [-inf 0];
	cplug.ng.d1 = thr.d3 - thr.Td2 + [-inf 0];
endfunction

