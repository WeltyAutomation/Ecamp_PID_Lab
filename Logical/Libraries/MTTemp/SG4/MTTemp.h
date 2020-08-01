/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _MTTEMP_
#define _MTTEMP_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <brsystem.h>
#include <sys_lib.h>
#include <MTTypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define mtTMP_WRN_SYSTEM_IN_SATURATION (-2131749998)
 #define mtTMP_WRN_PROFILE_PAR_INVALID (-2131749999)
 #define mtTMP_ERR_INIT_TEMP_INVALID (-1058008171)
 #define mtTMP_ERR_PROFILE_PAR_INVALID (-1058008174)
 #define mtTMP_WRN_OUTPUT_LIMITS_INVALID (-2131750002)
 #define mtTMP_ERR_OUTPUT_LIMITS_INVALID (-1058008175)
 #define mtTMP_WRN_PREDICTION_SWITCHING (-2131750005)
 #define mtTMP_WRN_MODE_INVALID (-2131750003)
 #define mtTMP_WRN_SET_POINT_TEMP_INVALID (-2131750004)
 #define mtTMP_ERR_MODE_INVALID (-1058008176)
 #define mtTMP_ERR_AMBIENT_TEMP_INVALID (-1058008177)
 #define mtTMP_ERR_SET_POINT_TEMP_INVALID (-1058008182)
 #define mtTMP_WRN_COOL_DOWN_TEMP_INVALID (-2131750006)
 #define mtTMP_WRN_SYSTEM_NOT_SETTLED (-2131750007)
 #define mtTMP_WRN_DEFICIENT_IDENT_INFO (-2131750000)
 #define mtTMP_WRN_SYSTEM_INACCURATE (-2131750001)
 #define mtTMP_ERR_CONTROL_STATUS_INVALID (-1058008178)
 #define mtTMP_ERR_SYSTEM_NOT_SETTLED (-1058008179)
 #define mtTMP_ERR_COOL_DOWN_TEMP_INVALID (-1058008180)
 #define mtTMP_ERR_SET_POINT_TEMP_TOO_LOW (-1058008181)
 #define mtTMP_ERR_NUM_OF_ZONES_INVALID (-1058008183)
 #define mtTMP_WRN_PLANT_PAR_INVALID (-2131750008)
 #define mtTMP_ERR_PLANT_PAR_INVALID (-1058008184)
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST signed long mtTMP_WRN_SYSTEM_IN_SATURATION;
 _GLOBAL_CONST signed long mtTMP_WRN_PROFILE_PAR_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_INIT_TEMP_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_PROFILE_PAR_INVALID;
 _GLOBAL_CONST signed long mtTMP_WRN_OUTPUT_LIMITS_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_OUTPUT_LIMITS_INVALID;
 _GLOBAL_CONST signed long mtTMP_WRN_PREDICTION_SWITCHING;
 _GLOBAL_CONST signed long mtTMP_WRN_MODE_INVALID;
 _GLOBAL_CONST signed long mtTMP_WRN_SET_POINT_TEMP_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_MODE_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_AMBIENT_TEMP_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_SET_POINT_TEMP_INVALID;
 _GLOBAL_CONST signed long mtTMP_WRN_COOL_DOWN_TEMP_INVALID;
 _GLOBAL_CONST signed long mtTMP_WRN_SYSTEM_NOT_SETTLED;
 _GLOBAL_CONST signed long mtTMP_WRN_DEFICIENT_IDENT_INFO;
 _GLOBAL_CONST signed long mtTMP_WRN_SYSTEM_INACCURATE;
 _GLOBAL_CONST signed long mtTMP_ERR_CONTROL_STATUS_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_SYSTEM_NOT_SETTLED;
 _GLOBAL_CONST signed long mtTMP_ERR_COOL_DOWN_TEMP_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_SET_POINT_TEMP_TOO_LOW;
 _GLOBAL_CONST signed long mtTMP_ERR_NUM_OF_ZONES_INVALID;
 _GLOBAL_CONST signed long mtTMP_WRN_PLANT_PAR_INVALID;
 _GLOBAL_CONST signed long mtTMP_ERR_PLANT_PAR_INVALID;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum MTTempPlantEnum
{	mtTMP_NO_ELEMENT = 0,
	mtTMP_1ST_ORDER_LAG_ELEMENT_INT = 2,
	mtTMP_2ND_ORDER_LAG_ELEMENT = 3
} MTTempPlantEnum;

