#include <a_samp>

new Text:wasted;
new Text:wasted2;
new Text:wasted3;

public OnFilterScriptInit()
{
	wasted = TextDrawCreate(-0.9999, 0.0147, "_");
	TextDrawLetterSize(wasted, 0.0000, 49.8333);
	TextDrawTextSize(wasted, 642.0000, 0.0000);
	TextDrawAlignment(wasted, 1);
	TextDrawColor(wasted, -1);
	TextDrawUseBox(wasted, 1);
	TextDrawBoxColor(wasted, -1869574128);
	TextDrawBackgroundColor(wasted, 255);
	TextDrawFont(wasted, 1);
	TextDrawSetProportional(wasted, 1);
	TextDrawSetShadow(wasted, 0);
	wasted2 = TextDrawCreate(-247.6666, 95.2666, "");
	TextDrawTextSize(wasted2, 1115.0000, 158.0000);
	TextDrawAlignment(wasted2, 1);
	TextDrawColor(wasted2, 128);
	TextDrawFont(wasted2, 5);
	TextDrawSetProportional(wasted2, 0);
	TextDrawSetShadow(wasted2, 0);
	TextDrawSetPreviewModel(wasted2, 19846);
	TextDrawBackgroundColor(wasted2, 0x00000000);
	TextDrawSetPreviewRot(wasted2, 90.0000, 0.0000, 270.0000, 1.0000);
	wasted3 = TextDrawCreate(285.0000, 158.4183, "~r~WASTED");
	TextDrawLetterSize(wasted3, 0.5663, 4.4829);
	TextDrawAlignment(wasted3, 1);
	TextDrawColor(wasted3, -1);
	TextDrawBackgroundColor(wasted3, 255);
	TextDrawFont(wasted3, 1);
	TextDrawSetProportional(wasted3, 1);
	TextDrawSetShadow(wasted3, 0);
	return 1;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(wasted);
	TextDrawDestroy(wasted2);
	TextDrawDestroy(wasted3);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	TextDrawShowForPlayer(playerid, wasted);
	TextDrawShowForPlayer(playerid, wasted2);
	TextDrawShowForPlayer(playerid, wasted3);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate != 7 && oldstate == 7)
	{
		TextDrawHideForPlayer(playerid, wasted);
		TextDrawHideForPlayer(playerid, wasted2);	
		TextDrawHideForPlayer(playerid, wasted3);
	}
	return 1;
}
