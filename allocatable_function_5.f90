! { dg-do run }
! Tests function return of deferred length scalars.
!
! Contributed by Paul Thomas  <pault@gcc.gnu.org>
!
module m
contains
  function mfoo (carg) result(res)
    character (:), allocatable :: res
    character (*) :: carg
    res = carg(2:4)
  end function
  function mbar (carg)
    character (:), allocatable :: mbar
    character (*) :: carg
    mbar = carg(2:13)
  end function
end module

  use m
  character (:), allocatable :: lhs
  lhs = foo ("foo calling ")
  if (lhs .ne. "foo") stop 1
  if (len (lhs) .ne. 3) stop 1
  deallocate (lhs)
  lhs = bar ("bar calling - baaaa!")
  if (lhs .ne. "bar calling") stop 1
  if (len (lhs) .ne. 12) stop 1
  deallocate (lhs)
  lhs = mfoo ("mfoo calling ")
  if (lhs .ne. "foo") stop 1
  if (len (lhs) .ne. 3) stop 1
  deallocate (lhs)
  lhs = mbar ("mbar calling - baaaa!")
  if (lhs .ne. "bar calling") stop 1
  if (len (lhs) .ne. 12) stop 1
contains
  function foo (carg) result(res)
    character (:), allocatable :: res
    character (*) :: carg
    res = carg(1:3)
  end function
  function bar (carg)
    character (:), allocatable :: bar
    character (*) :: carg
    bar = carg(1:12)
  end function
end
