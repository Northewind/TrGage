function g = trgage(thr, type)
	## Расчёт калибров для трапецеидальных резьб
	##
	## Использование:
	##     [P]  = trgage(thr, "plug")
	##     [R]  = trgage(thr, "ring")
	##     [CP] = trgage(thr, "cplug")
	##
	## Входные параметры:
	##     thr - параметры контролируемой резьбы
	##       thr.P, thr.Ph      Шаг и ход контролируемой
	##       thr.d, thr.D4      Номинальный наружный диаметр
	##       thr.Td2, thr.TD2   Допуски среднего диаметра
	##       thr.esd2           Основное отклонение
	##       thr.ang            Номинальный угол профиля, град
	##
	## Использованные нормативные документы:
	##     ГОСТ 9484-81 ОНВ. Разьба трап. Профили
	##     ГОСТ 9562-81 ОНВ. Резьба трап однозах. Допуски
	##     ГОСТ 24739-81 ОНВ. Резьба трапец. многозах
	##     ГОСТ 10071-89 Калибры для однозаходной трап резьбы
	##     ГОСТ 24939-81 Калибры для цилиндрич резьб. Виды
	##     ГОСТ 27298-87 Калибры для многозах трап резьбы. Допуски
	##

	# Номинальный средний диаметр контролируемой резьбы
	thr.d2 = thr.d - thr.P/2;
	thr.D2 = thr.D4 - thr.P/2;
	# Номинальный внутренний диаметр
	thr.d3 = thr.d - thr.P;
	thr.D1 = thr.d - thr.P;
	# Расстояние между линией среднего диаметра и вершиной укороченного профиля резьбы калибра
	F1 = 0.1 * thr.P;

	switch (type)
	case "plug"
		gtol = tol(thr.TD2, thr.P, thr.Ph);
		g.go = plugGO(thr, gtol);
		g.ng = plugNG(thr, gtol, F1);
	case "ring"
		gtol = tol(thr.Td2, thr.P, thr.Ph);
		g.go = ringGO(thr, gtol);
		g.ng = ringNG(thr, gtol, F1);
	case "cplug"
		gtol = tol(thr.TD2, thr.P, thr.Ph);
		g.go = cplugGO(thr, gtol, F1);
		g.ng = cplugNG(thr, gtol);
	otherwise
		error("Неизвестный тип объекта");
	end
	g.go.ang = g.ng.ang = thr.ang;
	g.go.P = g.ng.P = thr.P;
	g.go.Ph = g.ng.Ph = thr.Ph;
end



function res = plugGO(thr, gtol)
	res.d = thr.d + gtol.Z_PL;
	res.d = res.d + gtol.T_PL*[-1 1];
	res.d2 = thr.D2 + gtol.Z_PL;
	res.d2_wearlim = res.d2 - gtol.W_GO_PL;
	res.d2 = res.d2 + gtol.T_PL/2*[-1 1];
	res.d1 = thr.d3;
	res.d1 = res.d1 + [-inf 0];
end

function res = plugNG(thr, gtol, F1)
	res.d = thr.D2 + thr.TD2 + gtol.T_PL/2 + 2*F1;
	res.d = res.d + gtol.T_PL*[-1 1];
	res.d2 = thr.D2 + thr.TD2 + gtol.T_PL/2;
	res.d2_wearlim = res.d2 - gtol.W_NG_PL;
	res.d2 = res.d2 + gtol.T_PL/2*[-1 1];
	res.d1 = thr.d3;
	res.d1 = res.d1 + [-inf 0];
end


function res = ringGO(thr, gtol)
	res.D = thr.D4;
	res.D = res.D + [0 inf];
	res.D2 = thr.d2 + thr.esd2 - gtol.Z_R;
	res.D2 = res.D2 + gtol.T_R/2*[-1 1]
	res.D1 = thr.D1;
	res.D1 = res.D1 + gtol.T_R/2*[-1 1];
end

function res = ringNG(thr, gtol, F1)
	res.D = thr.D4;
	res.D = res.D + [0 inf];
	res.D2 = thr.d2 + thr.esd2 - thr.Td2 - gtol.T_R/2;
	res.D2 = res.D2 + gtol.T_R/2*[-1 1];
	res.D1 = thr.d2 + thr.esd2 - thr.Td2 - gtol.T_R/2 - 2*F1
	res.D1 = res.D1 + gtol.T_R*[-1 1];
end


function res = cplugGO(thr, gtol, F1)
	%% Расчёт калибра-пробки для контроля износа проходных калибров-колец
	res.d = thr.d2 + thr.esd2 - gtol.Z_R + gtol.W_GO_R + 2*F1;
	res.d = res.d + gtol.T_PL/2*[-1 1];
	res.d2 = thr.d2 + thr.esd2 - gtol.Z_R + gtol.W_GO_R;
	res.d2 = res.d2 + gtol.T_CP/2*[-1 1];
	res.d1 = thr.d3;
	res.d1 = res.d1 + [-inf 0];
end

function res = cplugNG(thr, gtol)
	%% Расчёт калибра-пробки для контроля износа НЕпроходных калибров-колец
	res.d = thr.d - thr.Td2 - gtol.T_R/2 + gtol.W_NG_R;
	res.d = res.d + gtol.T_PL*[-1 1];
	res.d2 = thr.d2 + thr.esd2 - thr.Td2 - gtol.T_R/2 + gtol.W_NG_R;
	res.d2 = res.d2 + gtol.T_CP/2*[-1 1];
	res.d1 = thr.d3 - thr.Td2;
	res.d1 = res.d1 + [-inf 0];
end

