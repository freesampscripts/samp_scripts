#include <a_samp>
#include <zcmd>

new speedo_timer;
new use_speedo[MAX_PLAYERS];
new Text:gspeedo[4];
new Text:speedo_dot[21];
new Text:speedo_number[12];
new PlayerText:speedo[MAX_PLAYERS] = {PlayerText:0xFFFF,...};
new PlayerText:speedo_needle[MAX_PLAYERS][28];

public OnFilterScriptInit()
{
	new count, xc, string[4], Float:r, Float:x, Float:y;
    gspeedo[0] = TextDrawCreate(559.432983, 370.921997, "ld_pool:ball");
	TextDrawTextSize(gspeedo[0], 66.000000, 66.0);
	TextDrawAlignment(gspeedo[0], 1);
	TextDrawColor(gspeedo[0], 255);
	TextDrawSetShadow(gspeedo[0], 0);
	TextDrawBackgroundColor(gspeedo[0], 255);
	TextDrawFont(gspeedo[0], 4);
	TextDrawSetProportional(gspeedo[0], 0);
	gspeedo[1] = TextDrawCreate(560.699401, 371.836853, "ld_pool:ball");
	TextDrawTextSize(gspeedo[1], 64.0, 64.0);
	TextDrawAlignment(gspeedo[1], 1);
	TextDrawColor(gspeedo[1], 538976511);
	TextDrawSetShadow(gspeedo[1], 0);
	TextDrawBackgroundColor(gspeedo[1], 255);
	TextDrawFont(gspeedo[1], 4);
	TextDrawSetProportional(gspeedo[1], 0);
	gspeedo[2] = TextDrawCreate(593.000305, 421.608215, "kmh");
	TextDrawLetterSize(gspeedo[2], 0.078998, 0.732590);
	TextDrawAlignment(gspeedo[2], 2);
	TextDrawColor(gspeedo[2], -1);
	TextDrawSetShadow(gspeedo[2], 0);
	TextDrawBackgroundColor(gspeedo[2], 255);
	TextDrawFont(gspeedo[2], 1);
	TextDrawSetProportional(gspeedo[2], 1);
	gspeedo[3] = TextDrawCreate(592.599548, 387.063323, ".");
	TextDrawLetterSize(gspeedo[3], 0.646000, 2.060442);
	TextDrawAlignment(gspeedo[3], 2);
	TextDrawColor(gspeedo[3], -16776961);
	TextDrawSetShadow(gspeedo[3], 0);
	TextDrawBackgroundColor(gspeedo[3], 255);
	TextDrawFont(gspeedo[3], 1);
	TextDrawSetProportional(gspeedo[3], 1);
	for(new Float:d = 0.0; d <= 220.0; d += 20.0)
	{
		r = floatadd((d * floatdiv(270.0, 220.0)), 45.0);
		TextDrawSine(r, 25.4, 592.3, 398.0, x, y);
		format(string, 4, "%.0f", d);
		speedo_number[count] = TextDrawCreate(x, y, string);
		TextDrawAlignment(speedo_number[count], 2);
		TextDrawLetterSize(speedo_number[count], 0.1020, 0.5534);
		TextDrawSetShadow(speedo_number[count], 0);
		count ++;
	}
	for(new Float:d = 10.0; d <= 210.0; d += 10.0)
	{
		r = floatadd((d * floatdiv(270.0, 220.0)), 45.0);
		TextDrawSine(r, 26.1, 592.3, 398.0, x, y);
		speedo_dot[xc] = TextDrawCreate(x, y, ".");
		TextDrawAlignment(speedo_dot[xc], 2);
		TextDrawLetterSize(speedo_dot[xc], 0.1020, 0.5534);
		TextDrawSetShadow(speedo_dot[xc], 0);
		xc ++;
	}
    for(new i = GetMaxPlayers(); i > -1; i --)
	{
		for(new k = 0; k < 28; k ++)
		{
	    	speedo_needle[i][k] = PlayerText:0xFFFF;
		}
		if(!IsPlayerConnected(i)) continue;
		speedo[i] = CreatePlayerTextDraw(i, 592.0, 415.0, "0");
		PlayerTextDrawLetterSize(i, speedo[i], 0.128332, 0.533926);
		PlayerTextDrawTextSize(i, speedo[i], 0.000000, 13.000000);
		PlayerTextDrawAlignment(i, speedo[i], 2);
		PlayerTextDrawColor(i, speedo[i], -1);
		PlayerTextDrawUseBox(i, speedo[i], 1);
		PlayerTextDrawBoxColor(i, speedo[i], 128);
		PlayerTextDrawSetShadow(i, speedo[i], 0);
		PlayerTextDrawBackgroundColor(i, speedo[i], 255);
		PlayerTextDrawFont(i, speedo[i], 1);
		PlayerTextDrawSetProportional(i, speedo[i], 1);
	}
	speedo_timer = SetTimer("_speedo", 100, 1);
	return 1;
}

TextDrawSine(Float:angle, Float:distance, Float:sx, Float:sy, & Float:x, & Float:y)
{
	x = sx + (distance * floatsin(-angle, degrees));
	y = sy + (distance * floatcos(angle, degrees));
	return 1;
}

