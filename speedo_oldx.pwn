#include <a_samp>
#include <foreach>
#include <YSI\y_timers>

new Text:SpeedoTD[16];
new PlayerText:pSpeedoTD[MAX_PLAYERS] = {PlayerText:0xFFFF,...};
new PlayerText:pSpeedoTD2[MAX_PLAYERS] = {PlayerText:0xFFFF,...};

bool:TogglePlayerSpeedo(playerid, bool:toggle)
{
	if(!toggle)
	{
        for(new i = 0; i < 16; i++)
		{
	    	TextDrawHideForPlayer(playerid, SpeedoTD[i]);
		}
		PlayerTextDrawHide(playerid, pSpeedoTD[playerid]);
	 	PlayerTextDrawHide(playerid, pSpeedoTD2[playerid]);
	    return false;
	}
	for(new i = 0; i < 16; i++)
	{
	    TextDrawShowForPlayer(playerid, SpeedoTD[i]);
	}
	PlayerTextDrawShow(playerid, pSpeedoTD[playerid]);
 	PlayerTextDrawShow(playerid, pSpeedoTD2[playerid]);
	return false;
}

Float:GetPlayerVehicleSpeed(playerid)
{
	new vehicle, Float:x, Float:y, Float:z;
	vehicle = GetPlayerVehicleID(playerid);
 	GetVehicleVelocity(vehicle, x, y, z);
 	return floatsqroot(floatpower(x, 2) + floatpower(y, 2))*111.847092597;
}

Float:calculateNeedlePos(playerid)
{
	new Float:result, Float:speed;
	speed = GetPlayerVehicleSpeed(playerid);
	result = (speed*(140/140))+469.4525;
	if(result > 609.4525)
	{
	    result = 609.4525;
	}
	return result;
}

