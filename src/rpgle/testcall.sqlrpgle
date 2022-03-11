**Free
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
  JobEnteredSystemTime  Timestamp;
End-Ds;


//==============================================================================
// G L O B A L  V A R I A B L E S

Dcl-S IsLocked Ind;
Dcl-S @SQLCod  Like(SQLCOD) Dim(2);
Dcl-S Schema   VarChar(10);



//==============================================================================
// G L O B A L  C O N S T A N T S


//==============================================================================
// E X T E R N A L  P R O C E D U R E S

// Check for record lock and return lock info
Dcl-Pr GNR8035 ExtPgm('GNR8035');
  Schema       VarChar(10);
  Table        VarChar(10) Const;
  RRN          Zoned(15:0) Const;
  IsLocked     Ind;
  LockedByData LikeDs(LockedByData);
  SQLCod       Like(SQLCOD) Dim(2);
End-Pr;

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

Schema = *Blank;
GNR8035 (Schema:'VRMRATEQ':90:IsLocked:LockedByData:@SQLCod);


//------------------------------------------------------------------------------
// End Program
*Inlr = *On;
Return;


//==============================================================================
// S U B P R O C E D U R E S