typedef enum MTTempModeEnum
{	mtTMP_NO_TUNING = 0,
	mtTMP_HEATING = 1,
	mtTMP_COOLING = 2,
	mtTMP_HEATING_COOLING = 3
} MTTempModeEnum;

typedef enum MTTempTuningModeEnum
{	mtTMP_HEAT_TUNING = 0,
	mtTMP_COOL_TUNING = 1,
	mtTMP_HEAT_COOL_TUNING = 2
} MTTempTuningModeEnum;

typedef enum MTTempTuningStateEnum
{	mtTMP_IDLE_STATE = 0,
	mtTMP_INIT_STATE = 1,
	mtTMP_SYSTEM_CHECK = 2,
	mtTMP_IDENT_DELAY_TIME = 3,
	mtTMP_IDENT_PARAMETERS = 4,
	mtTMP_PREDICTION = 5,
	mtTMP_SWITCH_SETPOINT = 6,
	mtTMP_IN_SETPOINT = 7,
	mtTMP_ERROR_STATE = 8,
	mtTMP_TUNING_ABORTED_BY_USER
} MTTempTuningStateEnum;

typedef enum MTTempSetPointChangeEnum
{	mtTMP_NO_CHANGE = 0,
	mtTMP_POSITIVE_CHANGE = 1,
	mtTMP_NEGATIVE_CHANGE = 2,
	mtTMP_POS_NEG_CHANGE = 3
} MTTempSetPointChangeEnum;

typedef enum MTTempProfileModeEnum
{	mtTMP_TIME_OPTIMIZED_PROFILE = 0,
	mtTMP_RATE_LIMITED_PROFILE = 1
} MTTempProfileModeEnum;

typedef enum MTTempProfileStateEnum
{	mtTMP_PROFILE_DISABLED = 0,
	mtTMP_PROFILE_READY = 1,
	mtTMP_PROFILE_IN_MOTION = 2,
	mtTMP_PROFILE_ABORTED_BY_USER = 3
} MTTempProfileStateEnum;

typedef struct MTTempCommunicationType
{	unsigned char FB;
	unsigned char Control;
	unsigned char Mode;
	unsigned char CurrentMode;
	unsigned char OPCStatus;
	unsigned char TuningPhase;
	unsigned char MultiZoneStatus;
	unsigned char CodeInformation;
} MTTempCommunicationType;

typedef struct MTTempPlantParaInternalType
{	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	float DelayTime;
	enum MTTempPlantEnum PlantType;
} MTTempPlantParaInternalType;

typedef struct MTTempPlantInternalType
{	struct MTTempPlantParaInternalType Heating;
	struct MTTempPlantParaInternalType Cooling;
} MTTempPlantInternalType;

typedef struct MTTempPlantParametersType
{	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	float DelayTime;
} MTTempPlantParametersType;

typedef struct MTTempPlantType
{	struct MTTempPlantParametersType Heating;
	struct MTTempPlantParametersType Cooling;
} MTTempPlantType;

typedef struct MTTempProfileParametersType
{	float SlewRate;
	float FilterTime;
	float DelayTime;
} MTTempProfileParametersType;

typedef struct MTTempProfileType
{	struct MTTempProfileParametersType Heating;
	struct MTTempProfileParametersType Cooling;
} MTTempProfileType;

typedef struct MTTempControllerType
{	struct MTPIDParametersType Heating;
	struct MTPIDParametersType Cooling;
} MTTempControllerType;

typedef struct MTTempTimeDelayFcnParaType
{	unsigned long DelayCounter;
	unsigned long ActBufferIndex;
	unsigned long ActBufferElements;
	unsigned long OldBufferElements;
	float DelayTimeAct;
	float* BufferPointer;
} MTTempTimeDelayFcnParaType;

typedef struct MTTempTimeDelayInternalType
{	float CycleTime;
	float DelayTime;
	plcbit ParametersValid;
	float InitialValue;
	plcbit Enable;
	struct MTTempTimeDelayFcnParaType TimeDelayFcnPara;
} MTTempTimeDelayInternalType;

