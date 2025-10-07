private _gromov_equipement = { 
	
comment "Exported from Arsenal by Alexander";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local this) exitWith {};

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add weapons";
this addWeapon "rhs_weap_asval_grip";
this addPrimaryWeaponItem "rhs_acc_perst1ik_ris";
this addPrimaryWeaponItem "rhs_acc_ekp1";
this addPrimaryWeaponItem "rhs_20rnd_9x39mm_SP6";
this addPrimaryWeaponItem "rhs_acc_grip_rk6";
this addWeapon "rhs_weap_pb_6p9";
this addHandgunItem "rhs_acc_6p9_suppressor";
this addHandgunItem "rhs_mag_9x18_8_57N181S";

comment "Add containers";
this forceAddUniform "rhs_uniform_6sh122_gloves_v2";
this addVest "rhs_6sh117_val";

comment "Add items to containers";
this addItemToUniform "FirstAidKit";
this addItemToUniform "rhs_1PN138";
this addItemToUniform "rhs_beret_mp1";
for "_i" from 1 to 2 do {this addItemToUniform "rhs_mag_9x18_8_57N181S";};
for "_i" from 1 to 11 do {this addItemToVest "rhs_20rnd_9x39mm_SP6";};
this addItemToVest "SmokeShellRed";
this addItemToVest "DemoCharge_Remote_Mag";
this addHeadgear "rhs_Booniehat_digi";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";

comment "Set identity";
[this,"AsianHead_A3_01","male01rus"] call BIS_fnc_setIdentity;

};

private _roman_karpov = {
	comment "Exported from Arsenal by Alexander";

	comment "[!] UNIT MUST BE LOCAL [!]";
	if (!local this) exitWith {};

	comment "Remove existing items";
	removeAllWeapons this;
	removeAllItems this;
	removeAllAssignedItems this;
	removeUniform this;
	removeVest this;
	removeBackpack this;
	removeHeadgear this;
	removeGoggles this;

	comment "Add weapons";
	this addWeapon "rhs_weap_asval_grip";
	this addPrimaryWeaponItem "rhs_acc_perst1ik_ris";
	this addPrimaryWeaponItem "rhs_acc_ekp1";
	this addPrimaryWeaponItem "rhs_20rnd_9x39mm_SP5";
	this addPrimaryWeaponItem "rhs_acc_grip_rk6";
	this addWeapon "rhs_weap_pb_6p9";
	this addHandgunItem "rhs_acc_6p9_suppressor";
	this addHandgunItem "rhs_mag_9x18_8_57N181S";

	comment "Add containers";
	this forceAddUniform "rhs_uniform_6sh122_gloves_v2";
	this addVest "rhs_6sh117_val";
	this addBackpack "rhs_medic_bag";

	comment "Add items to containers";
	this addItemToUniform "rhs_1PN138";
	for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
	this addItemToUniform "SmokeShell";
	this addItemToUniform "SmokeShellOrange";
	this addItemToUniform "rhs_beret_mp1";
	for "_i" from 1 to 3 do {this addItemToVest "rhs_mag_rgn";};
	for "_i" from 1 to 3 do {this addItemToVest "rhs_mag_9x18_8_57N181S";};
	for "_i" from 1 to 10 do {this addItemToVest "rhs_20rnd_9x39mm_SP6";};
	this addItemToBackpack "Medikit";
	for "_i" from 1 to 2 do {this addItemToBackpack "FirstAidKit";};
	this addHeadgear "H_Bandanna_khk";

	comment "Add items";
	this linkItem "ItemMap";
	this linkItem "ItemCompass";
	this linkItem "ItemWatch";
	this linkItem "ItemRadio";

	comment "Set identity";
	[this,"RHS_CamoHead_Greek_08_F","male02rus"] call BIS_fnc_setIdentity;
}

private _sniper = {


comment "Exported from Arsenal by Alexander";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local this) exitWith {};

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add weapons";
this addWeapon "rhs_weap_vss_grip";
this addPrimaryWeaponItem "rhs_acc_perst1ik_ris";
this addPrimaryWeaponItem "rhs_acc_pso1m2";
this addPrimaryWeaponItem "rhs_20rnd_9x39mm_SP6";
this addWeapon "rhs_weap_pb_6p9";
this addHandgunItem "rhs_acc_6p9_suppressor";
this addHandgunItem "rhs_mag_9x18_8_57N181S";

comment "Add containers";
this forceAddUniform "rhs_uniform_6sh122_gloves_v2";
this addVest "rhs_6sh117_val";

comment "Add items to containers";
this addItemToUniform "FirstAidKit";
this addItemToUniform "rhs_1PN138";
this addItemToUniform "rhs_beret_mp1";
for "_i" from 1 to 2 do {this addItemToUniform "rhs_mag_9x18_8_57N181S";};
for "_i" from 1 to 10 do {this addItemToVest "rhs_20rnd_9x39mm_SP6";};
this addItemToVest "rhs_mag_rgn";
this addItemToVest "rhs_acc_1pn93_1";
this addHeadgear "rhs_vkpo_cap";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";

comment "Set identity";
[this,"AsianHead_A3_07","male01rus"] call BIS_fnc_setIdentity;


}

_saper = {


comment "Exported from Arsenal by Alexander";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local this) exitWith {};

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add weapons";
this addWeapon "rhs_weap_asval_grip";
this addPrimaryWeaponItem "rhs_acc_perst1ik_ris";
this addPrimaryWeaponItem "rhs_acc_ekp1";
this addPrimaryWeaponItem "rhs_20rnd_9x39mm_SP5";
this addPrimaryWeaponItem "rhs_acc_grip_rk6";
this addWeapon "rhs_weap_pb_6p9";
this addHandgunItem "rhs_acc_6p9_suppressor";
this addHandgunItem "rhs_mag_9x18_8_57N181S";

comment "Add containers";
this forceAddUniform "rhs_uniform_6sh122_gloves_v2";
this addVest "rhs_6sh117_val";
this addBackpack "rhs_medic_bag";

comment "Add items to containers";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
this addItemToUniform "rhs_beret_mp1";
this addItemToUniform "SmokeShell";
this addItemToUniform "SmokeShellOrange";
for "_i" from 1 to 3 do {this addItemToVest "rhs_mag_rgn";};
for "_i" from 1 to 3 do {this addItemToVest "rhs_mag_9x18_8_57N181S";};
for "_i" from 1 to 10 do {this addItemToVest "rhs_20rnd_9x39mm_SP6";};
this addItemToBackpack "Medikit";
for "_i" from 1 to 2 do {this addItemToBackpack "FirstAidKit";};
this addHeadgear "H_Bandanna_khk";

comment "Add items";
this addItemToUniform "rhs_1PN138";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";

comment "Set identity";
[this,"RussianHead_2","male02rus"] call BIS_fnc_setIdentity;

}