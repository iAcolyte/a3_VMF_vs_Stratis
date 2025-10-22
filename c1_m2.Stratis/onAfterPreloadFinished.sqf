sleep 5;


PC_SW_fnc_hint_1 = 
{
	[
		["PC_SW_ALL_HINTS", "PC_SW_01_hint_01"],	
		10,	//Short hint duration
		"",	//Short hint hide condition
		120,	//Full hint duration
		"",	//Full hint hide condition
		true,	//Show even if tutorials hint are disabled
		true,	//Show Full hint
		false,	//Display hint only once
		true	//Play sound
	] call BIS_fnc_advHint;
};	

[] spawn PC_SW_fnc_hint_1;