typedef struct MTTempPIDType
{	float MaxOut;
	float MinOut;
	float IntegrationPartPresetValue;
	plcbit SetIntegrationPart;
	struct MTPIDParametersType Parameters;
	float ControlError;
	float ControlErrorOld;
	enum MTPIDIntegrationEnum HoldIntegration;
	float ProportionalPart;
	float IntegrationPart;
	float DerivativePart;
	float Out;
	enum MTPIDIntegrationEnum IntegrationStatus;
	float DerivativeError;
	signed long StatusID;
	float OutOld;
	float GainOld;
} MTTempPIDType;

typedef struct MTTempKalmanType
{	double StatesFactor[3];
	double DynamicFactor;
	double ErrorCovariance[3][3];
	double SystemStates[3];
	double OutputVector[3];
	double InputVector[3];
	double SystemMatrix[3][3];
} MTTempKalmanType;

typedef struct MTTempControllerInternalType
{	plcbit SetStartValues;
	plcbit FirstRun;
	plcbit FilterOn;
	plcbit PlantParametersHeatValid;
	plcbit PlantParametersCoolValid;
	float CycleTime;
	plcbit ParametersValid;
	plcbit PIDParametersCoolValid;
	plcbit PIDParametersHeatValid;
	struct MTTempControllerType PIDParameters;
	plcbit UpdateOld;
	plcbit EnableOld;
	float MaxHeatOut;
	float MaxCoolOut;
	enum MTTempModeEnum ModeObserver;
	enum MTTempModeEnum Mode;
	unsigned char StateOld;
	unsigned char State;
	unsigned char StateObserver;
	struct MTTempCommunicationType CommunicationInOld;
	struct MTTempCommunicationType CommunicationInCheck;
	struct MTTempCommunicationType CommunicationIn;
	plcbit SetCoolOutOld;
	plcbit SetHeatOutOld;
	float Output;
	struct MTTempPIDType PID;
	float TempOld;
	struct MTTempPlantType PlantParameters;
	float ActTempDerivative;
	float ActTempFiltered;
	float DelayOutput;
	float DelayInput;
	struct MTTempTimeDelayInternalType DelayTimeInternal;
	float SetTempOld;
	float FeedForwardHeatOld;
	float FeedForwardHeatCheck;
	float HeatOutOld;
	double SetDerivative;
	enum MTTempPlantEnum PlantHeatingType;
	enum MTTempPlantEnum PlantCoolingType;
	float AmbientTemperature;
	plcbit DenyJump;
	struct MTTempKalmanType KalmanFilter;
} MTTempControllerInternalType;

typedef struct MTTempControllerLimitsType
{	signed short Counter;
	plcbit MaxHeatOutSent;
	plcbit HandshakeComplete;
	plcbit MaxCoolOutDone;
	float FeedForwardStationary;
} MTTempControllerLimitsType;

typedef struct MTTempDelayTimeType
{	float DelayTimeApproximation;
	float DelayTime;
	unsigned char NrAdjustArray;
	signed short ActualTaperFactor;
	signed short TotalTaperFactor;
	float TemperatureSampleTime;
	unsigned char ArrayCounter;
	float TemperatureArray[200];
	signed short Samples;
	float SumTemperature;
	float SumActuatingVariable;
	plcbit Warning;
	plcbit Error;
	plcbit Done;
} MTTempDelayTimeType;

typedef struct MTTempSimulationModelType
{	struct MTTempPlantType PlantParameters[10];
	plcbit Noise;
} MTTempSimulationModelType;

typedef struct MTTempSimulationModelZoneType
{	float MaximumCoolingPower;
	float TimeConstantHeat;
	float TimeConstantCool;
	float alphaXAmb;
	float ThermalCapacityExtruder;
} MTTempSimulationModelZoneType;

typedef struct MTTempSimulationModelODEType
{	float PHeat[3];
	float PCool[3];
	float theta[3];
	float thetaMat[3];
	struct MTTempSimulationModelZoneType ZoneParameter;
} MTTempSimulationModelODEType;

