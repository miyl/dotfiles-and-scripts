/* See LICENSE file for copyright and license details. */

/* appearance */
/* static const char font[]            = "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*"; */
static const char font[]            = "-artwiz-nu-*-*-*-*-11-*-*-*-*-*-iso10646-*";
/* static const char font[]            = "";*/
static const char normbordercolor[] = "#3f3f3f";
/* static const char normbgcolor[]     = "#1a1E1C"; */
static const char normbgcolor[]     = "#000000";
static const char normfgcolor[]     = "#aaaa9a";
static const char selbordercolor[]  = "#acbc90";
static const char selbgcolor[]      = "#1a1e1b";
static const char selfgcolor[]      = "#f0dfaf";
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "te", "ww", "i", "ii", "iii"};

static const Rule rules[] = {
	/* class            instance    title       tags mask     isfloating   monitor */
	{ "Gimp",           NULL,       NULL,       0,          True,         -1 },
	{ "Firefox",        NULL,       NULL,       2,	  		False,        -1 },
	{ "Thunderbird",    NULL,       NULL,       8,	  		False,        -1 },
	{ "Vlc",            NULL,       NULL,       8,	  		False,        -1 },
	{ "Deluge",         NULL,       NULL,       16,	  		False,        -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* Scratchpad: */
static const char scratchpadname[] = "Scratchpad"; /* make it unique, avoid name collision */
static const char *scratchpadcmd[] = { "urxvtc", "-title", scratchpadname, "-geometry", "80x20", "-bg", "#333", "-bd", "pink", NULL }; /* WM_NAME must be scratchpadname */
static const char *scratchpadcmd2[] = { "urxvtc", "-title", scratchpadname, "-geometry", "80x20", "-bg", "#333", "-bd", "pink", "-e", "vim", "/home/lys/txt/a.txt", NULL }; /* WM_NAME must be scratchpadname */

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/bash", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "urxvtc -fade 25", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_x,      spawn,          {.v = dmenucmd } },
	{ MODKEY,						XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	
	/* Lys: */	
	{ MODKEY,  			            XK_q,      quit,           {0} },
	{ MODKEY|ShiftMask,				XK_q,	   spawn,  SHCMD("sudo shutdown -r now") },
	{ MODKEY|ControlMask,			XK_q,	   spawn,  SHCMD("sudo shutdown -h now") },
	{ MODKEY|ControlMask,			XK_s,	   spawn,  SHCMD("sudo pm-hibernate --quirk-dpms-on") },
	{ MODKEY|ControlMask,			XK_z, 	   spawn,  SHCMD("/home/lys/sh/monoffLock.sh") },
	{ MODKEY,						XK_z, 	   spawn,  SHCMD("/home/lys/sh/monoff.sh") },
	{ MODKEY,						XK_v, 	   spawn,  SHCMD("/home/lys/sh/volume_controls/volume_up.sh") },
	{ MODKEY,						XK_c,	   spawn,  SHCMD("/home/lys/sh/volume_controls/volume_down.sh") },
	{ MODKEY|ControlMask,			XK_0,	   spawn,  SHCMD("/home/lys/sh/asoundrc_xchange.sh") },
	{ 0,							XK_Print,  spawn,  SHCMD("/home/lys/sh/screenshot.sh") },
	{ 0,							XK_Pause,  spawn,  SHCMD("/home/lys/sh/start_stop.sh") },
	{ MODKEY,						XK_comma,  spawn,  SHCMD("cmus-remote -r") },
	{ MODKEY,						XK_period, spawn,  SHCMD("cmus-remote -n") },
	{ MODKEY|ControlMask,			XK_comma,  spawn,  SHCMD("cmus-remote -k -5") },
	{ MODKEY|ControlMask,			XK_period, spawn,  SHCMD("cmus-remote -k +5") },
	{ 0,							XK_Scroll_Lock,		spawn,  SHCMD("/home/lys/sh/monoff.sh") },
/*	{ 0,							XK_F11,		spawn,  SHCMD("firefox") }, */
	{ 0,							XK_F12,		spawn, SHCMD("urxvtc -e cmus") },

	/* Scratchpad: */
	{ MODKEY|ControlMask, 			XK_ae,	   spawn, 			{.v = scratchpadcmd } }, /* for more scratchpads */
	{ MODKEY, 						XK_ae,     togglescratchpad,{.v = scratchpadcmd } },
	{ MODKEY, 						XK_oslash, togglescratchpad,{.v = scratchpadcmd2 } },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
/*	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)*/
/*	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },*/
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
