! { dg-do run }
! Test minloc for strings for different code paths

program main
  implicit none
  integer, parameter :: n=4
  character(len=4), dimension(n,n) :: c
  integer, dimension(n,n) :: a
  integer, dimension(2) :: res1, res2
  real, dimension(n,n) :: r
  logical, dimension(n,n) :: amask
  logical(kind=8) :: smask
  integer :: i,j
  integer, dimension(n) :: q1, q2
  character(len=4,kind=4), dimension(n,n) :: c4
  character(len=4), dimension(n*n) :: e
  integer, dimension(n*n) :: f
  logical, dimension(n*n) :: cmask

  call random_number (r)
  a = int(r*100)
  do j=1,n
     do i=1,n
        write (unit=c(i,j),fmt='(I4.4)') a(i,j)
        write (unit=c4(i,j),fmt='(I4.4)') a(i,j)
     end do
  end do
  res1 = minloc(c)
  res2 = minloc(a)

  if (any(res1 /= res2)) stop 1
  res1 = minloc(c4)
  if (any(res1 /= res2)) stop 1

  amask = a < 50
  res1 = minloc(c,mask=amask)
  res2 = minloc(a,mask=amask)

 if (any(res1 /= res2)) stop 1

 amask = .false.
 res1 = minloc(c,mask=amask)
 if (any(res1 /= 0)) stop 1

 amask(2,3) = .true.
 res1 = minloc(c,mask=amask)
 if (any(res1 /= [2,3])) stop 1

 res1 = minloc(c,mask=.false.)
 if (any(res1 /= 0)) stop 1

 res2 = minloc(a)
 res1 = minloc(c,mask=.true.)
 if (any(res1 /= res2)) stop 1

 q1 = minloc(c, dim=1)
 q2 = minloc(a, dim=1)
 if (any(q1 /= q2)) stop 1

 q1 = minloc(c, dim=2)
 q2 = minloc(a, dim=2)
 if (any(q1 /= q2)) stop 1

 q1 = minloc(c, dim=1, mask=amask)
 q2 = minloc(a, dim=1, mask=amask)
 if (any(q1 /= q2)) stop 1

 q1 = minloc(c, dim=2, mask=amask)
 q2 = minloc(a, dim=2, mask=amask)
 if (any(q1 /= q2)) stop 1

  amask = a < 50

 q1 = minloc(c, dim=1, mask=amask)
 q2 = minloc(a, dim=1, mask=amask)
 if (any(q1 /= q2)) stop 1

 q1 = minloc(c, dim=2, mask=amask)
 q2 = minloc(a, dim=2, mask=amask)
 if (any(q1 /= q2)) stop 1

 e = reshape(c, shape(e))
 f = reshape(a, shape(f))
 if (minloc(e,dim=1) /= minloc(f,dim=1)) stop 1

 cmask = .false.
 if (minloc(e,dim=1,mask=cmask) /= 0) stop 1

 cmask = f > 50
 if ( minloc(e, dim=1, mask=cmask) /= minloc (f, dim=1, mask=cmask)) stop 1
end program main
