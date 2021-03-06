function [gmd] = gmaker(gtype, g, b)
	%% Расчёт настроечного размера прибора Gagemaker для контроля
	%%   трапецеидальных резьб
	%%
	%% Usage:
	%%     [GMD] = gmaker("plug", gage, ball)
	%%     [GMD] = gmaker("ring", gage, ball)
	%%
	%% Inputs:
	%%     gage   параметры калибра:
	%%            gage.P, gage.Ph    Шаг и ход резьбы калибра
	%%            gage.ang           Угол профиля
	%%            gage.d2 (или D2)   2-вектор предельных размеров среднего диаметра (D2 - для внутренних резьб)
	%%     ball   параметры измерительных шариков
	%%            ball.d             Диаметр шарика
	%%            ball.dsec          Диаметр лыски
	
	% Смещение вдоль оси противоположных заходов
	z = ax_offset(g);
	% Расстояние от центра до лыски
	h = ball_hcalc(b);
	% Ширина канавки на среднем диаметре
	w = g.P / 2;

	switch (gtype)
	case "plug"
		gmd(1) = gm_plug_dist(g.ang/2, min(g.d2)/2, w/2, b.d/2, z/2, h);
		gmd(2) = gm_plug_dist(g.ang/2, max(g.d2)/2, w/2, b.d/2, z/2, h);

	case "ring"
		gmd(1) = gm_ring_dist(g.ang/2, min(g.D2)/2, w/2, b.d/2, z/2, h);
		gmd(2) = gm_ring_dist(g.ang/2, max(g.D2)/2, w/2, b.d/2, z/2, h);

	otherwise
		error("Неизвестный тип объекта");

	endswitch
end



function z = ax_offset(g)
	%% Смещение вдоль оси противоположных заходов
	starts = g.Ph / g.P;
	% Углы заходов:
	ang = linspace(0, 360, starts + 1)(1:end-1);
	% Наиболее удалённый заход:
	oppos_ang = ang(min(abs(ang - 180)) == abs(ang-180));
	z = abs(oppos_ang - 180)/360 * g.Ph;
end



function h = ball_hcalc(b)
	%% Расстояние от центра до лыски
	h = sqrt((b.d/2)^2 - (b.dsec/2)^2);
end



function d = gm_plug_dist(ang2, r2, w2, rb, z2, h)
	%% Определение размера настройки прибора для наружной резьбы
	%%
	%% Inputs:
	%%     ang2   Половина угла профиля резьбы
	%%     r2     Половина среднего диаметра (скаляр)
	%%     w2     Половина ширины канавки впадины
	%%     rb     Радиус шарика
	%%     z2     Половина смещения противоположных канавок
	%%     h      Расстояние от центра шарика до лыски

	% Половина расстояния между точками контакта шариков и профиля
	wt2 = rb * cosd(ang2);
	% Расстояние от оси до центра шарика
	y = r2 + (wt2-w2)*cotd(ang2) + rb*sind(ang2);
	d = 2*(norm([y z2]) - h);
end



function d = gm_ring_dist(ang2, r2, w2, rb, z2, h)
	%% Определение размера настройки прибора для внутренней резьбы
	%%
	%% Inputs:
	%%     ang2   Половина угла профиля резьбы
	%%     r2     Половина среднего диаметра (скаляр)
	%%     w2     Половина ширины канавки впадины
	%%     rb     Радиус шарика
	%%     z2     Половина смещения противоположных канавок
	%%     h      Расстояние от центра шарика до лыски

	% Половина расстояния между точками контакта шариков и профиля
	wt2 = rb * cosd(ang2);
	% Расстояние от оси до центра шарика
	y = r2 - (wt2-w2)*cotd(ang2) - rb*sind(ang2);
	d = 2*(norm([y z2]) + h);
end

