private _test = {
	sleep (random 30)+1;
	hint "test random";
};

[10,0,_test] call fnc_addTimeEvent;