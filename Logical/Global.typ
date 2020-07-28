
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
		Status : MainStatus_type;
		Cmd : MainCmd_type;
	END_STRUCT;
	MainCmd_type : 	STRUCT 
		HeatOn : BOOL;
	END_STRUCT;
	MainStatus_type : 	STRUCT 
	END_STRUCT;
	DIO_type : 	STRUCT 
		ZoneTemps : ARRAY[0..3]OF INT;
		HeatOnIndicators : ARRAY[0..3]OF BOOL;
		ZoneFans : ARRAY[0..2]OF BOOL;
		DisturbanceFan : BOOL;
	END_STRUCT;
END_TYPE
