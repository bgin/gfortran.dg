! { dg-do run }
!
! PR fortran/48820
!
! Handle type/class for assumed-rank arrays
!
! FIXME: Passing a CLASS to a CLASS has to be re-enabled.
implicit none
type t
  integer :: i
end type

class(T), allocatable :: ac(:,:)
type(T), allocatable :: at(:,:)
integer :: i

allocate(ac(2:3,2:4))
allocate(at(2:3,2:4))

i = 0
call foo(ac)
call foo(at)
call bar(ac)
call bar(at)
if (i /= 12) stop 1

contains
  subroutine bar(x)
    type(t) :: x(..)
    if (lbound(x,1) /= 1 .or. lbound(x,2) /= 1) stop 1
    if (size(x) /= 6) stop 1
    if (size(x,1) /= 2 .or. size(x,2) /= 3) stop 1
    if (ubound(x,1) /= 2 .or. ubound(x,2) /= 3) stop 1
    i = i + 1
    call foo(x)
    call bar2(x)
  end subroutine
  subroutine bar2(x)
    type(t) :: x(..)
    if (lbound(x,1) /= 1 .or. lbound(x,2) /= 1) stop 1
    if (size(x) /= 6) stop 1
    if (size(x,1) /= 2 .or. size(x,2) /= 3) stop 1
    if (ubound(x,1) /= 2 .or. ubound(x,2) /= 3) stop 1
    i = i + 1
  end subroutine
  subroutine foo(x)
    class(t) :: x(..)
    if (lbound(x,1) /= 1 .or. lbound(x,2) /= 1) stop 1
    if (size(x) /= 6) stop 1
    if (size(x,1) /= 2 .or. size(x,2) /= 3) stop 1
    if (ubound(x,1) /= 2 .or. ubound(x,2) /= 3) stop 1
    i = i + 1
    call foo2(x)
!    call bar2(x) ! Passing a CLASS to a TYPE does not yet work
  end subroutine
  subroutine foo2(x)
    class(t) :: x(..)
    if (lbound(x,1) /= 1 .or. lbound(x,2) /= 1) stop 1
    if (size(x) /= 6) stop 1
    if (size(x,1) /= 2 .or. size(x,2) /= 3) stop 1
    if (ubound(x,1) /= 2 .or. ubound(x,2) /= 3) stop 1
    i = i + 1
  end subroutine
end 
