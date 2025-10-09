[1, "BLACK", 5, 0] spawn BIS_fnc_fadeEffect;

if (gromov saveStatus "gromovStatus") then {
	[gromov] call fnc_setDiver;
	karpov saveStatus "karpovStatus";
	[karpov] call fnc_setDiver;
	morozov saveStatus "morozovStatus";
	[morozov] call fnc_setDiver;
	ustinov saveStatus "ustinovStatus";
	[ustinov] call fnc_setDiver;
	mironov saveStatus "mironovStatus";
	[mironov] call fnc_setDiver;
	shevchenko saveStatus "shevchenkoStatus";
	[shevchenko] call fnc_setDiver;
};
msn_team1 = [
	morozov,
	ustinov,
	mironov,
	shevchenko
];
msn_team_player = [
	gromov,
	karpov
];
msn_team1 join grpNull;
[karpov] join grpNull;

group morozov setSpeedMode "LIMITED";
morozov doMove getWPPos[player,1];
removeMissionEventHandler ["PreloadFinished",msn_preloadFinishedHandle];
msn_preloadFinishedHandle = nil;
["Акватория острова Стратис",[] call fnc_getDate, [] call fnc_getTimeStr, 5] spawn fnc_showText;

sleep 5;
["Part1", "VMF_C1_M1","","DIRECT",{ true },[],1,true] call BIS_fnc_kbTell;

spn_boat1 lock false;