**Free
//==============================================================================
//     Program: GNR8035
// Description: Check for record lock and return lock info
//     Purpose: Checks if record @RRN is locked in @Schema/@Table.
//              Returns @IsLocked indicator and @LockedByData.
//==============================================================================

//==============================================================================
// C O M P I L E R  O P T I O N S

Ctl-Opt DftActGrp(*No) Option(*SrcStmt : *NoDebugIO);


//==============================================================================
// D A T A  S T R U C T U R E S

Dcl-Ds LockedByData Qualified Inz;
  JobName               VarChar(10);
  JobUser               VarChar(10);
  JobNumber             Varchar(6);
  JobStatus             VarChar(6);
  JobType               VarChar(28);
  JobSubsystem          VarChar(10);
  JobDate               Date(*ISO);
  JobDescriptionLibrary VarChar(10); 
  JObDescription        VarChar(10);
  JobEnteredSystemTime  Timestamp();
End-Ds;


//==============================================================================
// G L O B A L  V A R I A B L E S

Dcl-S EndProgram Ind Inz(*Off);
DCl-S JobName    VarChar(28);


//==============================================================================
// G L O B A L  C O N S T A N T S

// Generic constants (i.e. true, false, pass, fail, etc.)
/Include QCPYLESRC,GNR7000


//==============================================================================
// E X T E R N A L  P R O C E D U R E S

// Parameters
Dcl-Pi GNR8035;
  @Schema       VarChar(10);
  @Table        VarChar(10);
  @RRN          Zoned(15:0);
  @IsLocked     Ind Inz(*Off);
  @LockedByData LikeDs(LockedByData);
  @SQLCod       Like(SQLCOD) Dim(2);
End-Pi;

// Setup SQL Environment
Exec SQL
  Set Option
      Commit    = *None
    , DlyPrp    = *No
    , CloSqlCsr = *EndMod
    , DatFmt    = *ISO
    , Naming    = *Sys;


//==============================================================================
// M A I N

// Get job name for record lock
Exec SQL
  Select Job_Name 
    Into :JobName
    From QSYS2.Record_Lock_Info
    Where Table_Schema = :@Schema And Table_Name = :@Table 
          And Relative_Record_Number = :@RRN
    Fetch First Row Only;
  // Move SQLCOD to array to return to caller 
  @SQLCod(1) = SQLCOD;          

  // Process based on SQLCOD result
  Select;

    // No records found. Record is NOT locked.
    When SQLCOD = 100;
      @IsLocked = False;

    // Record found & no errors. Record is locked.
    When SQLCOD = 0;
      @IsLocked = True;
      // Get job info for the locking job
      Exec SQL
        Select Job_Name_Short, Job_User, Job_Number, Job_Status
               , Job_Type_Enhanced, Job_Subsystem, Job_Date,
               , Job_Description_Library, Job_Description,
               , Job_Entered_System_Time
          Into :@LockedByData
          From Table(QSYS2.Job_Info( Job_Status_Filter => '*ACTIVE'
                                   , Job_User_Filter   => '*ALL' ))
          Where Job_Name = :JobName;
        // Move SQLCOD to array to return to caller
        @SQLCod(2) = SQLCOD;

    // SQL encountered an error. Error will be returned to caller via @SQLCod.
    Other;

  EndSl;
              

//------------------------------------------------------------------------------
// End Program
*Inlr = *On;
Return;


//==============================================================================
// S U B P R O C E D U R E S