public OnFilterScriptInit()
{
 	SpeedoTD[0] = TextDrawCreate(470.000000, 350.000000, ".");
	TextDrawLetterSize(SpeedoTD[0], 0.228570, 1.267199);
	TextDrawAlignment(SpeedoTD[0], 1);
	TextDrawColor(SpeedoTD[0], -1);
	TextDrawSetShadow(SpeedoTD[0], 0);
	TextDrawSetOutline(SpeedoTD[0], 1);
	TextDrawBackgroundColor(SpeedoTD[0], 255);
	TextDrawFont(SpeedoTD[0], 1);
	TextDrawSetProportional(SpeedoTD[0], 1);
	SpeedoTD[1] = TextDrawCreate(490.000000, 350.000000, ".");
	TextDrawLetterSize(SpeedoTD[1], 0.228570, 1.267199);
	TextDrawAlignment(SpeedoTD[1], 1);
	TextDrawColor(SpeedoTD[1], -1);
	TextDrawSetShadow(SpeedoTD[1], 0);
	TextDrawSetOutline(SpeedoTD[1], 1);
	TextDrawBackgroundColor(SpeedoTD[1], 255);
	TextDrawFont(SpeedoTD[1], 1);
	TextDrawSetProportional(SpeedoTD[1], 1);
	SpeedoTD[2] = TextDrawCreate(510.000000, 350.000000, ".");
	TextDrawLetterSize(SpeedoTD[2], 0.228570, 1.267199);
	TextDrawAlignment(SpeedoTD[2], 1);
	TextDrawColor(SpeedoTD[2], -1);
	TextDrawSetShadow(SpeedoTD[2], 0);
	TextDrawSetOutline(SpeedoTD[2], 1);
	TextDrawBackgroundColor(SpeedoTD[2], 255);
	TextDrawFont(SpeedoTD[2], 1);
	TextDrawSetProportional(SpeedoTD[2], 1);
	SpeedoTD[3] = TextDrawCreate(530.000000, 350.000000, ".");
	TextDrawLetterSize(SpeedoTD[3], 0.228570, 1.267199);
	TextDrawAlignment(SpeedoTD[3], 1);
	TextDrawColor(SpeedoTD[3], -1);
	TextDrawSetShadow(SpeedoTD[3], 0);
	TextDrawSetOutline(SpeedoTD[3], 1);
	TextDrawBackgroundColor(SpeedoTD[3], 255);
	TextDrawFont(SpeedoTD[3], 1);
	TextDrawSetProportional(SpeedoTD[3], 1);
	SpeedoTD[4] = TextDrawCreate(550.000000, 350.000000, ".");
	TextDrawLetterSize(SpeedoTD[4], 0.228570, 1.267199);
	TextDrawAlignment(SpeedoTD[4], 1);
	TextDrawColor(SpeedoTD[4], -1);
	TextDrawSetShadow(SpeedoTD[4], 0);
	TextDrawSetOutline(SpeedoTD[4], 1);
	TextDrawBackgroundColor(SpeedoTD[4], 255);
	TextDrawFont(SpeedoTD[4], 1);
	TextDrawSetProportional(SpeedoTD[4], 1);
	SpeedoTD[5] = TextDrawCreate(570.000000, 350.000000, ".");
	TextDrawLetterSize(SpeedoTD[5], 0.228570, 1.267199);
	TextDrawAlignment(SpeedoTD[5], 1);
	TextDrawColor(SpeedoTD[5], -1);
	TextDrawSetShadow(SpeedoTD[5], 0);
	TextDrawSetOutline(SpeedoTD[5], 1);
	TextDrawBackgroundColor(SpeedoTD[5], 255);
	TextDrawFont(SpeedoTD[5], 1);
	TextDrawSetProportional(SpeedoTD[5], 1);
	SpeedoTD[6] = TextDrawCreate(590.000000, 350.000000, ".");
	TextDrawLetterSize(SpeedoTD[6], 0.228570, 1.267199);
	TextDrawAlignment(SpeedoTD[6], 1);
	TextDrawColor(SpeedoTD[6], -1);
	TextDrawSetShadow(SpeedoTD[6], 0);
	TextDrawSetOutline(SpeedoTD[6], 1);
	TextDrawBackgroundColor(SpeedoTD[6], 255);
	TextDrawFont(SpeedoTD[6], 1);
	TextDrawSetProportional(SpeedoTD[6], 1);
	SpeedoTD[7] = TextDrawCreate(610.000000, 350.000000, ".");
	TextDrawLetterSize(SpeedoTD[7], 0.228570, 1.267199);
	TextDrawAlignment(SpeedoTD[7], 1);
	TextDrawColor(SpeedoTD[7], -1);
	TextDrawSetShadow(SpeedoTD[7], 0);
	TextDrawSetOutline(SpeedoTD[7], 1);
	TextDrawBackgroundColor(SpeedoTD[7], 255);
	TextDrawFont(SpeedoTD[7], 1);
	TextDrawSetProportional(SpeedoTD[7], 1);
	SpeedoTD[8] = TextDrawCreate(469.966705, 361.893341, "0");
	TextDrawLetterSize(SpeedoTD[8], 0.177522, 0.883199);
	TextDrawAlignment(SpeedoTD[8], 1);
	TextDrawColor(SpeedoTD[8], -1);
	TextDrawSetShadow(SpeedoTD[8], 0);
	TextDrawSetOutline(SpeedoTD[8], 1);
	TextDrawBackgroundColor(SpeedoTD[8], 255);
	TextDrawFont(SpeedoTD[8], 3);
	TextDrawSetProportional(SpeedoTD[8], 1);
	SpeedoTD[9] = TextDrawCreate(488.367828, 361.893341, "20");
	TextDrawLetterSize(SpeedoTD[9], 0.177522, 0.883199);
	TextDrawAlignment(SpeedoTD[9], 1);
	TextDrawColor(SpeedoTD[9], -1);
	TextDrawSetShadow(SpeedoTD[9], 0);
	TextDrawSetOutline(SpeedoTD[9], 1);
	TextDrawBackgroundColor(SpeedoTD[9], 255);
	TextDrawFont(SpeedoTD[9], 3);
	TextDrawSetProportional(SpeedoTD[9], 1);
	SpeedoTD[10] = TextDrawCreate(508.169036, 361.893341, "40");
	TextDrawLetterSize(SpeedoTD[10], 0.177522, 0.883199);
	TextDrawAlignment(SpeedoTD[10], 1);
	TextDrawColor(SpeedoTD[10], -1);
	TextDrawSetShadow(SpeedoTD[10], 0);
	TextDrawSetOutline(SpeedoTD[10], 1);
	TextDrawBackgroundColor(SpeedoTD[10], 255);
	TextDrawFont(SpeedoTD[10], 3);
	TextDrawSetProportional(SpeedoTD[10], 1);
	SpeedoTD[11] = TextDrawCreate(528.370239, 361.893341, "60");
	TextDrawLetterSize(SpeedoTD[11], 0.177522, 0.883199);
	TextDrawAlignment(SpeedoTD[11], 1);
	TextDrawColor(SpeedoTD[11], -1);
	TextDrawSetShadow(SpeedoTD[11], 0);
	TextDrawSetOutline(SpeedoTD[11], 1);
	TextDrawBackgroundColor(SpeedoTD[11], 255);
	TextDrawFont(SpeedoTD[11], 3);
	TextDrawSetProportional(SpeedoTD[11], 1);
	SpeedoTD[12] = TextDrawCreate(548.171447, 361.893341, "80");
	TextDrawLetterSize(SpeedoTD[12], 0.177522, 0.883199);
	TextDrawAlignment(SpeedoTD[12], 1);
	TextDrawColor(SpeedoTD[12], -1);
	TextDrawSetShadow(SpeedoTD[12], 0);
	TextDrawSetOutline(SpeedoTD[12], 1);
	TextDrawBackgroundColor(SpeedoTD[12], 255);
	TextDrawFont(SpeedoTD[12], 3);
	TextDrawSetProportional(SpeedoTD[12], 1);
	SpeedoTD[13] = TextDrawCreate(566.772583, 361.893341, "100");
	TextDrawLetterSize(SpeedoTD[13], 0.177522, 0.883199);
	TextDrawAlignment(SpeedoTD[13], 1);
	TextDrawColor(SpeedoTD[13], -1);
	TextDrawSetShadow(SpeedoTD[13], 0);
	TextDrawSetOutline(SpeedoTD[13], 1);
	TextDrawBackgroundColor(SpeedoTD[13], 255);
	TextDrawFont(SpeedoTD[13], 3);
	TextDrawSetProportional(SpeedoTD[13], 1);
	SpeedoTD[14] = TextDrawCreate(586.573791, 361.893341, "120");
	TextDrawLetterSize(SpeedoTD[14], 0.177522, 0.883199);
	TextDrawAlignment(SpeedoTD[14], 1);
	TextDrawColor(SpeedoTD[14], -1);
	TextDrawSetShadow(SpeedoTD[14], 0);
	TextDrawSetOutline(SpeedoTD[14], 1);
	TextDrawBackgroundColor(SpeedoTD[14], 255);
	TextDrawFont(SpeedoTD[14], 3);
	TextDrawSetProportional(SpeedoTD[14], 1);
	SpeedoTD[15] = TextDrawCreate(606.575012, 361.893341, "140");
	TextDrawLetterSize(SpeedoTD[15], 0.177522, 0.883199);
	TextDrawAlignment(SpeedoTD[15], 1);
	TextDrawColor(SpeedoTD[15], -1);
	TextDrawSetShadow(SpeedoTD[15], 0);
	TextDrawSetOutline(SpeedoTD[15], 1);
	TextDrawBackgroundColor(SpeedoTD[15], 255);
	TextDrawFont(SpeedoTD[15], 3);
	TextDrawSetProportional(SpeedoTD[15], 1);
	foreach(new i : Player)
	{
	    pSpeedoTD[i] = CreatePlayerTextDraw(i, 469.452514, 355.899993, "hud:radar_centre");
		PlayerTextDrawTextSize(i, pSpeedoTD[i], 3.000000, -8.000000);
		PlayerTextDrawAlignment(i, pSpeedoTD[i], 1);
		PlayerTextDrawColor(i, pSpeedoTD[i], -5963521);
		PlayerTextDrawSetShadow(i, pSpeedoTD[i], 0);
		PlayerTextDrawBackgroundColor(i, pSpeedoTD[i], 255);
		PlayerTextDrawFont(i, pSpeedoTD[i], 4);
		PlayerTextDrawSetProportional(i, pSpeedoTD[i], 0);
		pSpeedoTD2[i] = CreatePlayerTextDraw(i, 470.190490, 372.186645, "MP/H:_0");
		PlayerTextDrawLetterSize(i, pSpeedoTD2[i], 0.154666, 1.821867);
		PlayerTextDrawAlignment(i, pSpeedoTD2[i], 1);
		PlayerTextDrawColor(i, pSpeedoTD2[i], -1378294017);
		PlayerTextDrawSetShadow(i, pSpeedoTD2[i], 0);
		PlayerTextDrawSetOutline(i, pSpeedoTD2[i], 1);
		PlayerTextDrawBackgroundColor(i, pSpeedoTD2[i], 255);
		PlayerTextDrawFont(i, pSpeedoTD2[i], 1);
		PlayerTextDrawSetProportional(i, pSpeedoTD2[i], 1);
	    if(GetPlayerState(i) == 2)
	    {
	    	TogglePlayerSpeedo(i, true);
		}
	}
	return 1;
}

