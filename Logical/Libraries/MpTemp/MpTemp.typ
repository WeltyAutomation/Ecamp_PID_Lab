(*********** Enumerations ***********)

TYPE
	MpTempHCMConceptEnum : 
		( (*Concept of heat current monitoring.*)
		mpTEMP_HCM_CONCEPT_CCS := 0 (*The "Common current sensing" concept of heating current monitoring is used.*)
		);
	MpTempHCMOperationEnum : 
		( (*Choosing between continuous and discontinuous operation mode.*)
		mpTEMP_OPERATION_DISCONTINUOUS := 0, (*Heating current monitoring is only performed once for all zones.*)
		mpTEMP_OPERATION_CONTINUOUS := 1 (*Heating current monitoring is continuously performed for all zones.*)
		);
	MpTempHCMStateEnum : 
		( (*Describe the different state of the heat current monitioring procedure.*)
		mpTEMP_HCM_WAIT, (*Waiting for the start command.*)
		mpTEMP_HCM_MEASUREMENT, (*Current measurement on active zones.*)
		mpTEMP_HCM_INTERVAL, (*Time span between two heat current monitoring cycles.*)
		mpTEMP_HCM_IDLE (*Time span before the next heat current monitoring cycle starts.*)
		);
	MpTempHysteresisModeEnum : 
		( (*Hysteresis modi.*)
		mpTEMP_HYSTERESIS_ON := 0, (*Controller has freedom to heat and cool.*)
		mpTEMP_HYSTERESIS_OFF_HEAT_ONLY := 1, (*Controller is only allowed to heat.*)
		mpTEMP_HYSTERESIS_OFF_COOL_ONLY := 2 (*Controller is only allowed to cool.*)
		);
	MpTempProfileModeEnum : 
		( (*Mode for the profile generation.*)
		mpTEMP_PROFILE_MODE_OFF := 0, (*No profile generation and no feedforward calculation.*)
		mpTEMP_PROFILE_MODE_TIME_OPT := 1, (*Calculates a time-optimized set temperature profile and a corresponding feedfward control.*)
		mpTEMP_PROFILE_MODE_RATE_LIMITED := 2 (*Calculates a set temperature profile limited by the slew rate and a corresponding feedforward control.*)
		);
	MpTempProfileStateEnum : 
		( (*State of the profile generation.*)
		mpTEMP_PROFILE_STATE_DISABLED := 0, (*Function block not active.*)
		mpTEMP_PROFILE_STATE_READY := 1, (*System waits for input commands.*)
		mpTEMP_PROFILE_STATE_ACTIVE := 2 (*System outputs generated temperature profile.*)
		);
	MpTempProfileSyncModeEnum : 
		( (*Mode for the profile synchronization.*)
		mpTEMP_PROFILE_SYNC_OFF := 0, (*Profile synchronization is not used.*)
		mpTEMP_PROFILE_SYNC_AUTO := 1, (*Profile parameters for a synchronized behavior are determined automatically.*)
		mpTEMP_PROFILE_SYNC_USER := 2 (*Profile parameters for a synchronized behavior must be selected by the user.*)
		);
	MpTempPWMScheduleModeEnum : 
		( (*Mode for the PWM schedule.*)
		mpTEMP_PWM_MODE_SHIFT := 0, (*Shifts the entire pulse within a period.*)
		mpTEMP_PWM_MODE_SPLIT := 1 (*Splits up the pulse within a period.*)
		);
	MpTempTuningModeEnum : 
		( (*Mode for the tuning.*)
		mpTEMP_TUNING_MODE_OFF := 0, (*Tuning is switched off.*)
		mpTEMP_TUNING_MODE_HEAT := 1, (*Heat tuning only.*)
		mpTEMP_TUNING_MODE_HEAT_COOL := 2 (*Heat and cool tuning.*)
		);
	MpTempTuningSystemCheckEnum : 
		( (*Mode for the system check of the tuning.*)
		mpTEMP_TUNING_SYS_CHECK_SHORT := 0, (*A fast system is expected. System check duration is short (5s).*)
		mpTEMP_TUNING_SYS_CHECK_MEDIUM := 1, (*An average system is expected. System check duration is medium (30s).*)
		mpTEMP_TUNING_SYS_CHECK_LONG := 2 (*A slow system is expected. System check duration is long (100s).*)
		);
	MpTempTuningStateEnum : 
		( (*State of the tuning.*)
		mpTEMP_TUNING_STATE_IDLE := 0, (*System waits for input commands.*)
		mpTEMP_TUNING_STATE_INIT := 1, (*Initial state for MultizoneTuning.*)
		mpTEMP_TUNING_STATE_SYSTEM_CHECK := 2, (*System is checked for stable operating point.*)
		mpTEMP_TUNING_STATE_DELAY_TIME := 3, (*The time delay of the system is identified.*)
		mpTEMP_TUNING_STATE_IDENT := 4, (*The PID and plant parameters of the system are identified.*)
		mpTEMP_TUNING_STATE_PREDICTION := 5, (*Calculates the time for switching the actuating signal and computes the set temperature.*)
		mpTEMP_TUNING_STATE_IN_SETPOINT := 6, (*System is in SetPoint and waits for further input.*)
		mpTEMP_TUNING_STATE_ERROR := 99, (*An error occured.*)
		mpTEMP_TUNING_STATE_ABORTED := 100 (*Tuning aborted by user.*)
		);
	MpTempZoneTypeEnum : 
		( (*Type of the zone.*)
		mpTEMP_ZONE_TYPE_HEAT := 0, (*Zone for heating only.*)
		mpTEMP_ZONE_TYPE_COOL := 1, (*Zone for cooling only.*)
		mpTEMP_ZONE_TYPE_HEAT_COOL := 2 (*Zone for heating and cooling.*)
		);
