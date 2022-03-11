# ibmi-projects
Repository of sample IBM i projects I am working on.

GNR8035 (SQLRPGLE): Leverages IBM i SQL views in QSYS2 to check for record lock and return info about the locking job.
Parms:
  Schema       VarChar(10) Const;
  Table        VarChar(10) Const;
  RRN          Zoned(15:0) Const;
  IsLocked     Ind;
  LockedByData LikeDs(LockedByData);
  SQLCod       Like(SQLCOD) Dim(2);