SpeedoNeedleHide(playerid)
{
    for(new k = 0; k < 28; k ++)
	{
		PlayerTextDrawDestroy(playerid, speedo_needle[playerid][k]);
		speedo_needle[playerid][k] = PlayerText:0xFFFF;
	}
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(speedo_timer);
	for(new i = 0; i < 4; i ++)
	{
	    TextDrawDestroy(gspeedo[i]);
	}
	for(new i = 0; i < 12; i ++)
	{
	    TextDrawDestroy(speedo_number[i]);
	}
	for(new i = 0; i < 21; i ++)
	{
	    TextDrawDestroy(speedo_dot[i]);
	}
	for(new i = GetPlayerPoolSize(); i > -1; i --)
	{
		if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
		PlayerTextDrawDestroy(i, speedo[i]);
		SpeedoNeedleHide(i);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
	    speedo[playerid] = CreatePlayerTextDraw(playerid, 592.0, 415.0, "0");
		PlayerTextDrawLetterSize(playerid, speedo[playerid], 0.128332, 0.533926);
		PlayerTextDrawTextSize(playerid, speedo[playerid], 0.000000, 13.000000);
		PlayerTextDrawAlignment(playerid, speedo[playerid], 2);
		PlayerTextDrawColor(playerid, speedo[playerid], -1);
		PlayerTextDrawUseBox(playerid, speedo[playerid], 1);
		PlayerTextDrawBoxColor(playerid, speedo[playerid], 128);
		PlayerTextDrawSetShadow(playerid, speedo[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, speedo[playerid], 255);
		PlayerTextDrawFont(playerid, speedo[playerid], 1);
		PlayerTextDrawSetProportional(playerid, speedo[playerid], 1);
	}
	return 1;
}

ToggleSpeedo(playerid, toggle)
{
	if(!toggle)
	{
	    PlayerTextDrawHide(playerid, speedo[playerid]);
	    for(new i = 0; i < 12; i ++)
	    {
	        TextDrawHideForPlayer(playerid, speedo_number[i]);
	    }
	    for(new i = 0; i < 21; i ++)
	    {
	        TextDrawHideForPlayer(playerid, speedo_dot[i]);
	    }
	    for(new i = 0; i < 4; i ++)
	    {
			TextDrawHideForPlayer(playerid, gspeedo[i]);
	    }
	    return 1;
	}
	PlayerTextDrawShow(playerid, speedo[playerid]);
	for(new i = 0; i < 12; i ++)
 	{
  		TextDrawShowForPlayer(playerid, speedo_number[i]);
 	}
 	for(new i = 0; i < 21; i ++)
 	{
  		TextDrawShowForPlayer(playerid, speedo_dot[i]);
 	}
 	for(new i = 0; i < 4; i ++)
 	{
		TextDrawShowForPlayer(playerid, gspeedo[i]);
 	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(!IsPlayerNPC(playerid))
	{
	    use_speedo[playerid] = 0;
		PlayerTextDrawDestroy(playerid, speedo[playerid]);
		speedo[playerid] = PlayerText:0xFFFF;
	    SpeedoNeedleHide(playerid);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(use_speedo[playerid])
	{
	    if(newstate == 2 && oldstate != 2)
		{
	        ToggleSpeedo(playerid, 1);
		}
		if(newstate != 2 && oldstate == 2)
		{
		    ToggleSpeedo(playerid, 0);
		    SpeedoNeedleHide(playerid);
		}
	}
	return 1;
}

CMD:speedo(playerid, params[])
{
	if(!use_speedo[playerid])
	{
	    SendClientMessage(playerid, -1, "Speedometer: {00FA00}ON");
	    use_speedo[playerid] = 1;
	    if(GetPlayerState(playerid) != 2) return 1;
	    ToggleSpeedo(playerid, 1);
	    return 1;
	}
	SendClientMessage(playerid, -1, "Speedometer: {FA0000}OFF");
	use_speedo[playerid] = 0;
	ToggleSpeedo(playerid, 0);
	SpeedoNeedleHide(playerid);
	return 1;
}

forward _speedo();

public _speedo()
{
	new count, Float:speed, string[4], Float:r, Float:x, Float:y, Float:vx, Float:vy, Float:vz;
	for(new i = GetPlayerPoolSize(); i > -1; i --)
	{
	    if(GetPlayerState(i) != 2 || !use_speedo[i]) continue;
	    GetVehicleVelocity(GetPlayerVehicleID(i), vx, vy, vz);
	    speed = floatmul(floatsqroot(floatadd(floatmul(vx, vx), floatmul(vy, vy))), 180.0);
	    format(string, 4, "%.0f", speed);
		PlayerTextDrawSetString(i, speedo[i], string);
		r = floatadd((speed * floatdiv(270.0, 220.0)), 45.0);
		r = r > 315.0 ? 315.0 : r;
		for(new k = 0; k < 28; k ++)
		{
		    PlayerTextDrawDestroy(i, speedo_needle[i][k]);
		}
		for(new Float:d = -3.0; d < 28.0; d += 1.0)
		{
			TextDrawSine(r, d, 592.5, 398.0, x, y);
			speedo_needle[i][count] = CreatePlayerTextDraw(i, x, y, ".");
			PlayerTextDrawColor(i, speedo_needle[i][count], 0xFF0000FF);
			PlayerTextDrawAlignment(i, speedo_needle[i][count], 2);
			PlayerTextDrawLetterSize(i, speedo_needle[i][count], 0.1020, 0.5534);
			PlayerTextDrawSetShadow(i, speedo_needle[i][count], 0);
			PlayerTextDrawShow(i, speedo_needle[i][count]);
			count ++;
		}
		count = 0;
	}
	return 1;
}
