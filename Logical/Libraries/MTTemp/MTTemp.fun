
{REDUND_CONTEXT} FUNCTION_BLOCK MTTempController (*This function block provides a closed loop control algorithm optimized for temperature systems.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*) (* *) (*#PAR#*)
		PIDParameters : MTTempControllerType; (*PID parameter.*) (* *) (*#PAR#*)
		PlantParameters : MTTempPlantType; (*Identified controlled system parameters of the MTTempTuning function block.*) (*#CMD#OPT#*)
		MaxHeatOut : REAL; (*Upper manipulated variable limit for heating. Unit: [%].*) (* *) (*#PAR#*)
		MaxCoolOut : REAL; (*Upper manipulated variable limit for cooling. Unit: [%].*) (* *) (*#PAR#*)
		Update : BOOL; (*Parameters are updated on a rising edge.*) (* *) (*#PAR#*)
		SetTemperature : REAL; (*Temperature setpoint. Unit: [°C].*) (* *) (*#CYC#*)
		ActTemperature : REAL; (*Measured temperature. Unit: [°C].*) (* *) (*#CYC#*)
		FeedForwardHeat : REAL; (*Feed-forward value for heating. Unit: [%].*) (* *) (*#CYC#*)
		FeedForwardCool : REAL; (*Feed-forward value for cooling. Unit: [%].*) (* *) (*#CYC#*)
		HeatOutPresetValue : REAL; (*Preset value for heating output.*) (* *) (*#CMD#OPT#*)
		SetHeatOut : BOOL; (*A rising edge sets the heating output.*) (* *) (*#CMD#OPT#*)
		CoolOutPresetValue : REAL; (*Preset value for cooling output.*) (* *) (*#CMD#OPT#*)
		SetCoolOut : BOOL; (*A rising edge sets the cooling output.*) (* *) (*#CMD#OPT#*)
		HoldOut : REAL; (*Freezes the function block.*) (* *) (*#CMD#OPT#*)
		ControlStatusIn : DINT; (*Control status of the tuning block.*) (* *) (*#CMD#*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*The function block is active.*) (* *) (*#PAR#*)
		Error : BOOL; (*Indicates an error.*) (* *) (*#PAR#*)
		StatusID : DINT; (*Status information.*) (* *) (*#PAR#*)
		UpdateDone : BOOL; (*Update completed.*) (* *) (*#PAR#*)
		HeatOut : REAL; (*Output for the heating manipulated variable. Unit: [%].*) (* *) (*#CYC#*)
		CoolOut : REAL; (*Output for the cooling manipulated variable. Unit: [%].*) (* *) (*#CYC#*)
		ControlError : REAL; (*Control error.*) (* *) (*#CMD#OPT#*)
		ProportionalPart : REAL; (*Proportional component.*) (* *) (*#CMD#OPT#*)
		IntegrationPart : REAL; (*Integral component.*) (* *) (*#CMD#OPT#*)
		DerivativePart : REAL; (*Derivative component.*) (* *) (*#CMD#OPT#*)
	END_VAR
	VAR
		Internal : MTTempControllerInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTTempProfile (*This function block provides setpoint generation as well as feed-forward control for temperature systems.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*) (* *) (*#PAR#*)
		PlantParameters : MTTempPlantType; (*Controlled system parameters. Used to generate the feed-forward control signals.*) (*#CMD#OPT#*)
		ProfileParameters : MTTempProfileType; (*Parameters for the mode mtTMP_RATE_LIMITED_PROFILE.*)
		MaxHeatOut : REAL; (*Upper manipulated variable limit for heating. Unit: [%].*) (* *) (*#PAR#*)
		MaxCoolOut : REAL; (*Upper manipulated variable limit for cooling. Unit: [%].*) (* *) (*#PAR#*)
		Mode : MTTempProfileModeEnum; (*Mode selection. A time-optimized or rate-limited trajectory can be selected.*)
		Update : BOOL; (*Parameters are updated on a rising edge.*) (* *) (*#PAR#*)
		AmbientTemperature : REAL; (*Ambient temperature. Unit: [°C]. *) (* *) (*#CYC#*)
		SetPointTemperature : REAL; (*Desired end value of the generated profile. Unit: [°C].*)
		Start : BOOL; (*A rising edge on Start outputs the calculated profile SetTemperature as well as the values for the FeedForwardHeat feed-forward control.*) (* *) (*#CMD#OPT#*)
		Abort : BOOL; (*A rising edge on Abort freezes the current SetTemperature and adjusts FeedForwardHeat for this stationary value.*) (* *) (*#CMD#OPT#*)
		InitTemperature : REAL; (*Temperature value for initialization Unit: [°C].*) (* *) (*#CMD#OPT#*)
		Init : BOOL; (*A rising edge on Init sets the SetTemperature output to the value InitTemperature and adjusts all internal states to it.*) (* *) (*#CMD#*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*The function block is active.*) (* *) (*#PAR#*)
		Error : BOOL; (*Indicates an error.*) (* *) (*#PAR#*)
		StatusID : DINT; (*Status information.*) (* *) (*#PAR#*)
		UpdateDone : BOOL; (*Update completed.*) (* *) (*#PAR#*)
		SetTemperature : REAL; (*Calculated target trajectory for the temperature. Unit: [°C].*) (* *) (*#CYC#*)
		FeedForwardHeat : REAL; (*Feed-forward value for heating. Unit: [%].*) (* *) (*#CYC#*)
		FeedForwardCool : REAL; (*Feed-forward value for cooling. Unit: [%].*) (* *) (*#CYC#*)
		State : MTTempProfileStateEnum; (*Information about the current state of the function block.*) (* *) (*#CYC#*)
		RampUpTime : REAL; (*Time until SetPointTemperature is reached. Unit: [s].*)
		InSetPoint : BOOL; (*The SetPointTemperature operating point has been reached.*) (* *) (*#CYC#*)
		InitDone : BOOL; (*Initialization complete.*) (* *) (*#CMD#OPT#*)
	END_VAR
	VAR
		Internal : MTTempProfileInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} FUNCTION_BLOCK MTTempSimulationModel (*This function block provides a simulation model for an extruder (max. 10 coupled zones).*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*) (* *) (*#PAR#*)
		Parameters : MTTempSimulationModelType; (*Configuration parameters for the function block.*) (* *) (*#PAR#*)
		Update : BOOL; (*Parameters are updated on a rising edge.*) (* *) (*#PAR#*)
		NumberOfZones : USINT; (*Number of simulated zones. *) (* *) (*#PAR#*)
		HeatIn : ARRAY[0..9] OF REAL; (*Input for the heating level (in percent of maximum heating level for the respective zone). Unit [%].*) (* *) (*#CYC#*)
		CoolIn : ARRAY[0..9] OF REAL; (*Input for the cooling level (in percent of maximum cooling level for the respective zone). Unit [%].*) (* *) (*#CYC#*)
		ScrewConveyorSpeed : REAL; (*Velocity of the screw. Unit: [rpm].*) (* *) (*#CYC#*)
		AmbientTemperature : REAL; (*Ambient temperature. Unit: [°C].*) (* *) (*#CYC#*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*The function block is active.*) (* *) (*#PAR#*)
		Error : BOOL; (*Indicates an error.*) (* *) (*#PAR#*)
		StatusID : DINT; (*Status information.*) (* *) (*#PAR#*)
		UpdateDone : BOOL; (*Update completed.*) (* *) (*#PAR#*)
		ZoneTemperature : ARRAY[0..9] OF REAL; (*Temperature in the respective zone. Unit: [°C].*) (* *) (*#CYC#*)
		MaterialTemperature : ARRAY[0..9] OF REAL; (*Material temperature in the respective zone. Unit: [°C].*) (* *) (*#CMD#OPT#*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MTTempSimulationModelIntType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} FUNCTION_BLOCK MTTempTuning (*This function block provides fully automated tuning for single or multi-zone temperature systems.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*) (* *) (*#PAR#*)
		AmbientTemperature : REAL; (*Ambient temperature. Unit: [°C].*)
		ActTemperature : REAL; (*Measured temperature. Unit: [°C].*) (* *) (*#CYC#*)
		HeatIn : REAL; (*Heating manipulated variable from MTTempController. Unit: [%].*) (* *) (*#CYC#*)
		CoolIn : REAL; (*Cooling manipulated variable from MTTempController. Unit: [%].*) (* *) (*#CYC#*)
		Mode : MTTempTuningModeEnum; (*Mode selection.*) (* *) (*#CMD#*)
		SetPointTemperature : REAL; (*Temperature setpoint for the tuning and operating point switchover. Unit: [°C].*) (* *) (*#CMD#*)
		CoolDownTemperature : REAL; (*Cool-down temperature for tuning. Unit: [°C].*) (* *) (*#CMD#*)
		StartSingleZone : BOOL; (*Starts a time-optimized tuning for this zone.*) (* *) (*#CMD#*)
		StartMultiZone : BOOL; (*Starts a time-optimized tuning for this and all other zones that are linked to the ControlStatus.*) (* *) (*#CMD#*)
		Abort : BOOL; (*A rising edge on Abort cancels the current tuning.*)
		ControlStatusIn : DINT; (*ControlStatus for synchronizing multiple zones.*) (* *) (*#CMD#*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*The function block is active.*) (* *) (*#PAR#*)
		Error : BOOL; (*Indicates an error.*) (* *) (*#PAR#*)
		StatusID : DINT; (*Status information.*) (* *) (*#PAR#*)
		SetTemperature : REAL; (*Calculated target trajectory for the temperature. Unit: [°C].*) (* *) (*#CYC#*)
		FeedForwardHeat : REAL; (*Feed-forward value for heating. Unit: [%].*) (* *) (*#CYC#*)
		FeedForwardCool : REAL; (*Feed-forward value for cooling. Unit: [%].*) (* *) (*#CYC#*)
		SystemCheckActive : BOOL; (*Checks whether the system is in a stable set point.*) (* *) (*#CMD#*)
		TuningActive : BOOL; (*Identification procedure is active.*) (* *) (*#CMD#*)
		TuningDone : BOOL; (*Identification complete.*) (* *) (*#CMD#*)
		State : MTTempTuningStateEnum; (*Information about the current state of the function block.*)
		PIDParameters : MTTempControllerType; (*Calculated PID parameters.*) (* *) (*#CMD#*)
		PIDParametersValid : BOOL; (*A rising edge indicates whether the PID parameters have been calculated.*) (* *) (*#CMD#*)
		PlantParameters : MTTempPlantType; (*Identified system parameters.*) (* *) (*#CMD#OPT#*)
		PlantParametersValid : BOOL; (*A rising edge indicates whether the system parameters have been identified.*) (* *) (*#CMD#OPT#*)
		ProfileParameters : MTTempProfileType; (*Calculated Profile parameters.*)
		ProfileParametersValid : BOOL; (*A rising edge indicates whether the profile parameters have been calculated.*)
		ControlStatusOut : DINT; (*ControlStatus for the temperature controller and for synchronizing multiple zones.*) (* *) (*#CMD#*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MTTempTuningInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK
