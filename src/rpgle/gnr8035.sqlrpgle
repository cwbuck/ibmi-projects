**Free
//==============================================================================
// C O M P I L E R  O P T I O N S

Ctl-Opt DftActGrp(*No) Option(*SrcStmt : *NoDebugIO);


//==============================================================================
// D A T A  S T R U C T U R E S

Dcl-Ds LockedByData Qualified Inz;
  
End-Ds;


//==============================================================================
// G L O B A L  V A R I A B L E S

Dcl-S EndProgram Ind Inz(*Off);


//==============================================================================
// G L O B A L  C O N S T A N T S


//==============================================================================
// E X T E R N A L  P R O C E D U R E S

// Parameters
Dcl-Pi GNR8035;
  @Schema       VarChar(10);
  @Table        VarChar(10);
  @RRN          Zoned(15:0);
  @IsLocked     Ind;
  @LockedByData ;
  @SQLCod       Like(SQLCOD);
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





//------------------------------------------------------------------------------
// End Program
*Inlr = *On;
Return;


//==============================================================================
// S U B P R O C E D U R E S

