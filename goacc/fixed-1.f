      INTEGER :: ARGC
      ARGC = COMMAND_ARGUMENT_COUNT ()

!$OMP PARALLEL
!$ACC PARALLEL COPYIN(ARGC)
      IF (ARGC .NE. 0) THEN
         stop 1
      END IF
!$ACC END PARALLEL
!$OMP END PARALLEL

      END
