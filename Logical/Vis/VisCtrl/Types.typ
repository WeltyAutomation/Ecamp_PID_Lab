
TYPE
	VisAlarms_type : 	STRUCT 
		AlarmListConnect : MpAlarmXListUIConnectType;
	END_STRUCT;
	Vis_type : 	STRUCT 
		Alarms : VisAlarms_type;
	END_STRUCT;
	Page_enum : 
		(
		PAGE_START,
		PAGE_MAIN,
		PAGE_TREND,
		PAGE_ALARM,
		PAGE_ALARMHISTORY,
		PAGE_SETUP,
		PAGE_SDM
		);
END_TYPE
