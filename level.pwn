#include <a_samp>
#include <foreach>
#include <progress2>
#include <YSI\y_timers>
#include <zcmd>

//can change these----------------------//
#define BAR_KEY KEY_YES //Y key
#define BAR_COLOR 0x4DA9EBFF //Blue color
#define DELAY 3 //3 seconds
//-------------------------------------//

new Text:ball;
new Text:ball2;
new PlayerText:level[MAX_PLAYERS] = {PlayerText:0xFFFF,...};
new PlayerText:level2[MAX_PLAYERS] = {PlayerText:0xFFFF,...};
new PlayerBar:lvl_bar[MAX_PLAYERS] = {PlayerBar:0xFFFF,...};
new ptime[MAX_PLAYERS] = {0,...};

new levels[] =
{
	0, 150, 480, 880, 1400, 2200, 4000, 8800, 14500, 28488, 50000 //change to your levels
};

public OnFilterScriptInit()
{
    ball = TextDrawCreate(216.619140, 5.666669, "ld_pool:ball");
	TextDrawLetterSize(ball, 0.000000, 0.000000);
	TextDrawTextSize(ball, 31.000000, 32.000000);
	TextDrawAlignment(ball, 1);
	TextDrawColor(ball, 255);
	TextDrawSetShadow(ball, 0);
	TextDrawSetOutline(ball, 0);
	TextDrawBackgroundColor(ball, 255);
	TextDrawFont(ball, 4);
	TextDrawSetProportional(ball, 0);
	TextDrawSetShadow(ball, 0);
	ball2 = TextDrawCreate(388.018890, 5.666669, "ld_pool:ball");
	TextDrawLetterSize(ball2, 0.000000, 0.000000);
	TextDrawTextSize(ball2, 31.000000, 32.000000);
	TextDrawAlignment(ball2, 1);
	TextDrawColor(ball2, 255);
	TextDrawSetShadow(ball2, 0);
	TextDrawSetOutline(ball2, 0);
	TextDrawBackgroundColor(ball2, 255);
	TextDrawFont(ball2, 4);
	TextDrawSetProportional(ball2, 0);
	TextDrawSetShadow(ball2, 0);
	foreach(new i : Player)
	{
	    CreatePlayerLevel(i);
	}
	return 1;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(ball);
	TextDrawDestroy(ball2);
	foreach(new i : Player)
	{
	    DestroyPlayerLevel(i);
	}
	return 1;
}

CreatePlayerLevel(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	lvl_bar[playerid] = CreatePlayerProgressBar(playerid, 253.171524, 17.580007, 132.0, 7.8, BAR_COLOR, 100.0, BAR_DIRECTION_RIGHT, 0x000000FF);
    level[playerid] = CreatePlayerTextDraw(playerid, 232.023895, 12.033300, "");
	PlayerTextDrawLetterSize(playerid, level[playerid], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, level[playerid], 2);
	PlayerTextDrawColor(playerid, level[playerid], -1);
	PlayerTextDrawSetShadow(playerid, level[playerid], 0);
	PlayerTextDrawSetOutline(playerid, level[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, level[playerid], 255);
	PlayerTextDrawFont(playerid, level[playerid], 1);
	PlayerTextDrawSetProportional(playerid, level[playerid], 1);
	PlayerTextDrawSetShadow(playerid, level[playerid], 0);
	level2[playerid] = CreatePlayerTextDraw(playerid, 403.224212, 12.033300, "");
	PlayerTextDrawLetterSize(playerid, level2[playerid], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, level2[playerid], 2);
	PlayerTextDrawColor(playerid, level2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, level2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, level2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, level2[playerid], 255);
	PlayerTextDrawFont(playerid, level2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, level2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, level2[playerid], 0);
	return 1;
}

ShowPlayerLevel(playerid)
{
	new result, score, string[3];
	score = GetPlayerScore(playerid);
	ptime[playerid] = gettime()+DELAY;
	TextDrawShowForPlayer(playerid, ball);
	TextDrawShowForPlayer(playerid, ball2);
	PlayerTextDrawShow(playerid, level[playerid]);
	PlayerTextDrawShow(playerid, level2[playerid]);
	ShowPlayerProgressBar(playerid, lvl_bar[playerid]);
	for(new i = 0; i < sizeof(levels)-1; i++)
	{
	    if(score >= levels[i] && score < levels[i+1])
	    {
	        format(string, 3, "%d", i+1);
	        PlayerTextDrawSetString(playerid, level[playerid], string);
			format(string, 3, "%d", i+2);
			PlayerTextDrawSetString(playerid, level2[playerid], string);
			result = score-levels[i];
			SetPlayerProgressBarValue(playerid, lvl_bar[playerid], float(result)/float((levels[i+1]-levels[i]))*100.0);
	        return 1;
	    }
	}
    format(string, 3, "%d", sizeof(levels));
	PlayerTextDrawSetString(playerid, level[playerid], string);
	PlayerTextDrawSetString(playerid, level2[playerid], "");
	SetPlayerProgressBarValue(playerid, lvl_bar[playerid], 100.0);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & BAR_KEY)
	{
	    ShowPlayerLevel(playerid);
	}
	return 1;
}

HidePlayerLevel(playerid)
{
    TextDrawHideForPlayer(playerid, ball);
	TextDrawHideForPlayer(playerid, ball2);
	PlayerTextDrawHide(playerid, level[playerid]);
	PlayerTextDrawHide(playerid, level2[playerid]);
	HidePlayerProgressBar(playerid, lvl_bar[playerid]);
	ptime[playerid] = 0;
	return 1;
}

task HideLevelPlayer[1000]()
{
	foreach(new i : Player)
	{
	    if(!ptime[i]) continue;
	    if(gettime() < ptime[i]) continue;
	    HidePlayerLevel(i);
	}
	return 1;
}

DestroyPlayerLevel(playerid)
{
	TextDrawHideForPlayer(playerid, ball);
	TextDrawHideForPlayer(playerid, ball2);
	PlayerTextDrawDestroy(playerid, level[playerid]);
	PlayerTextDrawDestroy(playerid, level2[playerid]);
	DestroyPlayerProgressBar(playerid, lvl_bar[playerid]);
	level[playerid] = PlayerText:0xFFFF;
	level2[playerid] = PlayerText:0xFFFF;
	lvl_bar[playerid] = PlayerBar:0xFFFF;
	ptime[playerid] = 0;
	return 1;
}

public OnPlayerConnect(playerid)
{
    CreatePlayerLevel(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    DestroyPlayerLevel(playerid);
	return 1;
}