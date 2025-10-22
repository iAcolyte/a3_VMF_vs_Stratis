[
	player,
	"task_recon_igor",
	["'Игорь' - одна из зон, на которой был обнаружен лагерь противника.","Игорь"],
	getMarkerPos ["marker_8.1", true],
	"CREATED",
	1,
	true
] call BIS_fnc_taskCreate;
[
	player,
	["task_recon_igor_1","task_recon_igor"],
	["Прибыть на точку 'Игорь' и актуализировать информацию о противнике","Первичная разведка"],
	getMarkerPos ["marker_8.1", true],
	"CREATED",
	1,
	true
] call BIS_fnc_taskCreate;

private _campPos = profileNamespace getVariable ["iacolyte_vmf_c1_m1_camp_position", "a"];
[
	player,
	"iacolyte_vmf_c1_task_utility_scuba",
	["Мы торопились, когда прятали акваланги в зоне высадки. Необходимо забрать их в лагерь или перепрятать надёжнее.","Забрать акваланги"],
	if (_campPos == "a") then {getMarkerPos ["marker_2", true]} else {getMarkerPos ["marker_1", true]},
	"CREATED",
	1,
	true
] call BIS_fnc_taskCreate;
[] call iacolyte_vmf_c1_task_utility_scuba_trigger;

// 
// private _isScubaHidden = profileNamespace getVariable ["iacolyte_vmf_c1_m1_isScubaHidden", false];
// [
// 	player,
// 	"iacolyte_vmf_c1_task_utility_scuba",
// 	["Мы торопились, когда прятали акваланги в зоне высадки. Необходимо забрать их в лагерь или перепрятать надёжнее.","Забрать акваланги"],
// 	if (_campPos == "a") then {getMarkerPos ["marker_2", true]} else {getMarkerPos ["marker_1", true]},
// 	"CREATED",
// 	1,
// 	true
// ] call BIS_fnc_taskCreate;

// if (_isScubaHidden) then {
// 	["iacolyte_vmf_c1_task_utility_scuba","SUCCEEDED"] call BIS_fnc_taskSetState;
// 	[
// 		"iacolyte_vmf_c1_task_utility_scuba",
// 		[
// 			"Мы забрали акваланги и можем быть уверены, что их не найдут",
// 			"Забрать акваланги",
// 			""
// 		]
// 	] call BIS_fnc_taskSetDescription;
// };