typedef struct MTTempSimulationModelIntType
{	float CycleTime;
	plcbit ParametersValid;
	plcbit InhibitUpdate;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	struct MTTempSimulationModelType Parameters;
	unsigned char NumberOfZones;
	float DelayTimeCoolOut[10];
	float DelayTimeHeatOut[10];
	struct MTTempTimeDelayInternalType DelayTimeCool[10];
	struct MTTempTimeDelayInternalType DelayTimeHeat[10];
	struct MTTempSimulationModelODEType ODEParameter[10];
} MTTempSimulationModelIntType;

typedef struct MTTempSystemCheckType
{	unsigned long SettlingIndex;
	unsigned long MaxSettlingIndex;
	unsigned char NumberOfSettlingPhases;
	float LQUpdateMatrix[3];
	float LQOutput[2];
	float Noise;
	plcbit Error;
	plcbit Warning;
	float StartTemperature;
	plcbit Done;
	unsigned long Samples;
	float SumTemperature;
	float SumActuatingVariable;
} MTTempSystemCheckType;

typedef struct MTTempIntegralFilterType
{	double y;
	double yI;
	double yII;
	double u;
	double uI;
	double uII;
} MTTempIntegralFilterType;

typedef struct MTTempIdentificationType
{	double ParameterVector[3];
	double UpdateMatrix[9];
	float EstimationError;
	float WeightingFactor;
	unsigned short Samples;
	plcbit IdentificationValid;
	plcbit Warning;
	plcbit Stop;
	plcbit Done;
} MTTempIdentificationType;

typedef struct MTTempPredictionType
{	float t1;
	float t2;
	float FeedForwardStationary;
	float InitTemperature;
	float InitTime;
	plcbit CalcInitParameter;
	plcbit Warning;
	plcbit Error;
	plcbit Done;
} MTTempPredictionType;

typedef struct MTTempSwitchingType
{	plcbit Warning;
	plcbit Error;
	plcbit Done;
} MTTempSwitchingType;

typedef struct MTTempSetPointStabilityCheckType
{	unsigned long SettlingIndex;
	unsigned long MaxSettlingIndex;
	float SettlingTime;
	unsigned char NumberOfSettlingPhases;
	float LQUpdateMatrix[3];
	float LQOutput[2];
	float Noise;
	plcbit Error;
	plcbit Warning;
	plcbit Done;
} MTTempSetPointStabilityCheckType;

typedef struct MTTempSetPointChangeType
{	plcbit SetPointChangeValid;
	plcbit WithinTemperatureBand;
	float TimeForTemperatureCheck;
	float ActuatingVariableArray[10];
	plcbit Warning;
	plcbit Error;
	plcbit Done;
} MTTempSetPointChangeType;

typedef struct MTTempModelQualityType
{	float TimeArray[100];
	float TemperatureArray[100];
	float IT1TemperatureArray[100];
	float PT2TemperatureArray[100];
	unsigned char ArrayCounter;
	float DeltaTemperature;
	float HalfTemperature;
	float IT1MaxGain;
	float IT1MaxTimeConstant;
	float IT1MaxTime;
	float IT1MaxTemperature;
	float PT2MaxCurvature;
	float PT2MaxProduct;
	float PT2TimeOfPOI;
	float IT1SumSquareError;
	float PT2SumSquareError;
	unsigned char State;
	float EndTime;
	float EndTemperature;
	float SlopeOfLastValues;
	plcbit ComplexPT2;
	signed long CounterCheck;
	float ActTemptPOI;
} MTTempModelQualityType;

typedef struct MTTempParabelType
{	float Temperature;
	float Time;
	float Slope;
	float ParabelCoefficient;
	float ParabelTimeMultiplicator;
	float ParabelEndTime;
} MTTempParabelType;