END_TYPE

(*********** Config ********** *)

TYPE
	MpTempControllerConfigType : 	STRUCT  (*Configuration structure of the controller.*)
		Type : MpTempZoneTypeEnum := mpTEMP_ZONE_TYPE_HEAT; (*Type of the zone.*)
		AmbientTemperature : REAL := 25.0; (*Ambient temperature. Unit[�C].*)
		MaxHeatPower : REAL := 10.0; (*Maximum power when heating. Unit: [kW].*)
		MaxHeatOutput : REAL := 100.0; (*Upper manipulated variable limit for heating. Unit: [%].*)
		MaxCoolOutput : REAL := 100.0; (*Upper manipulated variable limit for cooling. Unit: [%].*)
		ProfileMode : MpTempProfileModeEnum := mpTEMP_PROFILE_MODE_RATE_LIMITED; (*Mode of the profile generation.*)
		SystemCheck : MpTempTuningSystemCheckEnum := mpTEMP_TUNING_SYS_CHECK_LONG; (*Duration of system check.*)
		SystemParameters : MpTempSystemType; (*Identified system parameters.*)
		PWMParameters : MpTempPWMType; (*PWM parameters.*)
		HCMParameters : MpTempHCMType; (*HCM parameters.*)
		TemperatureFilter : MpTempControllerFilterType; (*Filter parameters.*)
	END_STRUCT;
	MpTempGroupConfigType : 	STRUCT  (*Configuration structure of the group.*)
		EnableLoadBalancing : BOOL := TRUE; (*Enables or disables the load balancing.*)
		MaxHeatPower : REAL := 30.0; (*Maximum permissible average power for heating of all zones per pwm schedule period. Unit: [kW].*)
		PWMScheduleParameters : MpTempPWMScheduleType; (*PWM schedule parameters.*)
	END_STRUCT;
	MpTempHCMConfigType : 	STRUCT  (*Configuration structure of the heat current monitoring.*)
		CurrentSensingConcept : MpTempHCMConceptEnum := mpTEMP_HCM_CONCEPT_CCS; (*Concept for heating current monitoring.*)
		OperationMode : MpTempHCMOperationEnum := mpTEMP_OPERATION_CONTINUOUS; (*Operating mode that defines whether the measurement should be performed once only or continuously.*)
		MeasurementTime : REAL := 0.12; (*Time period of measurement in which the manipulated variable for heating is set to 100% [s].*)
		IntervalTime : REAL := 60.0; (*Time period in which the controller can compensate for measurement influence [s].*)
		IdleTime : REAL := 180.0; (*Time period after a complete HCM cycle [s]. This parameter is only relevant for operating mode mpTEMP_HCM_MODE_CONTINUOUS.*)
	END_STRUCT;
END_TYPE

(*********** Parameters ********** *)

