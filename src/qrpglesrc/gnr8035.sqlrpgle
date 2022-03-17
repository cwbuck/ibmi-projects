**Free
//==============================================================================
//     Program: GNR8035
// Description: Check for record lock and return lock info
//     Purpose: Checks if record @RRN is locked in @Schema/@Table.
//              Returns @IsLocked indicator and @LockedByData.
//==============================================================================

//==============================================================================
// C O M P I L E R  O P T I O N S

Ctl-Opt NoMain;


//==============================================================================
// G L O B A L  C O N S T A N T S

// Generic constants (i.e. true, false, pass, fail, etc.)
/Include QCPYLESRC,GNR7000


//==============================================================================
// P R O C E D U R A L  D E F I N I T I O N S

// Prototypes
/Include QCPYLESRC,GNR8035_PR

// Setup SQL Environment
Exec SQL
  Set Option
      Commit    = *None
    , DlyPrp    = *No
    , CloSqlCsr = *EndMod
    , DatFmt    = *ISO
    , Naming    = *Sys;


//==============================================================================
// P R O C E D U R E S

//------------------------------------------------------------------------------
//   Procedure: Is_RcdLocked()
// Description: Check if record is locked and get the locking job name

Dcl-Proc Is_RcdLocked Export;

  Dcl-Pi *n Ind;
    @Schema         VarChar(10);        // Both
    @Table          VarChar(10) Const;  // In
    @RRN            Zoned(15:0) Const;  // In
    @LockingJobName VarChar(28);        // Out
    @SQLCOD         Like(SQLCOD);       // Out
  End-Pi;

  // If caller does not specify a schema or defers to '*LIBL', override with
  // first library containing table on caller's *LIBL
  If @Schema In %List('':'*LIBL');
    @Schema = Get_ObjLib(@Table:@SQLCOD);
  EndIf;

  // Check for record lock and get job name
  Exec SQL
    Select Job_Name 
      Into :@LockingJobName
      From QSYS2.Record_Lock_Info
      Where Table_Schema = :@Schema And Table_Name = :@Table 
            And Relative_Record_Number = :@RRN
      Fetch First Row Only;
  // Return SQL Code
  @SQLCOD = SQLCOD;  

  If SQLCOD = 0;
    Return True;
  Else;
    Return False;
  EndIf;

End-Proc;


//------------------------------------------------------------------------------
//   Procedure: Get_ObjLib
// Description: Get the first library in *LIBL for the specified object name

Dcl-Proc Get_ObjLib Export;
  
  Dcl-Pi *n VarChar(10);
    @ObjName VarChar(10) Const;  // In
    @SQLCOD  Like(SQLCOD);       // Out
  End-Pi;

  Dcl-S @ObjLib VarChar(10);

  Exec SQL
    Select ObjLib
      Into :@ObjLib
      From Table(QSYS2.Object_Statistics('*LIBL', '*ALL', :@ObjName));
  @SQLCOD = SQLCOD;

  Return @ObjLib;    
      
End-Proc;


//------------------------------------------------------------------------------
//   Procedure: Get_ActiveJobInfo()
// Description: Get job info data for a specific job name

Dcl-Proc Get_ActiveJobInfo Export;

  Dcl-Pi *n;
    @JobName VarChar(28);      // In
    @JobInfo LikeDS(JobInfo);  // Out
    @SQLCOD  Like(SQLCOD);     // Out
  End-Pi;

  Exec SQL
    Select Job_Name_Short, Job_User, Job_Number, Job_Status
         , Job_Type_Enhanced, Job_Subsystem, Job_Date
         , Job_Description_Library, Job_Description
         , Job_Entered_System_Time
      Into :@JobInfo
      From Table(QSYS2.Job_Info( Job_Status_Filter => '*ACTIVE'
                               , Job_User_Filter   => '*ALL' ))
      Where Job_Name = :@JobName;
    // Return SQL Code
  @SQLCOD = SQLCOD;

End-Proc;