typedef struct MTTempTuningInternalType
{	double CycleTime;
	plcbit QualityChange;
	plcbit ParabelCase;
	plcbit ForceParabel;
	plcbit Master;
	plcbit MultiZone;
	struct MTTempCommunicationType CommunicationIn;
	struct MTTempCommunicationType CommunicationOut;
	struct MTTempSystemCheckType SystemCheck;
	struct MTTempIntegralFilterType IntegralFilter;
	struct MTTempDelayTimeType DelayTime;
	struct MTTempControllerLimitsType ControllerLimits;
	struct MTTempIdentificationType IdentIT1;
	struct MTTempIdentificationType IdentPT2;
	struct MTTempPredictionType Prediction;
	struct MTTempSwitchingType Switching;
	struct MTTempControllerType DisturbanceController;
	struct MTTempSetPointStabilityCheckType SetPointStabilityCheck;
	struct MTTempSetPointChangeType SetPointChange;
	struct MTTempModelQualityType ModelQuality;
	struct MTTempPlantInternalType PlantParameters;
	struct MTTempPlantParaInternalType ActualPlantParameters;
	enum MTTempTuningModeEnum Mode;
	struct MTTempTimeDelayInternalType IdentHeatRingBuffer;
	struct MTTempTimeDelayInternalType IdentCoolRingBuffer;
	unsigned char ModelFirstPhase;
	unsigned char Model;
	float Time;
	float StartTime;
	float MaxFeedForwardHeat;
	float MaxFeedForwardCool;
	float HeatRingBufferOut;
	float CoolRingBufferOut;
	unsigned char TuningMode;
	plcbit TuningDone;
	plcbit StartSingleZoneOld;
	plcbit StartMultiZoneOld;
	float AmbientTemperature;
	float TemperatureOffset;
	float ActuatingVariableOffset;
	plcbit NewTuning;
	float ExpectedPT2Gain;
	float SetTemperature;
	float SetTemperatureOld;
	float SetPointTemperature;
	plcbit SetPointTemperatureOK;
	float TemperatureDiff;
	float TemperatureChange;
	float TemperatureChangeOld;
	float InitTemperatureCool;
	float CoolDownTemperature;
	plcbit EnableOld;
	float MaxHeatTrajectory;
	unsigned char State;
	unsigned char StateOld;
	plcbit AbortOld;
	plcbit EnableParametersValid;
	struct MTPIDParametersType LastValidPIDParameters;
	struct MTTempPlantParametersType LastValidPlantParameters;
	plcbit ParametersValid;
	struct MTTempParabelType ParabelParameters;
	struct MTTempProfileType ProfileParameters;
} MTTempTuningInternalType;

typedef struct MTTempProfileDataType
{	float SetTemperatureStart;
	float SetPointTemperature;
	float SlewRate;
	float FilterTime;
	float DelayTime;
	enum MTTempSetPointChangeEnum ActualOperatingMode;
	float MinSetPointTemperature;
	float MaxSetPointTemperature;
	float EndtimeOfConstantDerivative;
	float TimeDelayedFF;
	float TimeDelayed;
	double HeatAreaFF;
	double HeatArea;
	double HeatAreaSaturation;
	double TimeLong;
	float Time;
	float PlantCoolTimeDelay;
	float PlantHeatTimeDelay;
} MTTempProfileDataType;

typedef struct MTTemProfileIT1Type
{	double a0;
	double a1;
	double b0;
	double b1;
	double y[3];
	double u[3];
} MTTemProfileIT1Type;

typedef struct MTTempProfileTimeOptimizedType
{	float DeltaAmbient;
	float DeltaAmbientStart;
	float DeltaChange;
	float SwitchingTime1;
	float SwitchingTime2;
	float FeedForwardStationary;
} MTTempProfileTimeOptimizedType;

