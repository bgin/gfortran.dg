! { dg-do run }
!
! PR fortran/52585
!
! Test proc-pointer dummies with ASSOCIATE
!
! Contributed by Mat Cross of NAG
!
module m0
  abstract interface
    subroutine sub
    end subroutine sub
  end interface
  interface
    subroutine s(ss, isassoc)
      import sub
      logical :: isassoc
      procedure(sub), pointer, intent(in) :: ss
    end subroutine s
  end interface
end module m0

use m0, only : sub, s
procedure(sub) :: sub2, pp
pointer :: pp
pp => sub2
if (.not. associated(pp)) stop 1
if (.not. associated(pp,sub2)) stop 1
call s(pp, .true.)
pp => null()
if (associated(pp)) stop 1
if (associated(pp,sub2)) stop 1
call s(pp, .false.)
end

subroutine s(ss, isassoc)
  use m0, only : sub
  logical :: isassoc
  procedure(sub), pointer, intent(in) :: ss
  procedure(sub) :: sub2
  if (isassoc .neqv. associated(ss)) stop 1
  if (isassoc .neqv. associated(ss,sub2)) stop 1
end subroutine s

subroutine sub2
end subroutine sub2
