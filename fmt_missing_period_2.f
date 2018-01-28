! { dg-do run }
! { dg-options "-w -std=legacy" }
! PR27634 Missing period in format specifier. Test case derived from case given
! in PR.  Submitted by Jerry DeLisle  <jvdelisle@gcc.gnu.org>
      real          :: aval = 3.14
      character(6)  :: str = "xyz"
      character(12) :: input = "1234abcdef"
      read(input,'(f4,a6)') aval, str
      if (aval.ne.1234.0) stop 1
      if (str.ne."abcdef") stop 1
      aval = 0.0
      str = "xyz"
      read(input,'(d4,a6)') aval, str
      if (aval.ne.1234.0) stop 1
      if (str.ne."abcdef") stop 1
      end
