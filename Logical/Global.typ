
TYPE
	MainState_enum : 
		(
		MAIN_INIT,
		MAIN_IDLE,
		MAIN_HEAT,
		MAIN_AUTOTUNE,
		MAIN_SAVERECIPE,
		MAIN_LOADRECIPE,
		MAIN_ERROR
		);
	MainCtrl_type : 	STRUCT 
		Cmd : MainCmd_type;
	END_STRUCT;
	MainCmd_type : 	STRUCT 
		HeatOn : BOOL;
		AutotuneHeaters : BOOL;
	END_STRUCT;
	DIO_type : 	STRUCT 
		ZoneTemps : ARRAY[0..3]OF INT;
		HeatOn : ARRAY[0..3]OF BOOL;
		ZoneFans : ARRAY[0..2]OF BOOL;
		DisturbanceFan : BOOL;
	END_STRUCT;
	Error_type : 	STRUCT 
		ErrorActive : BOOL;
		ErrorSetID : UDINT;
		ErrorResetID : UDINT;
		ErrorName : STRING[100];
		LastState : MainState_enum;
		ErrorAcknowledgeID : UDINT;
	END_STRUCT;
END_TYPE
