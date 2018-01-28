! { dg-do run }
! PR25093 Stream IO test 10
! Contributed by Jerry DeLisle <jvdelisle@gcc.gnu.org>.
! Test case derived from that given in PR by Steve Kargl.
program stream_io_10
  implicit none
  integer(kind=4) :: a(4), b(4)
  integer(kind=8) :: thepos
  a = (/ 1, 2, 3, 4 /)
  b = a
  open(10, file="teststream_streamio_10", access="stream")
  write(10) a
  inquire(10, pos=thepos)
  if (thepos.ne.17) stop 1

  read(10, pos=1)
  inquire(10, pos=thepos)
  if (thepos.ne.1) stop 1

  write(10, pos=15)
  inquire(10, pos=thepos)
  if (thepos.ne.15) stop 1

  read(10, pos=3)
  inquire(10, pos=thepos)
  if (thepos.ne.3) stop 1

  write(10, pos=1)
  inquire(10, pos=thepos)
  if (thepos.ne.1) stop 1

  a = 0
  read(10) a
  if (any(a /= b)) stop 1

  close(10, status="delete")
end program stream_io_10
