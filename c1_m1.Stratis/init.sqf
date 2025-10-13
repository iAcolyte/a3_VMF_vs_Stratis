player setIdentity "Gromov";


addon_pc_exists = isClass (configFile >> "CfgPatches" >> "Addon_PC");

pickWeaponPool msn_pool_startAmmo;
execVM "Scripts\functions.sqf";

msn_preload_finished = false;
msn_preloadFinishedHandle = addMissionEventHandler ["PreloadFinished", {
	msn_preload_finished = true;
	removeMissionEventHandler["PreloadFinished", msn_preloadFinishedHandle];
}];

waitUntil {msn_preload_finished};

execVM "Scripts\onAfterPreloadFinished.sqf";

