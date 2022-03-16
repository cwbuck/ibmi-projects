**Free
//==============================================================================
//     Program: GNR8035_PR
// Description: Prototype for calling GNR8035 program
//==============================================================================

// Prevent duplicate /INCLUDEs
/If Not Defined(GNR8035_PR)
/Define GNR8035_PR
/Else
/Eof
/EndIf


//==============================================================================
// P R O T O T Y P E

Dcl-Pr GNR8035 ExtPgm('GNR8035');
  Schema       VarChar(10);
  Table        VarChar(10) Const;
  RRN          Zoned(15:0) Const;
  IsLocked     Ind;
  LockedByData LikeDs(LockedByData);
  SQLCod       Like(SQLCOD) Dim(2);
End-Pr;


//==============================================================================
// D A T A  S T R U C T U R E S

Dcl-Ds JobInfo Qualified Inz;
  ShortName             VarChar(10);
  User                  VarChar(10);
  Number                Varchar(6);
  Status                VarChar(6);
  Type                  VarChar(28);
  Subsystem             VarChar(10);
  Date                  Date(*ISO);
  JobDescriptionLibrary VarChar(10); 
  JobDescription        VarChar(10);
  EnteredSystemTime     Timestamp;
End-Ds;