public OnFilterScriptExit()
{
	for(new x = 0; x < 16; x++)
	{
	    TextDrawDestroy(SpeedoTD[x]);
	}
	foreach(new i : Player)
	{
	    PlayerTextDrawDestroy(i, pSpeedoTD[i]);
	    PlayerTextDrawDestroy(i, pSpeedoTD2[i]);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
	    pSpeedoTD[playerid] = CreatePlayerTextDraw(playerid, 469.452514, 355.899993, "hud:radar_centre");
		PlayerTextDrawTextSize(playerid, pSpeedoTD[playerid], 3.000000, -8.000000);
		PlayerTextDrawAlignment(playerid, pSpeedoTD[playerid], 1);
		PlayerTextDrawColor(playerid, pSpeedoTD[playerid], -5963521);
		PlayerTextDrawSetShadow(playerid, pSpeedoTD[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, pSpeedoTD[playerid], 255);
		PlayerTextDrawFont(playerid, pSpeedoTD[playerid], 4);
		PlayerTextDrawSetProportional(playerid, pSpeedoTD[playerid], 0);
		pSpeedoTD2[playerid] = CreatePlayerTextDraw(playerid, 470.190490, 372.186645, "MP/H:_0");
		PlayerTextDrawLetterSize(playerid, pSpeedoTD2[playerid], 0.154666, 1.821867);
		PlayerTextDrawAlignment(playerid, pSpeedoTD2[playerid], 1);
		PlayerTextDrawColor(playerid, pSpeedoTD2[playerid], -1378294017);
		PlayerTextDrawSetShadow(playerid, pSpeedoTD2[playerid], 0);
		PlayerTextDrawSetOutline(playerid, pSpeedoTD2[playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, pSpeedoTD2[playerid], 255);
		PlayerTextDrawFont(playerid, pSpeedoTD2[playerid], 1);
		PlayerTextDrawSetProportional(playerid, pSpeedoTD2[playerid], 1);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	PlayerTextDrawDestroy(playerid, pSpeedoTD[playerid]);
	PlayerTextDrawDestroy(playerid, pSpeedoTD2[playerid]);
	pSpeedoTD[playerid] = PlayerText:0xFFFF;
	pSpeedoTD[playerid] = PlayerText:0xFFFF;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == 2 && oldstate != 2)
	{
	    TogglePlayerSpeedo(playerid, true);
	}
	if(newstate != 2 && oldstate == 2)
	{
	    TogglePlayerSpeedo(playerid, false);
	}
	return 1;
}

task SpeedoUpdate[100]()
{
	foreach(new i : Player)
	{
	    new string[11];
		if(GetPlayerState(i) != 2) continue;
		format(string, 11, "MP/H:_%d", floatround(GetPlayerVehicleSpeed(i), floatround_round));
		PlayerTextDrawSetString(i, pSpeedoTD2[i], string);
		PlayerTextDrawDestroy(i, pSpeedoTD[i]);
		pSpeedoTD[i] = CreatePlayerTextDraw(i, calculateNeedlePos(i), 355.899993, "hud:radar_centre");
		PlayerTextDrawTextSize(i, pSpeedoTD[i], 3.000000, -8.000000);
		PlayerTextDrawAlignment(i, pSpeedoTD[i], 1);
		PlayerTextDrawColor(i, pSpeedoTD[i], -5963521);
		PlayerTextDrawSetShadow(i, pSpeedoTD[i], 0);
		PlayerTextDrawBackgroundColor(i, pSpeedoTD[i], 255);
		PlayerTextDrawFont(i, pSpeedoTD[i], 4);
		PlayerTextDrawSetProportional(i, pSpeedoTD[i], 0);
		PlayerTextDrawShow(i, pSpeedoTD[i]);
	}
}
