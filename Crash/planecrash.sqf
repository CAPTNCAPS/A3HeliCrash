/*
*	Author: CAPTNCAPS
* 	Version: 1.5
*	Special Thanks to: 
*	-TeamProSkill for being my clan!
*	-Cruoriss for fixing the never ending effects!
*	-sxp2high for helping me with the check script!
*	
*	Please notify me if you make any changes so that I can make them official!
*
*/

_plane = _this select 0; 		// 0=[this]execVM "planecrash.sqf";

	
TPS_fnc_CheckDist ={
	private ["_veh"];
	_veh = _this select 0;
	_pos = getPos _veh;
	_fireEffect=_veh getVariable "fireEffect";
	_height = _pos select 2;
	if (_height <= 25) then {
		if (surfaceIsWater _pos) then {
			detach _fireEffect;
			_fireEffect setPos [0,0,0];
			_veh allowDamage true;
		} 
		else {
			sleep 8;
			_veh setDamage 1;
			sleep 150;
			detach _fireEffect;
			_fireEffect setPos [0,0,0];
		};
	} 	
	else {
		[_veh] call TPS_fnc_CheckDist;
	};
};

	if((damage _plane) > 0.2 || !canMove _plane) then {									//0.2 is easily achieved with 1 Titan Shot. 0.5 is not 
		_plane setDamage 0.7;			
		_plane allowDamage false;		
		_fireEffect = "test_EmptyObjectForFireBig" createVehicle position _plane;
		_fireEffect attachTo [_plane,[0,-3,0]];  
		_plane setVariable ["fireEffect",_fireEffect,true];
		_fireEffect setVariable ["effects", _fireEffect getVariable "effects", true];
		sleep 10;
		_heli setDamage 0.9;
		_plane setFuel 0;
		[_plane] call TPS_fnc_CheckDist;	
	};

	