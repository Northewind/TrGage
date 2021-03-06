function gtol = tol(thread_tol, P, Ph)
	%% Допуски и величины, определяющие положение полей допусков и предел износа резьбовых калибров (согласно таблице 5 по ГОСТ 10071-89, ГОСТ 27298-87).
	%%
	%% Использование:
	%%     gtol = tol(thread_tol, P, Ph)
	%%
	%% Выходные параметры:
	%%     gtol - структура, содержащая поля:
	%%         T_R  - допуск внутреннего и среднего диаметра резьбового проходного и непроходного калибров-колец
	%%         T_PL - допуск наружного и среднего диаметра резьбового проходного и непроходного калибров-пробок
	%%         T_CP - допуск среднего диаметра резьбового контрольного проходного и непроходного калибров-пробок, резьбового калибра-пробки для контроля износа, установочного и сортировочного калибров-пробок
	%%         m    - расстояние между серединой поля допуска T_R проходного и непроходного резьбовых калибров-колец и серединой поля допуска T_CP резьбового контрольного проходного калибра-пробки
	%%         Z_R  - расстояние от середины поля доуска T_R резьбового проходного калибра-кольца до проходного (верхнего) предела среднего диаметра наружной резьбы
	%%         Z_PL - расстояние от середины поля допуска T_PL резьбового проходного калибра-пробки до проходного (нижнего) предела среднего диаметра внутренней резьбы
	%%         W_GO_R - величина среднедопустимого износа резьбовых проходных калибров-колец
	%%         W_GO_PL - величина среднедопустимого износа резьбовых проходных калибров-пробок
	%%         W_NG_R - величина среднедопустимого износа резьбовых непроходных калибров-колец
	%%         W_NG_PL - величина среднедопустимого износа резьбовых непроходных калибров-пробок
	%%
	%% Входные параметры:
	%%     thread_tol - допуск контролируемой резьбы
	%%     P          - шаг контролируемой резьбы
	%%     Ph         - ход контролируемой резьбы
	%%

	if (P == Ph) % Однозаходная резьба
		% Возможные предельные значения T_d2, T_D2
		tol_lims = [125 200 315 500 800 1180 1700 2120]/1000;
		T5=[26 16 14 22 12 17  30 25 22 17;
		    34 20 18 28 17 23  37 30 28 22;
		    42 26 22 35 29 35  48 39 36 28;
		    54 32 26 43 40 46  60 48 45 33;
		    66 38 30 51 48 54  72 57 54 39;
		    80 48 38 62 58 64  90 72 68 49;
		    96 58 46 74 70 76 108 87 81 60]/1000;
	elseif (isint(Ph/P)) % Многозаходная резьба
		tol_lims = [125 200 315 500 800 1180 1700 2400]/1000;
	    T5=[ 33 20 18 28 12 17  38  32  28 22;
		     43 25 23 35 17 23  47  38  35 28;
		     53 33 28 44 29 35  60  48  45 35;
		     68 40 33 54 40 46  75  60  57 42;
		     83 48 38 64 48 54  90  72  68 49;
		    100 60 48 78 58 64 113  90  85 62;
		    120 73 58 93 70 76 135 109 102 75]/1000;
	else
		error("Проверьте значения шага и хода резьбы")
	end
	if (thread_tol < min(tol_lims) || thread_tol > max(tol_lims))
		error("Проверьте допуск резьбы");
	end

	% Номер строки в таблице 5
	row_num = sum(thread_tol > tol_lims);

	gtol.T_R     = T5(row_num, 1);
	gtol.T_PL    = T5(row_num, 2);
	gtol.T_CP    = T5(row_num, 3);
	gtol.T_m     = T5(row_num, 4);
	gtol.Z_R     = T5(row_num, 5);
	gtol.Z_PL    = T5(row_num, 6);
	gtol.W_GO_R  = T5(row_num, 7);
	gtol.W_GO_PL = T5(row_num, 8);
	gtol.W_NG_R  = T5(row_num, 9);
	gtol.W_NG_PL = T5(row_num,10);
end


function a = isint(num)
	%% Test for argument (num) to be integer
	a = num == round(num);
end