typedef struct MTTempProfileInternalType
{	float FeedForwardCoolDelayed;
	float FeedForwardHeatDelayed;
	float FeedForwardCool;
	float FeedForwardHeat;
	double CycleTime;
	plcbit EnableParametersValid;
	plcbit UpdateParametersValid;
	plcbit UpdateOld;
	plcbit EnableOld;
	struct MTTempPlantInternalType PlantParameters;
	float MaxHeatOut;
	float MaxCoolOut;
	enum MTTempProfileModeEnum Mode;
	float AmbientTemperature;
	enum MTTempSetPointChangeEnum PossibleOperatingMode;
	float InitTemperature;
	plcbit InitOld;
	plcbit AbortOld;
	plcbit StartOld;
	float MinFilterTime;
	float MinDelayTime;
	float MaxSlewRateGeneral;
	float MaxSlewRateConst;
	unsigned char StateOld;
	unsigned char State;
	struct MTTempProfileDataType ProfileData;
	plcbit InitDone;
	plcbit InSetPointEdge;
	plcbit InSetPointOld;
	plcbit InSetPoint;
	float SetTemperature[3];
	float SetTemperatureDelayed[3];
	plcbit ProfileDataValid;
	struct MTTemProfileIT1Type IT1Type;
	signed long StatusIDCommando;
	signed long StatusIDUpdate;
	plcbit FilterTimeMissing;
	plcbit PlantParametersMissing;
	plcbit SlewRateMissing;
	struct MTTempProfileTimeOptimizedType TimeOptimizedParameters;
	float SlewSystem;
	float SlewConst;
	struct MTTempProfileType ProfileParameters;
} MTTempProfileInternalType;

typedef struct MTTempController
{
	/* VAR_INPUT (analog) */
	struct MTTempControllerType PIDParameters;
	struct MTTempPlantType PlantParameters;
	float MaxHeatOut;
	float MaxCoolOut;
	float SetTemperature;
	float ActTemperature;
	float FeedForwardHeat;
	float FeedForwardCool;
	float HeatOutPresetValue;
	float CoolOutPresetValue;
	float HoldOut;
	signed long ControlStatusIn;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float HeatOut;
	float CoolOut;
	float ControlError;
	float ProportionalPart;
	float IntegrationPart;
	float DerivativePart;
	/* VAR (analog) */
	struct MTTempControllerInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetHeatOut;
	plcbit SetCoolOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTTempController_typ;

typedef struct MTTempProfile
{
	/* VAR_INPUT (analog) */
	struct MTTempPlantType PlantParameters;
	struct MTTempProfileType ProfileParameters;
	float MaxHeatOut;
	float MaxCoolOut;
	enum MTTempProfileModeEnum Mode;
	float AmbientTemperature;
	float SetPointTemperature;
	float InitTemperature;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float SetTemperature;
	float FeedForwardHeat;
	float FeedForwardCool;
	enum MTTempProfileStateEnum State;
	float RampUpTime;
	/* VAR (analog) */
	struct MTTempProfileInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit Start;
	plcbit Abort;
	plcbit Init;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit InSetPoint;
	plcbit InitDone;
} MTTempProfile_typ;

typedef struct MTTempSimulationModel
{
	/* VAR_INPUT (analog) */
	struct MTTempSimulationModelType Parameters;
	unsigned char NumberOfZones;
	float HeatIn[10];
	float CoolIn[10];
	float ScrewConveyorSpeed;
	float AmbientTemperature;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float ZoneTemperature[10];
	float MaterialTemperature[10];
	/* VAR (analog) */
	struct MTTempSimulationModelIntType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTTempSimulationModel_typ;

typedef struct MTTempTuning
{
	/* VAR_INPUT (analog) */
	float AmbientTemperature;
	float ActTemperature;
	float HeatIn;
	float CoolIn;
	enum MTTempTuningModeEnum Mode;
	float SetPointTemperature;
	float CoolDownTemperature;
	signed long ControlStatusIn;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float SetTemperature;
	float FeedForwardHeat;
	float FeedForwardCool;
	enum MTTempTuningStateEnum State;
	struct MTTempControllerType PIDParameters;
	struct MTTempPlantType PlantParameters;
	struct MTTempProfileType ProfileParameters;
	signed long ControlStatusOut;
	/* VAR (analog) */
	struct MTTempTuningInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit StartSingleZone;
	plcbit StartMultiZone;
	plcbit Abort;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit SystemCheckActive;
	plcbit TuningActive;
	plcbit TuningDone;
	plcbit PIDParametersValid;
	plcbit PlantParametersValid;
	plcbit ProfileParametersValid;
} MTTempTuning_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MTTempController(struct MTTempController* inst);
_BUR_PUBLIC void MTTempProfile(struct MTTempProfile* inst);
_BUR_PUBLIC void MTTempSimulationModel(struct MTTempSimulationModel* inst);
_BUR_PUBLIC void MTTempTuning(struct MTTempTuning* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MTTEMP_ */

