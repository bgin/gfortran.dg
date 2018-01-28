! { dg-do run }
!
! Test the behavior of lbound, ubound of shape with assumed rank arguments
! in an array context (without DIM argument).
!

program test

  integer              :: a(2:4,-2:5)
  integer, allocatable :: b(:,:)
  integer, allocatable :: c(:,:)
  integer, pointer     :: d(:,:)
  character(52)        :: buffer

  b = foo(a)
  !print *,b(:,1)
  if (any(b(:,1) /= [11, 101])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,1)
  if (buffer /= '          11         101') stop 1

  !print *,b(:,2)
  if (any(b(:,2) /= [3, 8])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,2)
  if (buffer /= '           3           8') stop 1

  !print *,b(:,3)
  if (any(b(:,3) /= [13, 108])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,3)
  if (buffer /= '          13         108') stop 1


  allocate(c(1:2,-3:6))
  b = bar(c)
  !print *,b(:,1)
  if (any(b(:,1) /= [11, 97])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,1)
  if (buffer /= '          11          97') stop 1

  !print *,b(:,2)
  if (any(b(:,2) /= [12, 106])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,2)
  if (buffer /= '          12         106') stop 1

  !print *,b(:,3)
  if (any(b(:,3) /= [2, 10])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,3)
  if (buffer /= '           2          10') stop 1


  allocate(d(3:5,-1:10))
  b = baz(d)
  !print *,b(:,1)
  if (any(b(:,1) /= [3, -1])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,1)
  if (buffer /= '           3          -1') stop 1

  !print *,b(:,2)
  if (any(b(:,2) /= [15, 110])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,2)
  if (buffer /= '          15         110') stop 1

  !print *,b(:,3)
  if (any(b(:,3) /= [13, 112])) stop 1
  buffer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  write(buffer,*) b(:,3)
  if (buffer /= '          13         112') stop 1


contains
  function foo(arg) result(res)
    integer :: arg(..)
    integer, allocatable :: res(:,:)

    allocate(res(rank(arg), 3))

    res(:,1) = lbound(arg) + (/ 10, 100 /)
    res(:,2) = ubound(arg)
    res(:,3) = (/ 10, 100 /) + shape(arg)

  end function foo
  function bar(arg) result(res)
    integer, allocatable :: arg(..)
    integer, allocatable :: res(:,:)

    allocate(res(-1:rank(arg)-2, 3))

    res(:,1) = lbound(arg) + (/ 10, 100 /)
    res(:,2) = (/ 10, 100 /) + ubound(arg)
    res(:,3) = shape(arg)

  end function bar
  function baz(arg) result(res)
    integer, pointer     :: arg(..)
    integer, allocatable :: res(:,:)

    allocate(res(2:rank(arg)+1, 3))

    res(:,1) = lbound(arg)
    res(:,2) = (/ 10, 100 /) + ubound(arg)
    res(:,3) = shape(arg) + (/ 10, 100 /)

  end function baz
end program test

