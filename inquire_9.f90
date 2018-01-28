! PR fortran/24774
! { dg-do run }
  logical :: l
  l = .true.
  inquire (file='inquire_9 file that should not exist', exist=l)
  if (l) stop 1
  l = .true.
  inquire (unit=-16, exist=l)
  if (l) stop 1
  open (unit=16, file='inquire_9.tst')
  write (unit=16, fmt='(a)') 'Test'
  l = .false.
  inquire (unit=16, exist=l)
  if (.not.l) stop 1
  l = .false.
  inquire (file='inquire_9.tst', exist=l)
  if (.not.l) stop 1
  close (unit=16)
  l = .false.
  inquire (file='inquire_9.tst', exist=l)
  if (.not.l) stop 1
  open (unit=16, file='inquire_9.tst')
  close (unit=16, status='delete')
end
