function print_gage(g, p, d, typ)
	%% Расчёт калибров для метрических резьб. Выводит параметры калибров на печать.
	%%
	%% Использование:
	%%     print_gage(g, p, d, "plug")
	%%     print_gage(g, p, d, "ring")
	%%     print_gage(g, p, d, "cplug")
	%%
	%% Входные параметры:
	%%     g - структура, содержащая поля-размеры рассчитываемого калибра (для ПР и НЕ):
	%%         g.go.d,  g.ng.d,  g.go.D,  g.ng.D   - наружный диаметр, мм
	%%         g.go.d2, g.ng.d2, g.go.D2, g.ng.D2  - средний диаметр, мм
	%%         g.go.d1, g.ng.d1, g.go.D1, g.ng.D1  - внутренний диаметр, мм
	%%         g.go.d2_wearlim, g.ng.d2_wearlim,
	%%         g.go.D2_wearlim, g.ng.D2_wearlim    - предельные значения
	%%                                среднего диаметра с учётом износа, мм
	%%     p - шаг контролируемой резьбы, мм
	%%     d - номинальный наружный диаметр резьбы, мм
	%%

	switch (typ)
	case "plug"
		go_d_min = min(g.go.d);
		go_d_max = max(g.go.d);
		go_d_mn = mean([go_d_min go_d_max]);
		go_d2_min = min(g.go.d2);
		go_d2_max = max(g.go.d2);
		go_d2_mn = mean([go_d2_min go_d2_max]);
		go_d1_min = min(g.go.d1);
		go_d1_max = max(g.go.d1);
		go_d1_mn = mean([go_d1_min go_d1_max]);

		printf("Plug-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (d):  %g...%g\t(%g+-%g)\n",
			   go_d_min, go_d_max, go_d_mn, go_d_max - go_d_mn);
		printf("    major diameter wear limit: %g\n", g.go.d_wearlim);
		printf("    pitch diameter (d2): %g...%g\t(%g+-%g)\n",
			   go_d2_min, go_d2_max, go_d2_mn, go_d2_max - go_d2_mn);
		printf("    pitch diameter wear limit: %g\n", g.go.d2_wearlim);
		printf("    minor diameter (d1): %g...%g\t(%g+-%g)\n",
			   go_d1_min, go_d1_max, go_d1_mn, go_d1_max - go_d1_mn);

		ng_d_min = min(g.ng.d);
		ng_d_max = max(g.ng.d);
		ng_d_mn = mean([ng_d_min ng_d_max]);
		ng_d2_min = min(g.ng.d2);
		ng_d2_max = max(g.ng.d2);
		ng_d2_mn = mean([ng_d2_min ng_d2_max]);
		ng_d1_min = min(g.ng.d1);
		ng_d1_max = max(g.ng.d1);
		ng_d1_mn = mean([ng_d1_min ng_d1_max]);

		printf("Plug-NoGo for thread %gx%g\n", d, p);
		printf("    major diameter (d):  %g...%g\t(%g+-%g)\n",
			   ng_d_min, ng_d_max, ng_d_mn, ng_d_max - ng_d_mn);
		printf("    pitch diameter (d2): %g...%g\t(%g+-%g)\n",
			   ng_d2_min, ng_d2_max, ng_d2_mn, ng_d2_max - ng_d2_mn);
		printf("    pitch diameter wear limit: %g\n", g.ng.d2_wearlim);
		printf("    minor diameter (d1): %g...%g\t(%g+-%g)\n",
			   ng_d1_min, ng_d1_max, ng_d1_mn, ng_d1_max - ng_d1_mn);
	case "ring"
		go_D_min = min(g.go.D);
		go_D_max = max(g.go.D);
		go_D_mn = mean([go_D_min go_D_max]);
		go_D2_min = min(g.go.D2);
		go_D2_max = max(g.go.D2);
		go_D2_mn = mean([go_D2_min go_D2_max]);
		go_D1_min = min(g.go.D1);
		go_D1_max = max(g.go.D1);
		go_D1_mn = mean([go_D1_min go_D1_max]);

		printf("Ring-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (D):  %g...%g\t(%g+-%g)\n",
		       go_D_min, go_D_max, go_D_mn, go_D_max - go_D_mn);
		printf("    pitch diameter (D2): %g...%g\t(%g+-%g)\n",
		       go_D2_min, go_D2_max, go_D2_mn, go_D2_max - go_D2_mn);
		printf("    pitch diameter wear limit: %g\n", g.go.D2_wearlim);
		printf("    minor diameter (D1): %g...%g\t(%g+-%g)\n",
		       go_D1_min, go_D1_max, go_D1_mn, go_D1_max - go_D1_mn);
		printf("    minor diameter wear limit: %g\n", g.go.D1_wearlim);

		ng_D_min = min(g.ng.D);
		ng_D_max = max(g.ng.D);
		ng_D_mn = mean([ng_D_min ng_D_max]);
		ng_D2_min = min(g.ng.D2);
		ng_D2_max = max(g.ng.D2);
		ng_D2_mn = mean([ng_D2_min ng_D2_max]);
		ng_D1_min = min(g.ng.D1);
		ng_D1_max = max(g.ng.D1);
		ng_D1_mn = mean([ng_D1_min ng_D1_max]);

		printf("Ring-NoGo for thread %gx%g\n", d, p);
		printf("    major diameter (D):  %g...%g\t(%g+-%g)\n",
		       ng_D_min, ng_D_max, ng_D_mn, ng_D_max - ng_D_mn);
		printf("    pitch diameter (D2): %g...%g\t(%g+-%g)\n",
		       ng_D2_min, ng_D2_max, ng_D2_mn, ng_D2_max - ng_D2_mn);
		printf("    pitch diameter wear limit: %g\n", g.ng.D2_wearlim);
		printf("    minor diameter (D1): %g...%g\t(%g+-%g)\n",
		       ng_D1_min, ng_D1_max, ng_D1_mn, ng_D1_max - ng_D1_mn);
	case "cplug"

		go_d_min = min(g.go.d);
		go_d_max = max(g.go.d);
		go_d_mn = mean([go_d_min go_d_max]);
		go_d2_min = min(g.go.d2);
		go_d2_max = max(g.go.d2);
		go_d2_mn = mean([go_d2_min go_d2_max]);
		go_d1_min = min(g.go.d1);
		go_d1_max = max(g.go.d1);
		go_d1_mn = mean([go_d1_min go_d1_max]);

		printf("CPlug-Go for thread %gx%g:\n", d, p);
		printf("    major diameter (d):  %g...%g\t(%g+-%g)\n",
			   go_d_min, go_d_max, go_d_mn, go_d_max - go_d_mn);
		printf("    pitch diameter (d2): %g...%g\t(%g+-%g)\n",
			   go_d2_min, go_d2_max, go_d2_mn, go_d2_max - go_d2_mn);
		printf("    minor diameter (d1): %g...%g\t(%g+-%g)\n",
			   go_d1_min, go_d1_max, go_d1_mn, go_d1_max - go_d1_mn);

		ng_d_min = min(g.ng.d);
		ng_d_max = max(g.ng.d);
		ng_d_mn = mean([ng_d_min ng_d_max]);
		ng_d2_min = min(g.ng.d2);
		ng_d2_max = max(g.ng.d2);
		ng_d2_mn = mean([ng_d2_min ng_d2_max]);
		ng_d1_min = min(g.ng.d1);
		ng_d1_max = max(g.ng.d1);
		ng_d1_mn = mean([ng_d1_min ng_d1_max]);

		printf("CPlug-NoGo for thread %gx%g\n", d, p);
		printf("    major diameter (d):  %g...%g\t(%g+-%g)\n",
			   ng_d_min, ng_d_max, ng_d_mn, ng_d_max - ng_d_mn);
		printf("    pitch diameter (d2): %g...%g\t(%g+-%g)\n",
			   ng_d2_min, ng_d2_max, ng_d2_mn, ng_d2_max - ng_d2_mn);
		printf("    minor diameter (d1): %g...%g\t(%g+-%g)\n",
			   ng_d1_min, ng_d1_max, ng_d1_mn, ng_d1_max - ng_d1_mn);
	end
end

