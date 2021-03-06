! { dg-do run  }
!
! Functional test of User Defined DT IO, unformatted WRITE/READ
!
! 1) Tests unformatted DTV write with other variables in the record
! 2) Tests reading back the recods written.
!
module p
  type :: person
    character (len=20) :: name
    integer(4) :: age
    contains
      procedure :: pwuf
      procedure :: pruf
      generic :: write(unformatted) => pwuf
      generic :: read(unformatted) => pruf
  end type person
contains
  subroutine pwuf (dtv,unit,iostat,iomsg)
    class(person), intent(in) :: dtv
    integer, intent(in) :: unit
    integer, intent(out) :: iostat
    character (len=*), intent(inout) :: iomsg
    write (unit=unit, iostat=iostat, iomsg=iomsg) dtv%name, dtv%age
  end subroutine pwuf

  subroutine pruf (dtv,unit,iostat,iomsg)
    class(person), intent(inout) :: dtv
    integer, intent(in) :: unit
    integer, intent(out) :: iostat
    character (len=*), intent(inout) :: iomsg
    read (unit = unit) dtv%name, dtv%age
  end subroutine pruf

end module p

program test
  use p
  type (person), save :: chairman
  character(3) :: tmpstr1, tmpstr2
  chairman%name="charlie"
  chairman%age=62

  open (unit=71, file='myunformatted_data.dat', form='unformatted')
  write (71) "abc", chairman, "efg"
  write (71) "hij", chairman, "klm"
  write (71) "nop", chairman, "qrs"
  rewind (unit = 71)
  chairman%name="boggle"
  chairman%age=1234
  read (71) tmpstr1, chairman, tmpstr2
  if (tmpstr1.ne."abc") stop 1
  if (tmpstr2.ne."efg") stop 1
  if (chairman%name.ne."charlie") stop 1
  if (chairman%age.ne.62) stop 1
  chairman%name="boggle"
  chairman%age=1234
  read (71) tmpstr1, chairman, tmpstr2
  if (tmpstr1.ne."hij") stop 1
  if (tmpstr2.ne."klm") stop 1
  if (chairman%name.ne."charlie") stop 1
  if (chairman%age.ne.62) stop 1
  chairman%name="boggle"
  chairman%age=1234
  read (71) tmpstr1, chairman, tmpstr2
  if (tmpstr1.ne."nop") stop 1
  if (tmpstr2.ne."qrs") stop 1
  if (chairman%name.ne."charlie") stop 1
  if (chairman%age.ne.62) stop 1
  close (unit = 71, status='delete')
end program test
