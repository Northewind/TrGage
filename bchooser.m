function [b prefd] = bchooser(P, ang)
	%% Выбор шарика Gagemaker для контроля резьбы. Также выводится предпочтительный диаметр шарика.
	%% 
	%% Usage:
	%%     [ball prefD] = bchooser(P, ang)
	%%
	%% Inputs:
	%%   P      Шаг резьбы
	%%   ang    Угол профиля резьбы
	prefd = P / (2 * cosd(ang / 2));
	balls = allballs();
	b = balls(1);
	for i = 2 : length(balls)
		if (abs(balls(i).d - prefd)  <  abs(b.d - prefd))
			b = balls(i);
		end
	end
end


function b = allballs()
	i = 0;
	b(++i).d  = 6.75;
	b(i).dsec = 4.415;
	b(++i).d  = 4.7752;
	b(i).dsec = 3.355;
	b(++i).d  = 3.25;
	b(i).dsec = 2.525;
	b(++i).d  = 2.666;
	b(i).dsec = 2.085;
end

