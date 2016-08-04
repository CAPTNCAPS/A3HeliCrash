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

_heli = _this select 0;
	
		
TPS_fnc_CheckDist ={
	private ["_veh"];
	_veh = _this select 0;
	_smoke=_veh getVariable "smoke";
	_fireEffect=_veh getVariable "fireEffect";
	_pos = getPos _veh;
	_height = _pos select 2;
	if (_height <= 25) then {
		if (surfaceIsWater _pos) then {
			sleep 5;
			detach _smoke;
			_smoke setPos [0,0,0]; 
			detach _fireEffect;
			_fireEffect setPos [0,0,0]; 
			_veh allowDamage true;
		} 
		else {
			sleep 8;
			_veh allowDamage true;
			sleep 150;
			detach _smoke;
			_smoke setPos [0,0,0]; 
			detach _fireEffect;
			_fireEffect setPos [0,0,0]; 
		};
	} 
	else {
		[_veh] call TPS_fnc_CheckDist;
	};
};
	
	if((damage _heli) > 0.2 || !canMove _heli) then {				//0.2 is easily achieved with 1 Titan Shot. 0.5 is not 
		_heli setDamage 0.7;			
		_heli allowDamage false;
		_heli setHitPointDamage ["HitVRotor", 1]; 	
		_smoke = "test_EmptyObjectForSmoke" createVehicle position _heli;
		_smoke attachTo [_heli,[0,-5,0]]; 
		_heli setVariable ["smoke",_smoke,true];	
		sleep 5;
		_heli setDamage 0.9;
		_heli setFuel 0;
		_fireEffect = "test_EmptyObjectForFireBig" createVehicle position _heli;
		_fireEffect attachTo [_heli,[0.2,0.5,0.5]];
		_heli setVariable ["fireEffect",_fireEffect,true];
		[_heli] call TPS_fnc_CheckDist;									
	};