TYPE
	MpTempToleranceBandType : 	STRUCT  (*Upper and lower tolerance band parameters.*)
		Lower : REAL := 2.0; (*Setpoint deviation that defines the lower limit of the tolerance band [�C] or [A].*)
		Upper : REAL := 2.0; (*Setpoint deviation that defines the upper limit of the tolerance band [�C] or [A].*)
	END_STRUCT;
	MpTempGroupParType : 	STRUCT  (*Parameter structure of the group.*)
		SynchronizeTuning : BOOL; (*Temperature of slowest zone serves as reference for all others.*)
		Profile : MpTempGroupProfileType; (*Profile parameters for a user defined profile.*)
	END_STRUCT;
	MpTempControllerParType : 	STRUCT  (*Parameter structure of the controller.*)
		PID : MpTempPIDType; (*PID controller parameters.*)
		Tuning : MpTempTuningType; (*Tuning parameters.*)
		Profile : MpTempControllerProfileType; (*Profile parameters.*)
		ToleranceBand : MpTempToleranceBandType; (*Tolerance band parameters.*)
		Hysteresis : MpTempHysteresisType; (*Parameteres for configuration of hysteresis between heating and cooling,*)
	END_STRUCT;
	MpTempTuningType : 	STRUCT  (*Tuning parameters.*)
		Mode : MpTempTuningModeEnum := mpTEMP_TUNING_MODE_HEAT; (*Mode for different kind of tunings.*)
		SetPointHeat : REAL := 160.0; (*Set point temperature for heating. Unit: [�C].*)
		SetPointCool : REAL := 100.0; (*Set point temperature for cooling. Unit: [�C].*)
	END_STRUCT;
	MpTempControllerProfileType : 	STRUCT  (*Profile parameters of the controller.*)
		Heat : MpTempProfileParType; (*Profile parameters for heating.*)
		Cool : MpTempProfileParType; (*Profile parameters for cooling.*)
		AttenuationFactor : REAL := 1.0; (*Factor to reduce the maximum manipulated variable limit only for the profile generation not for the controller. In this case the controller has more tolerance for correction.*)
	END_STRUCT;
	MpTempGroupProfileType : 	STRUCT  (*Profile parameters of the group.*)
		SynchronizationMode : MpTempProfileSyncModeEnum := mpTEMP_PROFILE_SYNC_AUTO; (*Mode of the profile synchronization.*)
		Heat : MpTempProfileParType; (*Profile parameters for heating.*)
		Cool : MpTempProfileParType; (*Profile parameters for cooling.*)
	END_STRUCT;
	MpTempProfileType : 	STRUCT  (*Profile parameters.*)
		Heat : MpTempProfileParType; (*Profile parameters for heating.*)
		Cool : MpTempProfileParType; (*Profile parameters for cooling.*)
	END_STRUCT;
	MpTempProfileParType : 	STRUCT  (*Profile parameters.*)
		SlewRate : REAL := 5.0; (*Limitation of the slope of the SetPointTemperature signal. Unit: [�C/s].*)
		FilterTime : REAL := 35.0; (*Filter time for the generated signal SetPointTemperature. Unit: [s].*)
		DelayTime : REAL := 1.0; (*Delay time for the generated signal SetPointTemperature. Unit: [s].*)
		QuickStart : BOOL := FALSE; (*Filter time at start is set to 0. Profile immediately starts with the defined slew rate.*)
	END_STRUCT;
	MpTempPIDType : 	STRUCT  (*PID controller parameters.*)
		Heat : MpTempPIDParType; (*PID parameters for heating.*)
		Cool : MpTempPIDParType; (*PID parameters for cooling.*)
	END_STRUCT;
	MpTempPIDParType : 	STRUCT  (*PID controller parameters.*)
		ProportionalGain : REAL := 6.0; (*Proportional gain.*)
		IntegrationTime : REAL := 5.0; (*Integral time constant for the integral component. Unit: [s].*)
		DerivativeTime : REAL := 1.0; (*Differential time constant for the derivative component. Unit: [s].*)
		FilterTime : REAL := 0.1; (*Filter time constant for the derivative component. Unit: [s].*)
	END_STRUCT;
	MpTempSystemType : 	STRUCT  (*Identified system parameters.*)
		Heat : MpTempSystemParType; (*Identified system parameters for heating.*)
		Cool : MpTempSystemParType; (*Identified system parameters for cooling.*)
	END_STRUCT;
	MpTempSystemParType : 	STRUCT  (*System parameters.*)
		Gain : REAL := 2.8; (*Gain factor. Unit [K/%].*)
		TimeConstant1 : REAL := 30.0; (*Time constant 1. Unit [s].*)
		TimeConstant2 : REAL := 2.0; (*Time constant 2. Unit [s].*)
		DelayTime : REAL := 1.0; (*Delay Time. Unit [s].*)
	END_STRUCT;
	MpTempPWMScheduleType : 	STRUCT  (*PWM schedule parameters.*)
		Heat : MpTempPWMScheduleParType; (*PWM schedule parameters for heating.*)
		Cool : MpTempPWMScheduleParType; (*PWM schedule parameters for cooling.*)
	END_STRUCT;
	MpTempPWMScheduleParType : 	STRUCT  (*PWM schedule parameters.*)
		Mode : MpTempPWMScheduleModeEnum := mpTEMP_PWM_MODE_SHIFT; (*Mode of the PWM schedule.*)
		Period : REAL := 1.0; (*Period time. Unit [s].*)
		MinPulseWidth : REAL := 0.0; (*Minimum length of one pulse. Unit: [s].*)
		MinPause : REAL := 0.0; (*Minimum length of one pause. Unit: [s].*)
	END_STRUCT;
	MpTempPWMType : 	STRUCT  (*PWM parameters.*)
		Heat : MpTempPWMParType; (*PWM parameters for heating.*)
		Cool : MpTempPWMParType; (*PWM parameters for cooling.*)
	END_STRUCT;
	MpTempPWMParType : 	STRUCT  (*PWM parameters.*)
		Period : REAL := 1.0; (*Period time. Unit [s].*)
		MinPulseWidth : REAL := 0.0; (*Minimum length of one pulse. Unit: [s].*)
		MinPause : REAL := 0.0; (*Minimum length of one pause. Unit: [s].*)
	END_STRUCT;
	MpTempHCMCurrentType : 	STRUCT  (*Measured current values of the 3 phases*)
		PhaseL1 : REAL := 0.0; (*Current for phase L1 [A].*)
		PhaseL2 : REAL := 0.0; (*Current for phase L2 [A].*)
		PhaseL3 : REAL := 0.0; (*Current for phase L3 [A].*)
	END_STRUCT;
	MpTempHCMType : 	STRUCT  (*Defining the current limits*)
		Enable : BOOL; (*Enables heating current monitoring.*)
		ReferenceCurrent : MpTempHCMCurrentType; (*Parameters for phase reference currents.*)
		MaximumCurrent : MpTempHCMCurrentType; (*Parameters for phase maximum currents.*)
		ToleranceBand : MpTempToleranceBandType; (*Parameters for the tolerance band that define reference value deviation.*)
	END_STRUCT;
	MpTempHysteresisType : 	STRUCT  (*Parameters for configuration of hysteresis of heating and cooling.*)
		Mode : MpTempHysteresisModeEnum; (*Defines which hysteresis mode is being used.*)
		Band : MpTempHysteresisBand; (*Defines the band for switching between heating and cooling.*)
	END_STRUCT;
	MpTempHysteresisBand : 	STRUCT  (*Hysteresis band parameters.*)
		HeatToCool : REAL := 2.0; (*Lower limit of the controller from which it begins to cool. [%]*)
		CoolToHeat : REAL := 2.0; (*Lower limit of the controller from which it begins to heat. [%]*)
	END_STRUCT;
	MpTempControllerFilterType : 	STRUCT  (*Parameters for the temperatuer filter.*)
		Enable : BOOL := TRUE; (*Enables temperature filtering.*)
		NoiseReduction : REAL := 1; (*Suppression of measurement noise. *)
	END_STRUCT;
