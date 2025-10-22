iacolyte_vmf_c1_task_utility_scuba_trigger = {
	private _campPos = profileNamespace getVariable ["iacolyte_vmf_c1_m1_camp_position", "a"];
	_trg = createTrigger ["EmptyDetector", getPos player];
	_trg setTriggerArea [20, 20, 0, false];
	_trg setTriggerActivation ["EAST", "PRESENT", true];
	_trg setTriggerStatements ["this", "[thisList] spawn iacolyte_vmf_c1_task_utility_scuba_trigger_activated",""];
	private _pos =  if (_campPos == "a") then {getMarkerPos ["marker_2", true]} else {getMarkerPos ["marker_1", true]};
	_trg setPos _pos;
};

iacolyte_vmf_c1_task_utility_scuba_trigger_activated = {
	params ["_units"];

	if (player in _units) then {
		hint "123";
	} else {
		hint "321";
	};
	["iacolyte_vmf_c1_task_utility_scuba","SUCCEEDED"] call BIS_fnc_taskSetState;

	/*TODO:
	1. Показать диалог, мол, мы пришли на место, занимаемся аквалангами.
	2. Дать всем, у кого нет рюкзака, рюкзак.
	*/ 
};