END_TYPE

(*********** Info ***********)

TYPE
	MpTempControllerInfoType : 	STRUCT  (*Controller information.*)
		SetTemperature : REAL; (*Smooth set temperature profile. Unit: [�C].*)
		FeedForwardHeat : REAL; (*Feed-forward value for heating. Unit: [%].*)
		FeedForwardCool : REAL; (*Feed-forward value for cooling. Unit: [%].*)
		InTolerance : BOOL; (*The operating point has been reached and the actual temperature is within the temperature tolerance band.*)
		Tuning : MpTempTuningInfoType; (*Tuning infomation.*)
		Profile : MpTempControllerProfileInfoType; (*Profile information.*)
		Control : MpTempControlInfoType; (*Controller information.*)
		Simulation : MpTempSimulationInfoType; (*Simulation information.*)
		Diag : MpTempDiagType; (*Diagnostic structure for the function block*)
		HCM : MpTempControllerHCMInfoType; (*Contains the currents identified during the HCM measurement. *)
	END_STRUCT;
	MpTempGroupInfoType : 	STRUCT  (*Group information.*)
		Profile : MpTempGroupProfileInfoType; (*Profile information.*)
		HeatPower : MpTempGroupPowerType; (*Power information for heating.*)
		Diag : MpTempDiagType; (*Diagnostic structure for the function block*)
	END_STRUCT;
	MpTempInfoType : 	STRUCT  (*Additional information.*)
		Diag : MpTempDiagType; (*Diagnostic structure for the function block*)
	END_STRUCT;
	MpTempDiagType : 	STRUCT  (*Additional diagnostic information.*)
		StatusID : MpTempStatusIDType; (*StatusID diagnostic structure *)
	END_STRUCT;
	MpTempStatusIDType : 	STRUCT  (*Segmented StatusID output.*)
		ID : MpTempErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
	MpTempTuningInfoType : 	STRUCT  (*Tuning information.*)
		State : MpTempTuningStateEnum; (*States of the tuning procedure.*)
		PIDParameters : MpTempPIDType; (*Calculated PID parameters.*)
		SystemParameters : MpTempSystemType; (*Identified system parameters.*)
		ProfileParameters : MpTempProfileType; (*Identified profile parameters.*)
		Quality : MpTempTuningQualityType; (*Quality information.*)
		TemperatureFilter : MpTempTuningFilterType; (*Filter information.*)
	END_STRUCT;
	MpTempTuningQualityType : 	STRUCT  (*Quality information.*)
		Heat : USINT; (*Quality of the identified parameters for heating.*)
		Cool : USINT; (*Quality of the identified parameters for cooling.*)
	END_STRUCT;
	MpTempControllerProfileInfoType : 	STRUCT  (*Profile information of the controller.*)
		Active : BOOL; (*Profile generation is active.*)
		InSetPoint : BOOL; (*The SetTemperature operating point has been reached.*)
	END_STRUCT;
	MpTempControlInfoType : 	STRUCT  (*PID controller information.*)
		ControlError : REAL; (*Control error. Unit: [�C].*)
		ProportionalPart : REAL; (*Proportional component. Unit: [%].*)
		IntegrationPart : REAL; (*Integration component. Unit: [%].*)
		DerivativePart : REAL; (*Derivative component. Unit: [%].*)
		ActualTemperatureFiltered : REAL; (*Filtered actual temperature. Unit: [�C].*)
		ActualTemperatureDerivative : REAL; (*Derivative of the actual temperature. Unit: [�C/s].*)
		TemperatureFilterUsed : BOOL; (*Status of the temperature filter.*)
	END_STRUCT;
	MpTempSimulationInfoType : 	STRUCT  (*Simulation information.*)
		HeatValue : REAL; (*Manipulated variable for heating. Unit: [%].*)
		CoolValue : REAL; (*Manipulated variable for cooling. Unit: [%].*)
		ActualTemperature : REAL; (*Actual temperature. Unit: [�C].*)
	END_STRUCT;
	MpTempGroupProfileInfoType : 	STRUCT  (*Profile information of the group.*)
		Active : BOOL; (*Profile generation is active.*)
		InSetPoint : BOOL; (*The SetTemperature operating point has been reached.*)
		Heat : MpTempProfileParType; (*Profile parameters for heating determined by the zones for synchronous behavior.*)
		Cool : MpTempProfileParType; (*Profile parameters for cooling determined by the zones for synchronous behavior.*)
	END_STRUCT;
	MpTempGroupPowerType : 	STRUCT  (*Power information of the group.*)
		Actual : REAL; (*Actual average power of all zones per period. Unit: [kW].*)
		Required : REAL; (*Required average power of all zones per period. Unit: [kW].*)
		InLimitation : BOOL; (*The power of each zone has been limited.*)
	END_STRUCT;
	MpTempControllerHCMInfoType : 	STRUCT  (*Heat current monitoring information.*)
		AverageCurrentL1 : REAL; (*Average value of the current measurement of phase L1.*)
		AverageCurrentL2 : REAL; (*Average value of the current measurement of phase L2.*)
		AverageCurrentL3 : REAL; (*Average value of the current measurement of phase L3.*)
	END_STRUCT;
	MpTempHCMInfoType : 	STRUCT  (*Heat current monitoring information.*)
		State : MpTempHCMStateEnum; (*Provides information about  the actual state of the heat current monitioring procedure.*)
		Diag : MpTempDiagType; (*Diagnostic structure for the function block*)
	END_STRUCT;
	MpTempTuningFilterType : 	STRUCT  (*Parameters for the temperatuer filter.*)
		NoiseReduction : REAL := 1.0; (*Recommended suppression of measurement noise.*)
	END_STRUCT;
END_TYPE
